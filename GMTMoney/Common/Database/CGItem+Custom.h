//
//  Channel+Custom.h
//  ChannelBuster
//
//  Created by Jacky Nguyen on 4/9/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGItem.h"
@interface CGItem(Custom)
+ (NSArray *)getAllCGItems;

+ (CGItem *)getCGItemByUID:(NSString *)uid;
+ (CGItem *)getCGItemByName:(NSString *)name;
+ (NSArray *)getCGItems:(int)isSpecial;

+ (CGItem *)newCGItem;

+ (BOOL)updateCGItem:(CGItem *)itemObj;

+ (BOOL)deleteCGItem:(CGItem *)itemObj;
@end
