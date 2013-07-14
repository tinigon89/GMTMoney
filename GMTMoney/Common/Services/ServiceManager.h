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

+ (BOOL)getFeedWithURL:(NSString *)url;

+ (BOOL)checkUser:(NSString *)user pass:(NSString *)pass;
+ (BOOL)fogotpass:(NSString *)email;
@end
