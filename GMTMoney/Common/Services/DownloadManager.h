//
//  DownloadManager.h
//  CountryGrocer
//
//  Created by Jacky Nguyen on 5/14/13.
//  Copyright (c) 2013 teamios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadManager : NSObject
{
    BOOL isDownloading;
    BOOL isContinueDownload;
    NSArray *downloadList;
    NSArray *currentDownloadList;
}
+ (DownloadManager*)sharedInstance;
- (void)downloadImages:(NSArray *)itemList;
@end
