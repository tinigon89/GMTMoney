//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "SMSViewController.h"
#import "AppDelegate.h"
#import "define.h"
#import "ServiceManager.h"
@interface SMSViewController ()

@end

@implementation SMSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
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

- (IBAction)send_click:(id)sender
{
    if (toTF.text == nil || [toTF.text length] == 0
        ||[[toTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                           whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter phone number!"];
        return;
        
    }
    if (contentTV.text == nil || [contentTV.text length] == 0
        ||[[contentTV.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                       whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter your message!"];
        return;
        
    }
    
    if([ServiceManager sendSMS:toTF.text message:contentTV.text])
    {
        [Util showAlertWithString:@"Your message has been sent!"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"+1234567890"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length+1 <= 160) {
        return YES;
    }
    return NO;
}

- (void)textViewDidChange:(UITextView *)textView
{
    titleLB.text = [NSString stringWithFormat:@"%i of 160",contentTV.text.length];
}
@end
