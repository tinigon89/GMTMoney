//
//  ServiceManager.m
//  CountryGrocer
//
//  Created by Jacky Nguyen on 5/13/13.
//  Copyright (c) 2013 teamios. All rights reserved.
//

#import "ServiceManager.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "define.h"
#import "NSObject+SBJSON.h"
#import "NSString+SBJSON.h"
#import <AdSupport/AdSupport.h>
#import "CGItem+Custom.h"
@implementation ServiceManager
+ (void)postUserInfo
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userDefault objectForKey:kUserInfo];
    NSString *post = [dict JSONRepresentation];
    NSString *postString = [NSString stringWithFormat:@"content=%@",post];
    NSData *postData = [postString  dataUsingEncoding:NSUTF8StringEncoding];
    ASIFormDataRequest * request;
    NSURL *url = [NSURL URLWithString:kServer_Post_UserInfo];
    request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d", [postData length]]];
    [request setPostBody:[NSMutableData dataWithData:postData]];
    [request startSynchronous];
    
    if ([request responseStatusCode] == 200) {
        if ([request.responseString isEqualToString:@"true"])
        {
            NSLog(@"success");
        }
    }
}

+ (void)postDeviceInfo
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userDefault objectForKey:kDeviceInfo];
    if (!dict) {
        return;
    }
    NSString *post = [dict JSONRepresentation];
    NSString *postString = [NSString stringWithFormat:@"content=%@",post];
    NSData *postData = [postString  dataUsingEncoding:NSUTF8StringEncoding];
    ASIFormDataRequest * request;
    NSURL *url = [NSURL URLWithString:kServer_Post_DeviceInfo];
    request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request addRequestHeader:@"content-type" value:@"application/x-www-form-urlencoded"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d", [postData length]]];
    [request setPostBody:[NSMutableData dataWithData:postData]];
    [request startSynchronous];
    
    if ([request responseStatusCode] == 200) {
        if ([request.responseString isEqualToString:@"true"])
        {
            [userDefault setBool:YES forKey:kPostToken];
            [userDefault synchronize];
            NSLog(@"success");
        }
    }
}

+ (BOOL)getListwithType:(int)type
{
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:@"%@%i",kServer_Get_List,type];
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    BOOL isUpdate = NO;
    if ([request responseStatusCode] == 200) {
        NSDictionary *dict = [request.responseString JSONValue];
        if (dict)
        {
            NSMutableArray *oldArrayList = [[CGItem getCGItems:type] mutableCopy];
            NSArray *itemList = [dict objectForKey:@"ras"];
            for (NSDictionary *itemDict in itemList) {
                NSString *itemId = [itemDict objectForKey:@"id"];
                for (CGItem *oldItem in oldArrayList) {
                    if ([oldItem.uid isEqual:itemId]) {
                        [oldArrayList removeObject:oldItem];
                        break;
                    }
                }
                CGItem *item = [CGItem getCGItemByUID:itemId];
                if(!item)
                {
                    if([[itemDict objectForKey:@"expired"] isEqualToString:@"1"])
                    {
                        continue;
                    }
                    item = [CGItem newCGItem];
                    isUpdate = YES;
                }
                else if([[itemDict objectForKey:@"expired"] isEqualToString:@"1"])
                {
                    isUpdate = YES;
                    [CGItem deleteCGItem:item];
                    continue;
                }                
                
                if (item.editDate && ![item.editDate isEqualToString:[itemDict objectForKey:@"edit_date"]]) {
                    isUpdate = YES;
                    item.imageStorePath = nil;
                }
                item.uid = [itemDict objectForKey:@"id"];
                item.name = [itemDict objectForKey:@"name"];
                item.imageUrl = [itemDict objectForKey:@"pic"];
                if (IS_IPAD()) {
                    item.imageUrl = [NSString stringWithFormat:@"files/ipad/%@",[item.imageUrl lastPathComponent]];
                }
                item.itemDescription = [itemDict objectForKey:@"description"];
                item.price = [itemDict objectForKey:@"price"];
                item.itemType = [NSNumber numberWithInt:type];
                item.orderIndex = [NSNumber numberWithInt:[[itemDict objectForKey:@"order_custom"] intValue]];
                
                item.editDate = [itemDict objectForKey:@"edit_date"];
                [CGItem updateCGItem:item];
            }
            for (CGItem *oldItem in oldArrayList) {
                [CGItem deleteCGItem:oldItem];
                isUpdate = YES;
            }
        }
        NSString *key = [NSString stringWithFormat:@"category%i",type];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        if (![userDefault boolForKey:key]) {
            [userDefault setBool:isUpdate forKey:key];
            [userDefault synchronize];
        }
        NSLog(@"Get list type %i: completed",type);
        return YES;
    }
    NSLog(@"Get list type %i: Failed",type);
    return NO;
}
@end
