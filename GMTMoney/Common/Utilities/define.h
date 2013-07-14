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
#define kDailyRateInfo @"DailyRateInfo"
#define kLastestUpdate @"LastestUpdate"
#define kUserInfo @"UserInfo"
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


