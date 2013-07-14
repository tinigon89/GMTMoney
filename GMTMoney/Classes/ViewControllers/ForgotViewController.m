//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "ForgotViewController.h"
#import "AppDelegate.h"
#import "define.h"
#import "ServiceManager.h"
@interface ForgotViewController ()

@end

@implementation ForgotViewController

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
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submit_Click:(id)sender {
    NSString *temp = emailTF.text;
    if (!temp || [[temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0 || ![Util NSStringIsValidEmail:temp]) {
        [Util showAlertWithString:@"Email invalided"];
        return;
    }
    if([ServiceManager fogotpass:emailTF.text])
    {
        [Util showAlertWithString:@"Success!"];
    }
}

@end
