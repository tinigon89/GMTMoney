//
//  Channel+Custom.m
//  ChannelBuster
//
//  Created by Jacky Nguyen on 4/9/13.
//  Copyright (c) 2013 com. All rights reserved.
//

#import "CGItem+Custom.h"
#import "NSManagedObjectContext+Custom.h"
#import "CoreDataHelper.h"
#import "Define.h"
#define kEntityName @"CGItem"
@implementation CGItem(Custom)
+ (CGItem *)newCGItem
{
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext managedObjectContext];
    if (managedObjectContext == nil)
    {
        return nil;
    }
    @try
    {
        CGItem * cgItem = [NSEntityDescription insertNewObjectForEntityForName:kEntityName
                                                            inManagedObjectContext:managedObjectContext];
        return cgItem;
    }
    @catch (NSException *exception)
    {
        
    }
    return nil;
}

+ (NSArray *)getAllCGItems
{
    NSArray *lists;
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext managedObjectContext];
    if (managedObjectContext == nil)
    {
        return nil;
    }
    @try
    {
        lists = [CoreDataHelper getObjectsFromcontext:managedObjectContext
                                           entityName:kEntityName
                                              sortKey:nil
                                        sortAscending:NO];
    }
    @catch (NSException *exception)
    {
        NSLog(@"__ERROR__%@__", exception.reason);
    }
    
    return lists;
}

+ (CGItem *)getCGItemByUID:(NSString *)uid
{
    CGItem *cgItem = nil;
    NSArray *lists;
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext managedObjectContext];
    if (managedObjectContext == nil)
    {
        return nil;
    }
    @try
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uid = %@", uid];
        lists = [CoreDataHelper searchObjectsInContext:managedObjectContext
                                            entityName:kEntityName
                                             predicate:predicate
                                               sortKey:nil
                                         sortAscending:NO];
        if ([lists count] > 0)
        {
            cgItem = [lists objectAtIndex:0];
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"__ERROR__%@__", exception.reason);
    }
    return cgItem;
}

+ (CGItem *)getCGItemByName:(NSString *)name
{
    CGItem *cgItem = nil;
    NSArray *lists;
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext managedObjectContext];
    if (managedObjectContext == nil)
    {
        return nil;
    }
    @try
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        lists = [CoreDataHelper searchObjectsInContext:managedObjectContext
                                            entityName:kEntityName
                                             predicate:predicate
                                               sortKey:nil
                                         sortAscending:NO];
        if ([lists count] > 0)
        {
            cgItem = [lists objectAtIndex:0];
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"__ERROR__%@__", exception.reason);
    }
    return cgItem;
}

+ (BOOL)updateCGItem:(CGItem *)itemObj
{
    BOOL success = YES;
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext managedObjectContext];
    if (managedObjectContext == nil)
    {
        success = NO;
    }
    [managedObjectContext save:&error];
    return success;
    
}

+ (NSArray *)getCGItems:(int)isSpecial
{
    NSArray *lists;
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext managedObjectContext];
    if (managedObjectContext == nil)
    {
        return nil;
    }
    @try
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"itemType = %i",isSpecial];
        lists = [CoreDataHelper searchObjectsInContext:managedObjectContext
                                            entityName:kEntityName
                                             predicate:predicate
                                               sortKey:@"orderIndex"
                                         sortAscending:YES];
        if ([lists count] > 0)
        {
            return lists;
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"__ERROR__%@__", exception.reason);
    }
    return nil;
}

+ (BOOL)deleteCGItem:(CGItem *)itemObj
{
    NSError *error = nil;
    BOOL success = YES;
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext managedObjectContext];
    
    if (managedObjectContext == nil)
    {
        success = NO;
        return success;
    }
    @try
    {
        [managedObjectContext deleteObject:itemObj];
        [managedObjectContext save:&error];
    }
    @catch (NSException* ex) {
        success = NO;
    }
    
    return success;
}
@end

