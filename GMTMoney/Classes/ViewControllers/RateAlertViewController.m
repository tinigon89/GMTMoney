//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "RateAlertViewController.h"
#import "AppDelegate.h"
#import "define.h"
#import "ServiceManager.h"
@interface RateAlertViewController ()

@end

@implementation RateAlertViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    dailyRateList = [userDefault objectForKey:kDailyRateInfo];
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [dailyRateList sortedArrayUsingDescriptors:sortDescriptors];
    dailyRateList = [sortedArray mutableCopy];
    for (NSDictionary *dict in dailyRateList) {
        if ([[dict objectForKey:@"CurrSym"] isEqualToString:@"AUD"]) {
            [dailyRateList removeObject:dict];
            break;
        }
    }
    currencyList = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *dict in dailyRateList) {
        [currencyList addObject:[dict objectForKey:@"CurrSym"]];
    }
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

- (IBAction)to_Click:(id)sender {
    if (!popoverController) {
        UIButton *button = (UIButton*)sender;
		WEPopoverContentViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        contentViewController.delegate = self;
        contentViewController.menuList = currencyList;
        contentViewController.width = 80;
		popoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController] ;
        [contentViewController.tableView setScrollEnabled:YES];
        [contentViewController.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [contentViewController.tableView setShowsVerticalScrollIndicator:NO];
		popoverController.delegate = self;
		popoverController.passthroughViews = [NSArray arrayWithObject:self.navigationController.navigationBar];
		
        //		[popoverController presentPopoverFromBarButtonItem:sender
        //                                  permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown)
        //                                                  animated:YES];
        [popoverController presentPopoverFromRect:button.bounds inView:button permittedArrowDirections:(UIPopoverArrowDirectionUp) animated:YES];
        
	} else {
		[popoverController dismissPopoverAnimated:YES];
		popoverController = nil;
	}
}

- (IBAction)check_click:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (!button.selected) {
        button.selected = YES;
    }
    else
    {
        button.selected = NO;
    }
        
}

- (IBAction)regist_Click:(id)sender {
    if (![Util NSStringIsValidEmail:emailTF.text]) {
        [Util showAlertWithString:@"Email invalid"];
        return;
    }
    
    
    if (toTF.text == nil || [toTF.text length] == 0
        ||[[toTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                          whitespaceAndNewlineCharacterSet]] length] == 0 )
    {        
        [Util showAlertWithString:@"Please select currency!"];
        return;        
    }
    if (rateAlertTF.text == nil || [rateAlertTF.text length] == 0
        ||[[rateAlertTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                       whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        [Util showAlertWithString:@"Please enter rate alert!"];
        return;
    }
    NSDictionary *dict2 = [dailyRateList objectAtIndex:currentIndex];
    NSString * currID = [[dict2 objectForKey:@"CurrID"] stringValue];
    NSString *device_token = @"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken]) {
        device_token = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
    }
    NSString *device_id = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceId];
    [self performSelectorInBackground:@selector(showProcess) withObject:nil];
    if ([ServiceManager checkAlertWithDevice:device_id currency_id:currID]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"You already registed an alert for this currency. Do you want to replace it?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        [alert show];
    }
    else
    {
        BOOL result = [ServiceManager registAlertWithDevice:device_id email:emailTF.text device_token:device_token currency_id:currID rate_alert:rateAlertTF.text];
        if (result) {
            [SVProgressHUD dismiss];
            [Util showAlertWithString:@"Successful!"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [SVProgressHUD dismiss];
            [Util showAlertWithString:@"Can't connect to server!"];
        }
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSDictionary *dict2 = [dailyRateList objectAtIndex:currentIndex];
        NSString * currID = [[dict2 objectForKey:@"CurrID"] stringValue];
        NSString *device_token = @"";
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken]) {
            device_token = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
        }
        NSString *device_id = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceId];

            BOOL result = [ServiceManager registAlertWithDevice:device_id email:emailTF.text device_token:device_token currency_id:currID rate_alert:rateAlertTF.text];
            if (result) {
                [SVProgressHUD dismiss];
                [Util showAlertWithString:@"Successful!"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [SVProgressHUD dismiss];
                [Util showAlertWithString:@"Can't connect to server!"];
            }        
    }
    [SVProgressHUD dismiss];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    if (textField == rateAlertTF) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@".1234567890"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    
    return YES;
}




#pragma mark -
#pragma mark WEPopoverControllerDelegate implementation

- (void)popoverControllerDidDismissPopover:(WEPopoverController *)thePopoverController {
	//Safe to release the popover here
	popoverController = nil;
}

- (BOOL)popoverControllerShouldDismissPopover:(WEPopoverController *)thePopoverController {
	//The popover is automatically dismissed if you click outside it, unless you return NO here
	return YES;
}

- (void)didSelectMenuAtIndex:(int)index
{
    currentIndex = index;
    toTF.text = [currencyList objectAtIndex:index] ;
    [popoverController dismissPopoverAnimated:YES];
    popoverController = nil;
}

- (void)showProcess
{
    [SVProgressHUD showWithStatus:@"Loading"];
}

@end
