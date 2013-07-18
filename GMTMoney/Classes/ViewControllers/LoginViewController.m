//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "define.h"
#import "ServiceManager.h"
#import "AccountViewController.h"
#import "RegisterViewController.h"
#import "ForgotViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

- (IBAction)login_Click:(id)sender {
    if (userIDTF.text == nil || [userIDTF.text length] == 0
        ||[[userIDTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                             whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter your userid!"];
        return;
        
    }
    if (passwordTF.text == nil || [passwordTF.text length] == 0
        ||[[passwordTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                            whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter your password!"];
        return;
    }
    
    if ([ServiceManager checkUser:userIDTF.text pass:passwordTF.text]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kTransHistoryInfo];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kTransStatusInfo];
        [[NSUserDefaults standardUserDefaults] synchronize];
        AccountViewController *accountView = [self.storyboard instantiateViewControllerWithIdentifier:@"AccountViewController"];
        [self.navigationController pushViewController:accountView animated:YES];
    }
    else
    {
        [Util showAlertWithString:@"User ID or password not correct"];
    }
    
}

- (IBAction)register_Click:(id)sender {
    RegisterViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)forgot_Click:(id)sender {
    ForgotViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
