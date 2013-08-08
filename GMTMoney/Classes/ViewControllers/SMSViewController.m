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
    codeList = [[NSArray alloc] initWithObjects:@"+61",@"+91",@"+85", nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.taskbarView addSubview:[AppDelegate sharedInstance].taskbarView];
    int value = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SMS"] intValue];
    smsLabel.text = [NSString stringWithFormat:@"SMS: %i",value];
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
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"SMS"] || [[[NSUserDefaults standardUserDefaults] objectForKey:@"SMS"] intValue] == 0) {
        [Util showAlertWithString:@"Finish a transaction and share on facebook to get 10 SMS for free"];
        return;
    }
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
    
    NSString *toNumber = [NSString stringWithFormat:@"%@%@",[codeList objectAtIndex:currentIndex],toTF.text];
    if([ServiceManager sendSMS:toNumber message:contentTV.text])
    {
        int value = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SMS"] intValue];
        value--;
        [[NSUserDefaults standardUserDefaults] setInteger:value forKey:@"SMS"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [Util showAlertWithString:@"Your message has been sent!"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)codeArea_Click:(id)sender {
    if (!popoverController) {
        UIButton *button = (UIButton*)sender;
		WEPopoverContentViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        contentViewController.delegate = self;
        contentViewController.menuList = codeList;
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
    [codeAreaBT setTitle:[codeList objectAtIndex:index] forState:UIControlStateNormal];
    [popoverController dismissPopoverAnimated:YES];
    popoverController = nil;
}
@end
