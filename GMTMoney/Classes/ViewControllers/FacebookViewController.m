//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "FacebookViewController.h"
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "define.h"
@interface FacebookViewController ()

@end

@implementation FacebookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    postParams = [@{
                       @"link" : @"http://www.gmtmoney.com.au/",
                       @"picture" : @"http://www.gmtmoney.com.au/images2/logo.jpg",
                       @"name" : @"GMT Money Transfer and Exchange",
                       @"caption" : @""
                       } mutableCopy];
    //if ([FBSession activeSession].isOpen) {
        [[FBSession activeSession] closeAndClearTokenInformation];
        [[FBSession activeSession] close];
        [FBSession setActiveSession:nil];
   // }
   // _facebook = [[Facebook alloc] initWithAppId:@"563452723716020" andDelegate:self];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.taskbarView addSubview:[AppDelegate sharedInstance].taskbarView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)home_click:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)like_click:(id)sender
{
    if ([FBSession.activeSession.permissions
         indexOfObject:@"publish_actions"] == NSNotFound) {
        // Permission hasn't been granted, so ask for publish_actions
        [FBSession openActiveSessionWithPublishPermissions:@[@"publish_actions"]
                                           defaultAudience:FBSessionDefaultAudienceFriends
                                              allowLoginUI:YES
                                         completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                             if (FBSession.activeSession.isOpen && !error) {
                                                 // Publish the story if permission was granted
                                                 [self publishStory];
                                             }
                                         }];
    } else {
        if (FBSession.activeSession.isOpen) {
            [self publishStory];
            
        }
        else
        {
            
            [FBSession openActiveSessionWithPublishPermissions:@[@"publish_actions"]
                                               defaultAudience:FBSessionDefaultAudienceFriends
                                                  allowLoginUI:YES
                                             completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                                 if (FBSession.activeSession.isOpen && !error) {
                                                     // Publish the story if permission was granted
                                                     [self publishStory];
                                                 }
                                             }];
        }
    
    }
}

- (void)publishStory
{
  
    postParams[@"message"] = @"Send money online 24/7 through app  visit @Www.gmtmoney.com.au And get free SMS credits for sending";
    [FBRequestConnection
     startWithGraphPath:@"me/feed"
     parameters:postParams
     HTTPMethod:@"POST"
     completionHandler:^(FBRequestConnection *connection,
                         id result,
                         NSError *error) {
         if (error) {
             [[[UIAlertView alloc] initWithTitle:@"Error"
                                         message:@"Can't post to facebook"
                                        delegate:self
                               cancelButtonTitle:@"OK!"
                               otherButtonTitles:nil]
              show];
         } else {
             [[[UIAlertView alloc] initWithTitle:@"Thank you for your support!"
                                         message:@"10 SMS credits added to your phone"
                                        delegate:self
                               cancelButtonTitle:@"OK!"
                               otherButtonTitles:nil]
              show];
             if ([[NSUserDefaults standardUserDefaults] boolForKey:@"FinishTransaction"]) {
                 int value = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SMS"] intValue];
                 value +=10;
                 [[NSUserDefaults standardUserDefaults] setInteger:value forKey:@"SMS"];
                 [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FinishTransaction"];
                 [[NSUserDefaults standardUserDefaults] synchronize];
             }
             [self.navigationController popViewControllerAnimated:YES];
             
         }
         
         
     }];
}

- (void)showProcess
{
    [SVProgressHUD showWithStatus:@"Loading"];
}

@end
