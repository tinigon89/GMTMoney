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


+ (BOOL)submitStep1:(NSString *)regid
               curr:(int)curr
            purpose:(NSString *)purpose
           PayMethod:(int) PayMethod
           PayAmount:(NSString *)PayAmount
            Commision:(NSString *)Commision
            TranAmount:(NSString *)TranAmount
            ExRate:(NSString *)ExRate
            FAmount:(NSString *)FAmount
            Comments:(NSString *)Comments
             online:(int)online
{
    //http://www.gmtmoney.com.au/istep1.aspx?regid=2&curr=1&purpose=family&paycurr=2&PayMethod=1&PayAmount=1000&Commision=10&TranAmount=990&ExRate=55&FAmount=54450&Comments=comment
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:@"http://www.gmtmoney.com.au/istep1.aspx?regid=%@&curr=%i&purpose=%@&paycurr=2&PayMethod=%i&PayAmount=%@&Commision=%@&TranAmount=%@&ExRate=%@&FAmount=%@&Comments=%@&online=%i",regid,curr,[Util urlencode:purpose],PayMethod,PayAmount,Commision,TranAmount,ExRate,FAmount,[Util urlencode:Comments],online];
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
    [[NSUserDefaults standardUserDefaults] setObject:request.responseString  forKey:kRemitID];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:PayMethod]  forKey:kPaymentType];
    [[NSUserDefaults standardUserDefaults] setObject:PayAmount  forKey:kPayAmount];
    [[NSUserDefaults standardUserDefaults] setObject:Commision  forKey:kLessCommision];
    [[NSUserDefaults standardUserDefaults] setObject:TranAmount  forKey:kTransferAmount];
    [[NSUserDefaults standardUserDefaults] setObject:ExRate  forKey:kEXRate];
    [[NSUserDefaults standardUserDefaults] setObject:FAmount  forKey:kFAmount];
        [[NSUserDefaults standardUserDefaults] setObject:Comments  forKey:kComment];
    [[NSUserDefaults standardUserDefaults] synchronize];
return YES;

    }
    return NO;
}

+ (BOOL)submitAlertWithEmail:(NSString*)email
              currID:(NSString *)currID
             status:(NSString *)status

{
    //http://www.gmtmoney.com.au/iealert.aspx?uname=sha&pcode=965&mobile=&email=itresumesha@gmail.com&currID=20&smsalert=Y&emailalert=Y&status=Y
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:@"http://www.gmtmoney.com.au/iealert.aspx?uname=%@&pcode=965&mobile=&email=%@&currID=%@&smsalert=N&emailalert=Y&status=%@",email,email,currID,status];
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
        if ([[request.responseString uppercaseString] isEqualToString:@"OK"]) {
            return YES;
        }
        [Util showAlertWithString:request.responseString];
        return NO;
        
    }
    return NO;
}

+ (BOOL)submitDuplicate:(NSString *)regid
                remitID:(NSString *)remitID
                  bnkID:(NSString *)bnkID
               curr:(int)curr
            purpose:(NSString *)purpose
          PayMethod:(int) PayMethod
          PayAmount:(NSString *)PayAmount
           Comments:(NSString *)Comments
             online:(int)online
{
    //http://www.gmtmoney.com.au/iduplicate.aspx?regid=5&id=7577&purpose=iphone%20test&bnk=2&bnkID=985&payamt=100&comments=ip%20tst
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:@"http://www.gmtmoney.com.au/iduplicate.aspx?regid=%@&id=%@&purpose=%@&bnk=%i&bnkID=%@&payamt=%@&comments=%@&online=%i",regid,remitID,[Util urlencode:purpose],PayMethod,bnkID,PayAmount,[Util urlencode:Comments],online];
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
        return YES;
        
    }
    return NO;
}

+ (BOOL)submitStep2:(NSString *)regid
               remid:(NSString*)remid
            sid:(NSString *)sid
          paytype:(int) paytype
             online:(int)online
{
    //http://www.gmtmoney.com.au/istep2.aspx?regid=2&remid=100&sid=11&paytype=1
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:@"http://www.gmtmoney.com.au/istep2.aspx?regid=%@&remid=%@&sid=%@&paytype=%i&online=%i",regid,remid,sid,paytype,online];
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
//        [[NSUserDefaults standardUserDefaults] setObject:sid  forKey:kSenderID];
//        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
        
    }
//    [[NSUserDefaults standardUserDefaults] setObject:sid  forKey:kSenderID];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    return NO;
}

+ (BOOL)submitStep3:(NSString *)regid
              remid:(NSString*)remid
                benID:(NSString *)benID
            paytype:(int) paytype
             online:(int)online
{
    //http://www.gmtmoney.com.au/istep2.aspx?regid=2&remid=100&sid=11&paytype=1
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:@"http://www.gmtmoney.com.au/istep3.aspx?regid=%@&remid=%@&benID=%@&paytype=%i&online=%i",regid,remid,benID,paytype,online];
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
        return YES;
        
    }
    return NO;
}

+ (BOOL)submitStep4:(NSString *)regid
              remid:(NSString*)remid
              sid:(NSString *)sid
              benID:(NSString *)benID
              bnkID:(NSString *)bnkID
            paytype:(int) paytype
             online:(int)online
{
    //http://www.gmtmoney.com.au/iconfirmpage.aspx?regid=2&remid=100&sid=11&paytype=1&benid=2&bnkID=4
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:@"http://www.gmtmoney.com.au/iconfirmpage.aspx?regid=%@&remid=%@&sid=%@&paytype=%i&benid=%@&bnkID=%@&online=%i",regid,remid,sid,paytype,benID,bnkID,online];
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
        return YES;
        
    }
    [Util showAlertWithString:@"Can't connect to server!"];
    return NO;

}

+ (BOOL)createNewbankWithRegid:(NSString *)regid
                      BeneID:(NSString *)BeneID
                         ACHolderName:(NSString *)ACHolderName
                         ACNo:(NSString *)ACNo
                       BankName:(NSString *)BankName
                       BankCode:(NSString *)BankCode
                      SwiftCode:(NSString *)SwiftCode
                        RoutNo:(NSString *)RoutNo
                       Add1:(NSString *)Add1
                          Add2:(NSString *)Add2
                          City:(NSString *)City
                        State:(NSString *)State
                         PostCode:(NSString *)PostCode
                       Country:(int)Country

{
    /*
     ttp://www.gmtmoney.com.au/ibankadd.aspx?RegID=3&ACHolderName=gmttest&ACNo=123&BankName=sbibank&BankCode=1111&SwiftCode=123&RoutNo=5&Add1=address1&Add2=Address2&City=testcity&State=1&PostCode=1&Country=1&BeneID=1
     */
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:@"http://gmtmoney.com.au/ibankadd.aspx?RegID=%@&ACHolderName=%@&ACNo=%@&BankName=%@&BankCode=%@&SwiftCode=%@&RoutNo=%@&Add1=%@&Add2=%@&City=%@&State=%@&PostCode=%@&Country=%i&BeneID=%@",regid,[Util urlencode:ACHolderName],[Util urlencode:ACNo],[Util urlencode:BankName],[Util urlencode:BankCode],[Util urlencode:SwiftCode],[Util urlencode:RoutNo],[Util urlencode:Add1],[Util urlencode:Add2],[Util urlencode:City],[Util urlencode:State],[Util urlencode:PostCode],Country,BeneID];
    
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
        if ([[request.responseString uppercaseString] isEqualToString:@"OK"]) {
            return YES;
        }
        [Util showAlertWithString:request.responseString];
        return NO;
    }
    [Util showAlertWithString:@"Can't connect to server!"];
    return NO;
    
}

+ (BOOL)createNewBeneWithRegid:(NSString *)regid
                           email:(NSString *)email
                           FName:(NSString *)FName
                         SurName:(NSString *)SurName
                         BisName:(NSString *)BisName
                        IdentyID:(NSString *)IdentyID
                          IdCode:(NSString *)IdCode
                         RStreet:(NSString *)RStreet
                            RSub:(NSString *)RSub
                            City:(NSString *)City
                          RState:(NSString *)RState
                           RPost:(NSString *)RPost
                      RCountryID:(int)RCountryID
                           PCDet:(NSString *)PCDet
                        PContact:(NSString *)PContact
                           SCDet:(NSString *)SCDet
                        SContact:(NSString *)SContact
{
    /*
     tp://www.gmtmoney.com.au/ibeneadd.aspx?RegID=3&Email=gmttest@test.com&FName=gmt&SurName=test&BisName=gbis&IDType=licence&IdCode=123&PCont=555555&SCont=333333&Add1=address1&Add2=Address2&City=testcity&State=teststate&Rpost=234
     */
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:@"http://gmtmoney.com.au/ibeneadd.aspx?RegID=%@&Email=%@&FName=%@&SurName=%@&BisName=%@&IDType=%@&IdCode=%@&Add1=%@&Add2=%@&City=%@&State=%@&Rpost=%@&RCountryID=%i&PCont=%@&SCont=%@&PCDet=%@&SCDet=%@",regid,[Util urlencode:email],[Util urlencode:FName],[Util urlencode:SurName],[Util urlencode:BisName],[Util urlencode:IdentyID],[Util urlencode:IdCode],[Util urlencode:RStreet],[Util urlencode:RSub],[Util urlencode:City],[Util urlencode:RState],[Util urlencode:RPost],RCountryID,[Util urlencode:PContact],[Util urlencode:SContact],PCDet,SCDet];
    
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
        if ([[request.responseString uppercaseString] isEqualToString:@"OK"]) {
            return YES;
        }
        [Util showAlertWithString:request.responseString];
        return NO;
    }
    [Util showAlertWithString:@"Can't connect to server!"];
    return NO;
    
}

+ (BOOL)createNewSenderWithRegid:(NSString *)regid
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
{
    /*
     gmtmoney.com.au/isendernew.aspx?RegID=3&Email=gmttest@test.com&FName=gmt&SurName=test&BisName=gbis&DBirth=1980/10/01&NationID=1&IdentyID=1&IdCode=12345&IDExpiry=2019/10/01&IDIssuer=idi&Occup=developer&RStreet=r1&RSub=r2&RState=r3&RPost=r4&RCountryID=5&PStatus=1&PStreet=p1&PSub=p2&PState=p3&PPost=p4&PCountryID=6&PContact=11111&SContact=22222&PCDet=pc1&SCDet=pc2
     */
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:@"http://gmtmoney.com.au/isendernew.aspx?RegID=%@&Email=%@&FName=%@&SurName=%@&BisName=%@&DBirth=%@&NationID=%i&IdentyID=%i&IdCode=%@&IDExpiry=%@&IDIssuer=%@&Occup=%@&RStreet=%@&RSub=%@&RState=%@&RPost=%@&RCountryID=%i&PStatus=%i&PStreet=%@&PSub=%@&PState=%@&PPost=%@&PCountryID=%i&PContact=%@&SContact=%@&PCDet=%@&SCDet=%@",regid,[Util urlencode:email],[Util urlencode:FName],[Util urlencode:SurName],[Util urlencode:BisName],[Util urlencode:DBirth],NationID,IdentyID,[Util urlencode:IdCode],[Util urlencode:IDExpiry],[Util urlencode:IDIssuer],[Util urlencode:Occup],[Util urlencode:RStreet],[Util urlencode:RSub],[Util urlencode:RState],[Util urlencode:RPost],RCountryID,PStatus,[Util urlencode:PStreet],[Util urlencode:PSub],[Util urlencode:PState],[Util urlencode:PPost],PCountryID,[Util urlencode:PContact],[Util urlencode:SContact],PCDet,SCDet];
    
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
        if ([[request.responseString uppercaseString] isEqualToString:@"OK"]) {
            return YES;
        }
        [Util showAlertWithString:request.responseString];
        return NO;
    }
    [Util showAlertWithString:@"Can't connect to server!"];
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
    NSString *urlString = [NSString stringWithFormat:@"http://gmtmoney.com.au/iregister.aspx?Country1=1&Email=%@&UserName=%@&Password=%@&FName=%@&SurName=%@&BisName=%@&DBirth=%@&NationID=%i&IdentyID=%i&IdCode=%@&IDExpiry=%@&IDIssuer=%@&Occup=%@&RStreet=%@&RSub=%@&RState=%@&RPost=%@&RCountryID=%i&PStatus=%i&PStreet=%@&PSub=%@&PState=%@&PPost=%@&PCountryID=%i&PContact=%@&SContact=%@&SourceD=%i&PCDet=%@&SCDet=%@",[Util urlencode:email],[Util urlencode:user],[Util urlencode:pass],[Util urlencode:FName],[Util urlencode:SurName],[Util urlencode:BisName],[Util urlencode:DBirth],NationID,IdentyID,[Util urlencode:IdCode],[Util urlencode:IDExpiry],[Util urlencode:IDIssuer],[Util urlencode:Occup],[Util urlencode:RStreet],[Util urlencode:RSub],[Util urlencode:RState],[Util urlencode:RPost],RCountryID,PStatus,[Util urlencode:PStreet],[Util urlencode:PSub],[Util urlencode:PState],[Util urlencode:PPost],PCountryID,[Util urlencode:PContact],[Util urlencode:SContact],SourceD,PCDet,SCDet];
    
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
        if ([[request.responseString uppercaseString] isEqualToString:@"OK"]) {
            return YES;
        }
        [Util showAlertWithString:request.responseString];
        return NO;
    }
    [Util showAlertWithString:@"Can't connect to server!"];
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
        //NSLog(@"%@",request.responseString);
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

+ (NSArray *)searchBankForBeneID:(NSString *)beneid
{
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:kServer_Get_BankInfo,beneid];
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

+ (NSArray *)getBankDetail:(NSString *)bankid
{
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:kServer_Get_BankDetail,bankid];
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
        if ([senderList isKindOfClass:[NSArray class]] && [senderList count] > 0) {
            return senderList;
        }
    }
    return nil;
}

+ (NSArray *)searchRemittance:(NSString *)regid searchIndex:(int)searchIndex searchString:(NSString *)searchString
{
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:kServer_Get_Search_Remitance,regid,searchIndex,[Util urlencode:searchString]];
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
        if ([senderList isKindOfClass:[NSArray class]] && [senderList count] > 0) {
            return senderList;
        }
    }
    return nil;
}

+ (NSArray *)searchSenderList:(NSString *)regid searchIndex:(int)searchIndex searchString:(NSString *)searchString
{
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:kServer_Get_Search_Sender,regid,searchIndex,[Util urlencode:searchString]];
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
        if ([senderList isKindOfClass:[NSArray class]] && [senderList count] > 0) {
            return senderList;
        }
    }
    return nil;
}

+ (NSArray *)searchBeneList:(NSString *)regid searchIndex:(int)searchIndex searchString:(NSString *)searchString
{
    ASIFormDataRequest * request;
    NSString *urlString = [NSString stringWithFormat:kServer_Get_Search_Bene,regid,searchIndex,[Util urlencode:searchString]];
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
        if ([senderList isKindOfClass:[NSArray class]] && [senderList count] > 0) {
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
        //NSLog(@"%@",request.responseString);
        if ([request.responseString length] == 0) {
            return NO;
        }
        NSString *response = [request.responseString stringByReplacingOccurrencesOfString:@":null" withString:@":\"\""];
        NSArray *transStatusList = [response JSONValue];
        if ([transStatusList isKindOfClass:[NSArray class]] && [transStatusList count] > 0) {
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
    NSString *urlString = [NSString stringWithFormat:kServer_Get_SMS,[Util urlencode:message],toNumber];
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
        if ([[request.responseString uppercaseString] isEqualToString:@"OK"]) {
            return YES;
        }
        [Util showAlertWithString:request.responseString];
        return NO;
    }
    return NO;
    
}
@end
