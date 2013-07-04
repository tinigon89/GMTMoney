//
//  ServiceManager.h
//  CountryGrocer
//
//  Created by Jacky Nguyen on 5/13/13.
//  Copyright (c) 2013 teamios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceManager : NSObject
+ (void)postUserInfo;
+ (BOOL)getListwithType:(int)type;
+ (void)postDeviceInfo;
@end
