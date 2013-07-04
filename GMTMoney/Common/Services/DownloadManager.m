//
//  DownloadManager.m
//  CountryGrocer
//
//  Created by Jacky Nguyen on 5/14/13.
//  Copyright (c) 2013 teamios. All rights reserved.
//

#import "DownloadManager.h"
#import "CGItem+Custom.h"
#import "ASIFormDataRequest.h"
#import "define.h"
static DownloadManager *sharedInstance;
@implementation DownloadManager

+ (DownloadManager*)sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[DownloadManager alloc] init];
    }
    return sharedInstance;
}


- (void)downloadImages:(NSArray *)itemList
{
    if (isDownloading) {
        isContinueDownload = YES;
        isDownloading = NO;
        downloadList = itemList;
    }
    else
    {
        downloadList = itemList;
        currentDownloadList = itemList;
        isDownloading = YES;
        [self performSelectorInBackground:@selector(startDownload) withObject:nil];
    }
}

- (void)startDownload
{
    for (CGItem *item in currentDownloadList) {
        if (!isDownloading) {
            if (isContinueDownload) {
                isContinueDownload = NO;
                [self downloadImages:downloadList];
            }
            break;
        }
        if (item.imageStorePath == nil || item.imageStorePath.length == 0) {
            NSString *urlString = [NSString stringWithFormat:@"%@%@", kServer_ImageURL,item.imageUrl];
            NSString *path = [[Util imageDirectoryPath] stringByAppendingFormat:@"/%@_%@.jpg",item.uid,item.name];
            if([self downloadImageWithUrl:urlString path:path])
            {
                item.imageStorePath = path;
                [CGItem updateCGItem:item];
                [self performSelectorOnMainThread:@selector(sendNotification:) withObject:@"refreshData"
                                    waitUntilDone:YES];
            }           
        }
    }
    isDownloading = NO;
    isContinueDownload = NO;
}

- (BOOL)downloadImageWithUrl:(NSString *)urlString path:(NSString *)path
{
    ASIFormDataRequest * request;
    NSURL *url = [NSURL URLWithString:urlString];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    
    if (request.responseStatusCode == 200)
    {
        UIImage *image = [UIImage imageWithData:request.responseData];
        if (image) {
            NSError* error;
            if ([request.responseData writeToFile:path options:NSDataWritingAtomic error:&error]) {
                NSLog(@"Download sucessful");
                return YES;
            };
            NSLog(@"write error %@", error);
        }
    }
    NSLog(@"Download fail");
    return NO;
}

- (BOOL)downloadPolicy
{
    ASIFormDataRequest * request;
    NSURL *url = [NSURL URLWithString:kServer_Get_Policy];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    
    if (request.responseStatusCode == 200)
    {
        NSString *path = [[Util imageDirectoryPath] stringByAppendingFormat:@"/privacy-policy.pdf"];
        if (request.responseData) {
            NSError* error;
            if ([request.responseData writeToFile:path options:NSDataWritingAtomic error:&error]) {
                NSLog(@"Download sucessful");
                return YES;
            };
            NSLog(@"write error %@", error);
        }
    }
    NSLog(@"Download fail");
    return NO;
}

- (void)sendNotification:(NSString *)name
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"refreshData" object:nil];
}

@end
