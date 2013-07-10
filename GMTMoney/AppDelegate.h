//
//  AppDelegate.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskbarView.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TaskbarView *taskbarView;
@property (strong, nonatomic) UINavigationController *navController;
+ (AppDelegate *)sharedInstance;
@end
