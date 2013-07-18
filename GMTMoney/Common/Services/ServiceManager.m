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

+ (BOOL)getCountryList
{
    
    ASIFormDataRequest * request;
    
    NSURL *url = [NSURL URLWithString:kServer_Get_CountryList];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    if ([request responseStatusCode] == 200)
    {
        NSString *response = [request.responseString stringByReplacingOccurrencesOfString:@":null" withString:@":\"\""];
        NSArray *countryList = [response JSONValue];
        if (countryList && [countryList count] > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:countryList  forKey:kCountryList];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return YES;
        }

    }
    return NO;
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

+ (BOOL)regist:(NSString *)user
          pass:(NSString *)pass
         email:(NSString *)email
         FName:(NSString *)FName
       SurName:(NSString *)SurName
       BisName:(NSString *)BisName
        DBirth:(NSString *)DBirth
      NationID:(int) NationID
      IdentyID:(int)IdentyID
        IdCode:(NSString *)IdCode
      IDExpiry:(NSString *)IDExpiry
      IDIssuer:(NSString *)IDIssuer
         Occup:(NSString *)Occup
       RStreet:(NSString *)RStreet
          RSub:(NSString *)RSub
        RState:(NSString *)RState
         RPost:(NSString *)RPost
    RCountryID:(int)RCountryID
       PStatus:(int)PStatus
       PStreet:(NSString *)PStreet
          PSub:(NSString *)PSub
        PState:(NSString *)PState
         PPost:(NSString *)PPost
    PCountryID:(int)PCountryID
         PCDet:(NSString *)PCDet
      PContact:(NSString *)PContact
         SCDet:(NSString *)SCDet
      SContact:(NSString *)SContact
    SourceD:(int)SourceD
{
    /*
     gmtmoney.com.au/iregister.aspx?Country1=1
     &Email=gmttest@test.com
     &UserName=gmttest
     &Password=123
     &FName=gmt
     &SurName=test
     &BisName=gbis
     &DBirth=1980/10/01
     &NationID=1
     &IdentyID=1
     &IdCode=12345
     &IDExpiry=2019/10/01
     &IDIssuer=idi
     &Occup=developer
     &RStreet=r1
     &RSub=r2
     &RState=r3
     &RPost=r4
     &RCountryID=5
     &PStatus=1
     &PStreet=p1
     &PSub=p2
     &PState=p3
     &PPost=p4
     &PCountryID=6
     &PContact=11111
     &SContact=22222
     &SourceD=1
     &PCDet=pc1
     &SCDet=pc2
     */
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:@"http://gmtmoney.com.au/iregister.aspx?Country1=1&Email=%@&UserName=%@&Password=%@&FName=%@&SurName=%@&BisName=%@&DBirth=%@&NationID=%i&IdentyID=%i&IdCode=%@&IDExpiry=%@&IDIssuer=%@&Occup=%@&RStreet=%@&RSub=%@&RState=%@&RPost=%@&RCountryID=%i&PStatus=%i&PStreet=%@&PSub=%@&PState=%@&PPost=%@&PCountryID=%i&PContact=%@&SContact=%@&SourceD=%i&PCDet=%@&SCDet=%@",email,user,pass,FName,SurName,BisName,DBirth,NationID,IdentyID,IdCode,IDExpiry,IDIssuer,Occup,RStreet,RSub,RState,RPost,RCountryID,PStatus,PStreet,PSub,PState,PPost,PCountryID,PContact,SContact,SourceD,PCDet,SCDet];
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

+ (BOOL)getTransactionStatus:(NSString *)regid
{
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:kServer_Get_Trans_Status,regid];
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    if ([request responseStatusCode] == 200)
    {
        //NSLog(@"%@",request.responseString);
        if ([request.responseString length] == 0) {
            return NO;
        }
        NSString *response = [request.responseString stringByReplacingOccurrencesOfString:@":null" withString:@":\"\""];
        NSArray *transStatusList = [response JSONValue];
        if ([transStatusList count] > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:transStatusList  forKey:kTransStatusInfo];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return YES;
        }
    }
    return NO;
}

+ (BOOL)getTransactionHistory:(NSString *)regid
{
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:kServer_Get_Trans_History,regid];
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    if ([request responseStatusCode] == 200)
    {
        //NSLog(@"%@",request.responseString);
        if ([request.responseString length] == 0) {
            return NO;
        }
        NSString *response = [request.responseString stringByReplacingOccurrencesOfString:@":null" withString:@":\"\""];
        NSArray *transStatusList = [response JSONValue];
        if ([transStatusList count] > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:transStatusList  forKey:kTransHistoryInfo];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return YES;
        }
    }
    return NO;
}

+ (BOOL)getSenderList:(NSString *)regid
{
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:kServer_Get_Sender,regid,@""];
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
        NSArray *transStatusList = [response JSONValue];
        if ([transStatusList count] > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:transStatusList  forKey:kSenderInfo];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return YES;
        }
    }
    return NO;
}

+ (NSArray *)searchSenderList:(NSString *)regid searchIndex:(int)searchIndex searchString:(NSString *)searchString
{
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:kServer_Get_Search_Sender,regid,searchIndex,searchString];
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    if ([request responseStatusCode] == 200)
    {
        NSLog(@"%@",request.responseString);
        if ([request.responseString length] == 0) {
            return nil;
        }
        NSString *response = [request.responseString stringByReplacingOccurrencesOfString:@":null" withString:@":\"\""];
        NSArray *senderList = [response JSONValue];
        if ([senderList count] > 0) {
            return senderList;
        }
    }
    return nil;
}

+ (NSArray *)searchBeneList:(NSString *)regid searchIndex:(int)searchIndex searchString:(NSString *)searchString
{
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:kServer_Get_Search_Bene,regid,searchIndex,searchString];
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    if ([request responseStatusCode] == 200)
    {
        NSLog(@"%@",request.responseString);
        if ([request.responseString length] == 0) {
            return nil;
        }
        NSString *response = [request.responseString stringByReplacingOccurrencesOfString:@":null" withString:@":\"\""];
        NSArray *senderList = [response JSONValue];
        if ([senderList count] > 0) {
            return senderList;
        }
    }
    return nil;
}

+ (BOOL)getBenList:(NSString *)regid
{
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:kServer_Get_Bene,regid];
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
        NSArray *transStatusList = [response JSONValue];
        if ([transStatusList count] > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:transStatusList  forKey:kBeneInfo];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return YES;
        }
    }
    return NO;
}

+ (BOOL)sendSMS:(NSString *)toNumber message:(NSString *)message
{
    
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:kServer_Get_Login,message,toNumber];
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    if ([request responseStatusCode] == 200)
    {
//        NSLog(@"%@",request.responseString);
//        if ([request.responseString length] == 0) {
//            return NO;
//        }
//        NSString *response = [request.responseString stringByReplacingOccurrencesOfString:@":null" withString:@":\"\""];
//        NSArray *userInfo = [response JSONValue];
//        if (userInfo && [userInfo count] > 0) {
//            [[NSUserDefaults standardUserDefaults] setObject:[userInfo objectAtIndex:0]  forKey:kUserInfo];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            return YES;
//        }
        return YES;
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
