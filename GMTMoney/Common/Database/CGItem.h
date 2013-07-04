//
//  CGItem.h
//  CountryGrocer
//
//  Created by Jacky Nguyen on 5/14/13.
//  Copyright (c) 2013 teamios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CGItem : NSManagedObject

@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSString * imageStorePath;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * itemDescription;
@property (nonatomic, retain) NSNumber * itemType;
@property (nonatomic, retain) NSNumber * orderIndex;
@property (nonatomic, retain) NSString * editDate;

@end
