//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import <Social/Social.h>
#import "ServiceManager.h"
#import "define.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [AppDelegate sharedInstance].navController = self.navigationController;
	// Do any additional setup after loading the view, typically from a nib.
    //[self.taskbarView addSubview:[AppDelegate sharedInstance].taskbarView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.taskbarView addSubview:[AppDelegate sharedInstance].taskbarView];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!isViewDidLoad) {
        [self performSelectorInBackground:@selector(showProcess) withObject:nil];
        [ServiceManager getDailyRates];
        
        [SVProgressHUD dismiss];
        isViewDidLoad = YES;
    }
    
}

- (void)showProcess
{
    [SVProgressHUD showWithStatus:@"Loading"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)facebook_click:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *facebook = [SLComposeViewController
                                             composeViewControllerForServiceType:SLServiceTypeFacebook];
        NSString *postText = [NSString stringWithFormat:@"I'm using GMTMoney app. It's great app. \n\nShared Using GMTMoney App"];
        [facebook setInitialText:postText];
        [self presentViewController:facebook animated:YES completion:nil];
    }
}
@end
