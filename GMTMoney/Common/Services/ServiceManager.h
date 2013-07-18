//
//  ServiceManager.h
//  CountryGrocer
//
//  Created by Jacky Nguyen on 5/13/13.
//  Copyright (c) 2013 teamios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceManager : NSObject

+ (BOOL)getDailyRates;
+ (BOOL)getCountryList;

+ (BOOL)getFeedWithURL:(NSString *)url;

+ (BOOL)checkUser:(NSString *)user pass:(NSString *)pass;
+ (BOOL)fogotpass:(NSString *)email;

+ (BOOL)getTransactionStatus:(NSString *)regid;
+ (BOOL)getTransactionHistory:(NSString *)regid;

+ (BOOL)getSenderList:(NSString *)regid;
+ (BOOL)getBenList:(NSString *)regid;

+ (NSArray *)searchSenderList:(NSString *)regid searchIndex:(int)searchIndex searchString:(NSString *)searchString;
+ (NSArray *)searchBeneList:(NSString *)regid searchIndex:(int)searchIndex searchString:(NSString *)searchString;
+ (BOOL)sendSMS:(NSString *)toNumber message:(NSString *)message;
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
       SourceD:(int)SourceD;
@end
