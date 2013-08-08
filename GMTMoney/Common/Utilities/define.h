//
//  define.h
//  EYoLo
//
//  Created by Jacky Nguyen on 3/13/13.
//  Copyright (c) 2013 teamios. All rights reserved.
//
#import "Util.h"
#import "NetworkActivityIndicator.h"
#import "SVProgressHUD.h"
#define kServer_Get_DailyRates @"http://www.gmtmoney.com.au/dr.aspx"
#define kServer_Get_Login @"http://www.gmtmoney.com.au/ilogin.aspx?uname=%@&upass=%@"
#define kServer_Get_Forgot @"http://www.gmtmoney.com.au/iforget.aspx?email=%@"
#define kServer_Get_SMS @"http://www.gmtmoney.com.au/isms.aspx?msg=%@&to=%@"
#define kServer_Get_Trans_Status @"http://www.gmtmoney.com.au/iremitpend.aspx?regID=%@"
#define kServer_Get_Trans_History @"http://www.gmtmoney.com.au/iremits.aspx?regID=%@"
#define kServer_Get_CountryList @"http://www.gmtmoney.com.au/icurrency.aspx"

#define kServer_Get_Sender @"http://www.gmtmoney.com.au/isendersrch.aspx?regid=%@&lst=0&data=%@"
#define kServer_Get_Search_Sender @"http://www.gmtmoney.com.au/isendersrch.aspx?regid=%@&lst=%i&data=%@"
#define kServer_Get_Bene @"http://www.gmtmoney.com.au/ibenesrch.aspx?regid=%@&lst=-1&data="
#define kServer_Get_Search_Bene @"http://www.gmtmoney.com.au/ibenesrch.aspx?regid=%@&lst=%i&data=%@"
#define kServer_Get_Search_Remitance @"http://www.gmtmoney.com.au/idupsrch.aspx?regid=%@&lst=%i&data=%@"
#define kServer_Get_BankDetail @"http://www.gmtmoney.com.au/ibankdet.aspx?bankID=%@"
#define kServer_Get_BankInfo @"http://www.gmtmoney.com.au/ibanksrch.aspx?bankID=%@"
#define kServer_ImageURL @"http://www.cgapp.net.au/img/"

#define mainAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define IMAGESPATH [NSHomeDirectory() stringByAppendingString:@"/Documents/"]

#define HOMEDIRECTORY [[NSBundle mainBundle] resourcePath]

#define DOCUMENTDIRECTORY [NSHomeDirectory() stringByAppendingString:@"/Documents/"]

#define LIBRARY_CATCHES_DIRECTORY [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/"]

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#ifdef UI_USER_INTERFACE_IDIOM
#define IS_IPAD() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define PORTRAIT_KEYBOARD_HEIGHT 216
#define LANDSCAPE_KEYBOARD_HEIGHT  162
#else
#define IS_IPAD() (false)
#define PORTRAIT_KEYBOARD_HEIGHT 216
#define LANDSCAPE_KEYBOARD_HEIGHT  162
#endif

//#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
//#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )
//#define IS_IPOD   ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )
//#define IS_IPHONE_5 ( IS_IPHONE && IS_WIDESCREEN )
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define kDailyRateInfo @"DailyRateInfo"
#define kLastestUpdate @"LastestUpdate"
#define kUserInfo @"UserInfo"
#define kCountryList @"CountryList"

#define kTransStatusInfo @"TransStatusInfo"
#define kTransHistoryInfo @"TransHistoryInfo"
#define kSenderInfo @"SenderInfo"
#define kBeneInfo @"BeneInfo"
#define kRemitID @"RemitID"
#define kPayAmount @"PayAmount"
#define kLessCommision @"LessCommision"
#define kTransferAmount @"TransferAmount"
#define kEXRate @"kEXRate"
#define kFAmount @"kFAmount"
#define kPaymentType @"PaymentType"
#define kComment @"kComment"

#define kSenderID @"SenderID"
#define kBeneID @"BeneID"
#define kBankID @"BankID"
#define kSelectedBank @"SelectedBank"

#define kUserInfoRegist @"UserInfoRegist"
#define kDeviceInfo @"DeviceInfo"
#define kFirstLaunch @"FirstLaunch"
#define kPrivacyStatmentAccepted @"PrivacyStatementAccepted"
#define kRegistUser @"kRegistUser"
#define kDeviceId @"DeviceId"
#define kDeviceToken @"devicetoken"
#define kDeviceType @"devidetype"
#define kPostToken @"PostToken"
#define kAlarmInfo @"AlarmInfo"

#define kUser_Id @"id"
#define kUser_Name @"name"
#define kUser_Email @"email"
#define kUser_Age @"age"
#define kUser_Sex @"sex"
#define kUser_Postcode @"postcode"

#if defined(KISSFM)
#define IS_KISSVERSION() (true)
#else
#define IS_KISSVERSION() (false)
#endif


