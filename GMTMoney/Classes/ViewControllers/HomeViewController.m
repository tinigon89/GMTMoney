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
#import "LoginViewController.h"
#import "AccountViewController.h"
#import "SMSViewController.h"
#import "FacebookViewController.h"
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
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo])
    {
        [loginButton setImage:[UIImage imageNamed:@"btn_login_nav.png"] forState:UIControlStateNormal];
    }
    else
    {
        [loginButton setImage:[UIImage imageNamed:@"btn_nav_logout.png"] forState:UIControlStateNormal];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!isViewDidLoad) {
        [self performSelectorInBackground:@selector(showProcess) withObject:nil];
        [ServiceManager getDailyRates];
        [ServiceManager getCountryList];
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
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
//    {
//        SLComposeViewController *facebook = [SLComposeViewController
//                                             composeViewControllerForServiceType:SLServiceTypeFacebook];
//        NSString *postText = [NSString stringWithFormat:@"I'm using GMTMoney app. It's great app. \n\nShared Using GMTMoney App"];
//        [facebook setInitialText:postText];
//        [self presentViewController:facebook animated:YES completion:nil];
//    }
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"FinishTransaction"])
    {
        FacebookViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FacebookViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else
    {
        [Util showAlertWithString:@"Finish a transaction and like us to get 10 SMS for free"];
    }
}

- (IBAction)login_Click:(id)sender {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo]) {
        LoginViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Do you want to log out?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        [alertView show];
    }
}

- (IBAction)account_Click:(id)sender {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo]) {
        LoginViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else
    {
        AccountViewController *accountView = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountViewController"];
        [self.navigationController pushViewController:accountView animated:YES];
    }
}

- (IBAction)sms_Click:(id)sender {
    SMSViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SMSViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserInfo];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [loginButton setImage:[UIImage imageNamed:@"btn_login_nav.png"] forState:UIControlStateNormal];
    }
}

@end
