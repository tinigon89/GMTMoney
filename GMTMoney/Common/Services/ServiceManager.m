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
            NSSortDescriptor *sortDescriptor;
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"CurrSym"
                                                          ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedArray;
            sortedArray = [dailyRateList sortedArrayUsingDescriptors:sortDescriptors];
            [[NSUserDefaults standardUserDefaults] setObject:dailyRateList forKey:kDailyRateInfo];
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
        // NSArray *categoryList = [responsedict objectForKey:@"category"];
//        if (dailyRateList && [dailyRateList count] > 0) {
//            NSSortDescriptor *sortDescriptor;
//            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"CurrSym"
//                                                         ascending:YES];
//            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
//            NSArray *sortedArray;
//            sortedArray = [dailyRateList sortedArrayUsingDescriptors:sortDescriptors];
//            return YES;
//        }
    }
    return NO;;
    
}
@end
