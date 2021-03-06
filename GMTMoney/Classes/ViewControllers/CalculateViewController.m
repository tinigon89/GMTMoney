//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "CalculateViewController.h"
#import "AppDelegate.h"
#import "define.h"
#import "LoginViewController.h"
#import "AccountViewController.h"
@interface CalculateViewController ()

@end

@implementation CalculateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //scrollView.contentSize = CGSizeMake(320, 320);
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString* url = @"https://instantcashworldwide.ae/InstantcashworldwideOffload/agentsearch_en.aspx";
    NSURL* nsUrl = [NSURL URLWithString:url];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl];
    webview.delegate = self;
    [webview loadRequest:request];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    dailyRateList = [userDefault objectForKey:kDailyRateInfo];
    currencyList = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *dict in dailyRateList) {
        [currencyList addObject:[dict objectForKey:@"CurrSym"]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}



- (void)webViewDidFinishLoad:(UIWebView *)theWebView
{
    if (!isFinish) {
        CGSize contentSize = theWebView.scrollView.contentSize;
        CGSize viewSize = self.view.bounds.size;
        
        float rw = viewSize.width / contentSize.width;
        
        theWebView.scrollView.zoomScale = rw;
        isFinish = YES;
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

- (IBAction)sendmoney_Click:(id)sender
{
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@".1234567890"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == totalAmountTF) {
        double amount = [totalAmountTF.text doubleValue]/[rateTF.text doubleValue];
        amountTF.text = [NSString stringWithFormat:@"%.4f",amount];
    }
    else
    {
        [self calculate];
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    int height = PORTRAIT_KEYBOARD_HEIGHT;
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        height = LANDSCAPE_KEYBOARD_HEIGHT;
    }
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        screenHeight = screenRect.size.width;
    }
    NSLog(@"%f - %f - %f - %f : %f - %f",textField.frame.origin.y,textField.superview.frame.origin.y,screenHeight,textField.frame.size.height,textField.frame.origin.y + textField.superview.frame.origin.y + textField.frame.size.height,screenHeight - height);
    if (textField.frame.origin.y + textField.superview.frame.origin.y + textField.frame.size.height+self.navigationController.navigationBar.frame.size.height > screenHeight - height) {
        
        selectedTextField = textField;
        float currentDistance = textField.frame.origin.y + textField.superview.frame.origin.y + textField.frame.size.height + self.navigationController.navigationBar.frame.size.height - (screenHeight - height) + 25;
        distance += currentDistance;
        if (keyboardIsShowing) {
            UIView *parentView = selectedTextField.superview;
            CGRect frame = parentView.frame;
            frame.origin.y -= currentDistance;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.3f];
            parentView.frame = frame;
            [UIView commitAnimations];
        }
    }
}


- (void)keyboardWillShow:(NSNotification *)note
{
    CGRect keyboardBounds;
    NSValue *aValue = [note.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
    
    [aValue getValue:&keyboardBounds];
    if (!keyboardIsShowing)
    {
        keyboardIsShowing = YES;
        UIView *parentView = selectedTextField.superview;
        CGRect frame = parentView.frame;
        frame.origin.y -= distance;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        parentView.frame = frame;
        [UIView commitAnimations];
    }
}

- (void)keyboardWillHide:(NSNotification *)note
{
    CGRect keyboardBounds;
    NSValue *aValue = [note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    [aValue getValue: &keyboardBounds];
    
    if (keyboardIsShowing)
    {
        keyboardIsShowing = NO;
        UIView *parentView = selectedTextField.superview;
        CGRect frame = parentView.frame;
        frame.origin.y += distance;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3f];
        parentView.frame = frame;
        [UIView commitAnimations];
    }
    if (distance > 0) {
        distance = 0;
    }
}

- (void)dismissKeyboard {
    [self.view endEditing:TRUE];
}

- (void)calculate
{
    double amount = [amountTF.text doubleValue];
    double rate = [rateTF.text doubleValue];
    totalAmountTF.text = [NSString stringWithFormat:@"%.4f",amount*rate];
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
    amountTF.enabled = YES;
    currentIndex = index;
    rateTF.text = [NSString stringWithFormat:@"%.4f",[[[dailyRateList objectAtIndex:currentIndex]objectForKey:@"ERate"] floatValue]];
    toTF.text = [currencyList objectAtIndex:index] ;
    [popoverController dismissPopoverAnimated:YES];
    popoverController = nil;
    [self calculate];
}

@end
