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
        contentViewController.width = 70;
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
    BOOL result = [ServiceManager submitAlertWithEmail:emailTF.text currID:currID status:@"Y" rate_alert:rateAlertTF.text];
    if (result) {
        [Util showAlertWithString:@"Successful!"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [Util showAlertWithString:@"Can't connect to server!"];
    }

    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    if (textField == rateAlertTF) {
        NSString *newtext = [textField.text stringByAppendingString:string];
        if ([newtext doubleValue] == 0) {
            return NO;
        }
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

@end
