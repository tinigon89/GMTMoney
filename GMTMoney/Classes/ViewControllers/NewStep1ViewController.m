//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "NewStep1ViewController.h"
#import "AppDelegate.h"
#import "define.h"
#import "ServiceManager.h"
#import "NewStep2ViewController.h"
#import "NewStep3ViewController.h"
#import "SuccessViewController.h"
@interface NewStep1ViewController ()

@end

@implementation NewStep1ViewController
@synthesize isDuplicate,duplicateDict;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    scrollView.contentSize = CGSizeMake(320, 660);
    [self registerForKeyboardNotifications];
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
        NSString *string = [[NSString alloc] initWithFormat:@"%@ - %@",[dict objectForKey:@"CurrSym"],[dict objectForKey:@"CurText"]];
        [currencyList addObject:string];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.taskbarView addSubview:[AppDelegate sharedInstance].taskbarView];
    if (isDuplicate) {
        titleLB.text = @"Duplicate";
        NSArray *tempArray = [dailyRateList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"CurrID1 = %@",[duplicateDict objectForKey:@"CurrMainID"]]];
        NSString *currencyString;
        if ([tempArray count] > 0) {
            NSDictionary *tempDict = [tempArray objectAtIndex:0];
            currencyString= [tempDict objectForKey:@"CurrSym"];
        }
        subTitle2.text = [NSString stringWithFormat:@"Duplicate payment for AUD against %@",currencyString];
        subTitleLB.hidden = YES;
    }
    else
    {
        subTitle2.hidden = YES;
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    if (!isViewDidLoad) {
        [self performSelectorInBackground:@selector(showProcess) withObject:nil];
        userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo];
        if ([ServiceManager checkUser:[userInfo objectForKey:@"UserName"] pass:[userInfo  objectForKey:@"UPassword"]]) {
            userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo];
        }
        if (![ServiceManager getDailyRates]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Can't connect to server!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
            [SVProgressHUD dismiss];
            return;
        }
        dailyRateList = [[NSUserDefaults standardUserDefaults] objectForKey:kDailyRateInfo];
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
        isViewDidLoad = YES;
        
    }
    bankNameTF.hidden = YES;
    if (isDuplicate) {
        
        NSArray *tempArray = [dailyRateList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"CurrID1 = %@",[duplicateDict objectForKey:@"CurrMainID"]]];
        NSString *currencyString;
        if ([tempArray count] > 0) {
            NSDictionary *tempDict = [tempArray objectAtIndex:0];
            currencyString= [tempDict objectForKey:@"CurrSym"];
        }
        int i=0;
        for (NSDictionary *dict in dailyRateList) {
            if ([[dict objectForKey:@"CurrSym"] isEqualToString:currencyString]) {
                break;
            }
            i++;
        }

            NSDictionary *dict = [dailyRateList objectAtIndex:i];
        currentIndex = i;
            fCurrencyTF.text = [[NSString alloc] initWithFormat:@"%@ - %@",[dict objectForKey:@"CurrSym"],[dict objectForKey:@"CurText"]];
        
        if ([[duplicateDict objectForKey:@"BankACID"] intValue]!=0) {
            NSString *bankID = [duplicateDict objectForKey:@"BankACID"];
            NSArray *bankList = [ServiceManager getBankDetail:bankID];
            if ([bankList count] > 0) {
                ishasBank = YES;
                NSDictionary *tempDict = [bankList objectAtIndex:0];
                bankNameTF.text = [NSString stringWithFormat:@"Bank: %@ - %@",[tempDict objectForKey:@"BankName"],[tempDict objectForKey:@"ACNo"]];
            }
        }
        
    }
    [SVProgressHUD dismiss];
    [super viewDidAppear:YES];
    [self didSelectMenuAtIndex:currentIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)home_click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)segment_Click:(id)sender {
    
    if (segment.selectedSegmentIndex == 1 && isDuplicate && ishasBank) {
        bankNameTF.hidden = NO;
    }
    else
    {
        bankNameTF.hidden = YES;
    }
    isOnlineGreat  = NO;
    [self didSelectMenuAtIndex:currentIndex];
}

- (IBAction)next_Click:(id)sender {
    if (purpostTF.text == nil || [purpostTF.text length] == 0
        ||[[purpostTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                             whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter your purpose of this transaction!"];
        return;
        
    }
    if (fCurrencyTF.text == nil || [fCurrencyTF.text length] == 0
        ||[[fCurrencyTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                            whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please select a foreign currency!"];
        return;
        
    }
    if ([paymentAmountTF.text doubleValue] == 0 || [paymentAmountTF.text doubleValue] < [lessCommission.text doubleValue]) {
        [Util showAlertWithString:@"Your payment not valid!"];
        return;
    }
   
    
    
    [self performSelectorInBackground:@selector(showProcess) withObject:nil];
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo];
    NSString *regid = [dict objectForKey:@"RegisterID"];
    int utype = [[userInfo objectForKey:@"UType"] intValue];
    int online = 0;
    if (utype == 0) {
        online = 1;
    }
    NSDictionary *dict2 = [dailyRateList objectAtIndex:currentIndex];
    int currID = [[dict2 objectForKey:@"CurrID"] intValue];
    BOOL result;
    if (!isDuplicate) {
        result = [ServiceManager submitStep1:regid curr:currID purpose:purpostTF.text PayMethod:segment.selectedSegmentIndex+1 PayAmount:paymentAmountTF.text Commision:lessCommission.text TranAmount:transferAmount.text ExRate:exchangeRate.text FAmount:foreignAmountTF.text Comments:commentTV.text online:online];
        [SVProgressHUD dismiss];
        if (result) {
            if (online == 0) {
                NewStep2ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewStep2ViewController"];
                [self.navigationController pushViewController:viewController animated:YES];
            }
            else
            {
                NSString *dateString = [dict objectForKey:@"IDExpiry"];
                dateString = [dateString stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
                dateString = [dateString substringToIndex:10];
                double rtimeInterval = [dateString doubleValue];
                if ([[NSDate date] timeIntervalSince1970] - rtimeInterval > 0) {
                    [Util showAlertWithString:@"Your ID has expired please update your new ID!"];
                    return;
                }

                [[NSUserDefaults standardUserDefaults] setObject:dict forKey:kSenderInfo];
                [[NSUserDefaults standardUserDefaults] setObject:[[dict objectForKey:@"RegisterID"] stringValue] forKey:kSenderID];
                [[NSUserDefaults standardUserDefaults] synchronize];
                NewStep3ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewStep3ViewController"];
                [self.navigationController pushViewController:viewController animated:YES];
            }
        }

    }
    else
    {
        NSString *bankID = [duplicateDict objectForKey:@"BankACID"];
        NSString *dateString = [dict objectForKey:@"IDExpiry"];
        dateString = [dateString stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
        dateString = [dateString substringToIndex:10];
        double rtimeInterval = [dateString doubleValue];
        if ([[NSDate date] timeIntervalSince1970] - rtimeInterval > 0) {
            [SVProgressHUD dismiss];
            [Util showAlertWithString:@"Your ID has expired please update your new ID!"];
            return;
        }
        if (segment.selectedSegmentIndex == 0) {
            bankID = @"0";
        }
        result = [ServiceManager submitDuplicate:regid remitID:[duplicateDict objectForKey:@"RemitId"] bnkID:bankID curr:0 purpose:purpostTF.text PayMethod:segment.selectedSegmentIndex+1 PayAmount:paymentAmountTF.text Comments:commentTV.text online:online];
        [SVProgressHUD dismiss];
        if (result) {
            SuccessViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SuccessViewController"];
            [self.navigationController pushViewController:viewController animated:YES];
        }

    }
    
    
}

- (IBAction)fcurrency_Click:(id)sender {
    if (isDuplicate) {
        return;
    }
    if (!popoverController) {
        UIButton *button = (UIButton*)sender;
		WEPopoverContentViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        contentViewController.delegate = self;
        contentViewController.menuList = currencyList;
        contentViewController.width = 210;
		popoverController = [[WEPopoverController alloc] initWithContentViewController:contentViewController] ;
        [contentViewController.tableView setScrollEnabled:YES];
        [contentViewController.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [contentViewController.tableView setShowsVerticalScrollIndicator:NO];
		popoverController.delegate = self;
		popoverController.passthroughViews = [NSArray arrayWithObject:self.navigationController.navigationBar];
        [popoverController presentPopoverFromRect:button.bounds inView:button permittedArrowDirections:(UIPopoverArrowDirectionUp) animated:YES];
        
	} else {
		[popoverController dismissPopoverAnimated:YES];
		popoverController = nil;
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    if (textField == paymentAmountTF || textField == foreignAmountTF) {
        NSString *newtext = [textField.text stringByAppendingString:string];
        if ([newtext doubleValue] == 0) {
            return NO;
        }
        NSString *newString = [textField.text stringByAppendingString:string];
        if (string.length == 0 && textField.text.length > 0) {
            newString = [textField.text substringToIndex:textField.text.length-1];
        }
        if (textField == paymentAmountTF) {
            double payment = [newString doubleValue];
            if (payment == 0) {
                transferAmount.text = @"";
                foreignAmountTF.text = @"";
                return YES;
            }
            NSDictionary *dict = [dailyRateList objectAtIndex:currentIndex];
            if (isOnlineGreat && segment.selectedSegmentIndex == 1) {
                if (payment < 2500) {
                    lessCommission.text = [[dict objectForKey:@"Less5"] stringValue];
                }
                else
                {
                    lessCommission.text = [[dict objectForKey:@"Great5"] stringValue];
                }
            }
            double transfer = payment - [lessCommission.text doubleValue];
            transferAmount.text = [NSString stringWithFormat:@"%.4f",transfer];
            double fAmount = transfer * [exchangeRate.text doubleValue];
            foreignAmountTF.text = [NSString stringWithFormat:@"%.4f",fAmount];
        }
        else
        {
            
            double transfer = [newString doubleValue] / [exchangeRate.text doubleValue];
            if (transfer == 0) {
                transferAmount.text = @"";
                paymentAmountTF.text = @"";
                return YES;
            }
            transferAmount.text = [NSString stringWithFormat:@"%.4f",transfer];
            double payment = transfer + [lessCommission.text doubleValue];
            paymentAmountTF.text = [NSString stringWithFormat:@"%.4f",payment];
            
        }
        NSLog(@"%@",newString);
    }
    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    activeField = textField;
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height+119;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height+119);
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark -
#pragma mark WEPopoverControllerDelegate implementation

- (void)popoverControllerDidDismissPopover:(WEPopoverController *)thePopoverController {
	//Safe to release the popover here
	popoverController = nil;
}

- (BOOL)popoverControllerShouldDismissPopover:(WEPopoverController *)thePopoverController
{
	return YES;
}

- (void)didSelectMenuAtIndex:(int)index
{
    currentIndex = index;
    fCurrencyTF.text = [currencyList objectAtIndex:index];
    NSDictionary *dict = [dailyRateList objectAtIndex:currentIndex];
    foreignAmount.text =  [dict objectForKey:@"CurrSym"];
    BOOL isSpecialCommon;
    
    if ([[userInfo objectForKey:@"CCommi"] doubleValue] == 0 && [[userInfo objectForKey:@"ACCommi"] doubleValue] == 0) {
        isSpecialCommon = NO;
    }
    else
    {
        isSpecialCommon = YES;
    }
    
    if (segment.selectedSegmentIndex == 0) {
        if (isSpecialCommon) {
            lessCommission.text = [[userInfo objectForKey:@"CCommi"] stringValue];
        }
        else
        {

                lessCommission.text = [[dict objectForKey:@"SComm"] stringValue];
            
        }
        
        exchangeRate.text = [NSString stringWithFormat:@"%.4f",[[dict objectForKey:@"ERateS"] floatValue]];
    }
    else
    {
        if (isSpecialCommon) {
            lessCommission.text = [[userInfo objectForKey:@"ACCommi"] stringValue];
        }
        else
        {
            if ([[userInfo objectForKey:@"UType"] intValue] == 0) {
                isOnlineGreat = YES;
                lessCommission.text = [[dict objectForKey:@"Less5"] stringValue];
            }
            else
            {
                lessCommission.text = [[dict objectForKey:@"LComm"] stringValue];
            }
        }
        exchangeRate.text = [NSString stringWithFormat:@"%.4f",[[dict objectForKey:@"ERate"] floatValue]];
    }
    
    [self calculate];
    [popoverController dismissPopoverAnimated:YES];
    popoverController = nil;
}


- (void)showProcess
{
    [SVProgressHUD showWithStatus:@"Loading"];
}

- (void)calculate
{
    NSDictionary *dict = [dailyRateList objectAtIndex:currentIndex];
    double payment = [paymentAmountTF.text doubleValue];
    if (isOnlineGreat && segment.selectedSegmentIndex == 1) {
        if (payment < 2500) {
            lessCommission.text = [[dict objectForKey:@"Less5"] stringValue];
        }
        else
        {
            lessCommission.text = [[dict objectForKey:@"Great5"] stringValue];
        }
    }
    if (payment == 0) {
        return;
    }
    double transfer = payment - [lessCommission.text doubleValue];
    transferAmount.text = [NSString stringWithFormat:@"%.4f",transfer];
    double fAmount = transfer * [exchangeRate.text doubleValue];
    foreignAmountTF.text = [NSString stringWithFormat:@"%.4f",fAmount];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
