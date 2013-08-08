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
+ (NSArray *)searchRemittance:(NSString *)regid searchIndex:(int)searchIndex searchString:(NSString *)searchString;
+ (NSArray *)searchSenderList:(NSString *)regid searchIndex:(int)searchIndex searchString:(NSString *)searchString;
+ (NSArray *)searchBeneList:(NSString *)regid searchIndex:(int)searchIndex searchString:(NSString *)searchString;
+ (BOOL)sendSMS:(NSString *)toNumber message:(NSString *)message;
+ (BOOL)registAlertWithDevice:(NSString *)device_id
                        email:(NSString *)email
                 device_token:(NSString *)device_token
                  currency_id:(NSString *)currency_id
                   rate_alert:(NSString *)rate_alert;
+ (BOOL)checkAlertWithDevice:(NSString *)device_id
                 currency_id:(NSString *)currency_id;
+ (NSArray *)searchBankForBeneID:(NSString *)beneid;
+ (NSArray *)getBankDetail:(NSString *)bankid;
+ (BOOL)submitDuplicate:(NSString *)regid
                remitID:(NSString *)remitID
                  bnkID:(NSString *)bnkID
                   curr:(int)curr
                purpose:(NSString *)purpose
              PayMethod:(int) PayMethod
              PayAmount:(NSString *)PayAmount
               Comments:(NSString *)Comments
                 online:(int)online;
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
                       Country:(int)Country;
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
             online:(int)online;

+ (BOOL)submitStep2:(NSString *)regid
              remid:(NSString*)remid
                sid:(NSString *)sid
            paytype:(int) paytype
             online:(int)online;

+ (BOOL)submitStep3:(NSString *)regid
              remid:(NSString*)remid
              benID:(NSString *)benID
            paytype:(int) paytype
             online:(int)online;
+ (BOOL)submitStep4:(NSString *)regid
              remid:(NSString*)remid
                sid:(NSString *)sid
              benID:(NSString *)benID
              bnkID:(NSString *)bnkID
            paytype:(int) paytype
             online:(int)online;

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
                        SContact:(NSString *)SContact;
+ (BOOL)submitAlertWithEmail:(NSString*)email
                      currID:(NSString *)currID
                      status:(NSString *)status
                  rate_alert:(NSString *)rate_alert;

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
                      SContact:(NSString *)SContact;
@end
