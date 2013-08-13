//
//  AppDelegate.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "define.h"
static AppDelegate *sharedInstance = nil;
@implementation AppDelegate
@synthesize taskbarView,navController;
+ (AppDelegate *)sharedInstance
{
    return sharedInstance;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"TaskbarView" owner:nil options:nil];
    if (IS_IPAD()) {
        array = [[NSBundle mainBundle] loadNibNamed:@"TaskbarView_iPad" owner:nil options:nil];
    }
    self.taskbarView = [array objectAtIndex:0];
    sharedInstance = self;
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *tokenStr = [deviceToken description];
    NSString *hexStr = [[[tokenStr
                          stringByReplacingOccurrencesOfString:@"<" withString:@""]
                         stringByReplacingOccurrencesOfString:@">" withString:@""]
                        stringByReplacingOccurrencesOfString:@" " withString:@""] ;
    [userDefault setObject:hexStr forKey:kDeviceToken];
    [userDefault setBool:NO forKey:kPostToken];
    [userDefault synchronize];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSString *message = nil;
    id alert = [userInfo objectForKey:@"alert"];
    if ([alert isKindOfClass:[NSString class]]) {
        message = alert;
    } else if ([alert isKindOfClass:[NSDictionary class]]) {
        message = [alert objectForKey:@"body"];
    }
    if (alert) {
        [Util showAlertWithString:message];
        //[UIApplication sharedApplication].applicationIconBadgeNumber = 1;
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:@"didReceiveNotification" object:nil];
    }
    
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}
@end
