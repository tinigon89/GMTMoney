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
#import "XMLReader.h"
@implementation ServiceManager

+ (BOOL)getDailyRates
{
    ASIFormDataRequest * request;
    
    NSURL *url = [NSURL URLWithString:kServer_Get_DailyRates];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    if ([request responseStatusCode] == 200)
    {
        NSLog(@"%@",request.responseString);
        NSArray *dailyRateList = [request.responseString JSONValue];
       // NSArray *categoryList = [responsedict objectForKey:@"category"];
        if (dailyRateList && [dailyRateList count] > 0) {
            NSMutableArray *insertArray = [dailyRateList mutableCopy];
            if (![[NSUserDefaults standardUserDefaults] objectForKey:kDailyRateInfo]) {
                for (int i = 0; i < [insertArray count]; i++) {
                    NSMutableDictionary *dict = [[insertArray objectAtIndex:i] mutableCopy];
                    [dict setObject:[NSNumber numberWithInt:i] forKey:@"order"];
                    [insertArray replaceObjectAtIndex:i withObject:dict];
                }
            }
            else
            {
                NSArray *oldList = [[NSUserDefaults standardUserDefaults] objectForKey:kDailyRateInfo];
                for (int i = 0; i < [insertArray count]; i++) {
                    NSMutableDictionary *dict = [[insertArray objectAtIndex:i] mutableCopy];
                    NSArray *tempArray = [oldList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"CurrSym = %@",[dict objectForKey:@"CurrSym"]]];
                    if ([tempArray count] > 0) {
                        [dict setObject:[NSNumber numberWithInt:[[[tempArray objectAtIndex:0] objectForKey:@"order"] intValue]]  forKey:@"order"];
                        [insertArray replaceObjectAtIndex:i withObject:dict];
                    }
                
                }
            }
            NSTimeInterval timeint = [[NSDate date] timeIntervalSince1970];
            [[NSUserDefaults standardUserDefaults] setDouble:timeint forKey:kLastestUpdate];
            [[NSUserDefaults standardUserDefaults] setObject:insertArray forKey:kDailyRateInfo];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return YES;
        }
    }
    return NO;;
}

+ (BOOL)getFeedWithURL:(NSString *)feedurl
{
    
    ASIFormDataRequest * request;
    
    NSURL *url = [NSURL URLWithString:feedurl];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    if ([request responseStatusCode] == 200)
    {
        NSLog(@"%@",request.responseString);
        NSString *responseStringOrigin = [request.responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        responseStringOrigin = [responseStringOrigin stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSDictionary *feedDict = [XMLReader dictionaryForXMLString:responseStringOrigin error:nil];
        if (feedDict && [feedDict objectForKey:@"rss"]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:[[feedDict objectForKey:@"rss"] objectForKey:@"channel"] forKey:feedurl];
            [[NSUserDefaults standardUserDefaults] synchronize];

        }
    }
    return NO;;
    
}

+ (BOOL)checkUser:(NSString *)user pass:(NSString *)pass
{
    
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:kServer_Get_Login,user,pass];
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    if ([request responseStatusCode] == 200)
    {
        NSLog(@"%@",request.responseString);
        if ([request.responseString length] == 0) {
            return NO;
        }
        NSString *response = [request.responseString stringByReplacingOccurrencesOfString:@":null" withString:@":\"\""];
        NSArray *userInfo = [response JSONValue];
        if (userInfo && [userInfo count] > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:[userInfo objectAtIndex:0]  forKey:kUserInfo];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return YES;
        }
    }
    return NO;
    
}

+ (BOOL)fogotpass:(NSString *)email
{
    
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:kServer_Get_Forgot,email];
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    if ([request responseStatusCode] == 200)
    {
        NSLog(@"%@",request.responseString);
        if ([request.responseString length] == 0) {
            return NO;
        }
        if ([request.responseString isEqualToString:@"OK"]) {
            return YES;
        }
        [Util showAlertWithString:request.responseString];
        return NO;
    }
    return NO;
    
}
@end
