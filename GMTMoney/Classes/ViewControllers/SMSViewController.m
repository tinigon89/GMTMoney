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
#import <AddressBook/AddressBook.h>
@interface SMSViewController ()

@end

@implementation SMSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    codeList = [[NSArray alloc] initWithObjects:@"+61",@"+91",@"+85", nil];
    
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    __block BOOL accessGranted = NO;
    
    if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else { // we're on iOS 5 or older
        accessGranted = YES;
    }
    NSArray *arrayOfPeople = nil;
    if (accessGranted) {
        
        arrayOfPeople = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
        // Do whatever you need with thePeople...
        
    }
    
    NSUInteger index = 0;
    allContactsPhoneNumber = [[NSMutableArray alloc] init];
    
    for(index = 0; index<=([arrayOfPeople count]-1); index++){
        
        ABRecordRef currentPerson =
        (__bridge ABRecordRef)[arrayOfPeople objectAtIndex:index];
        NSString *name = [self getName:currentPerson];
        NSArray *phones =
        (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(
                                                             ABRecordCopyValue(currentPerson, kABPersonPhoneProperty));
        
        // Make sure that the selected contact has one phone at least filled in.
        if ([phones count] > 0) {
            // We'll use the first phone number only here.
            // In a real app, it's up to you to play around with the returned values and pick the necessary value.
            NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:name,@"name",[phones objectAtIndex:0],@"phone", nil];
            [allContactsPhoneNumber addObject:dict];
        }
        else{
            //[allContactsPhoneNumber addObject:@"No phone number was set."];
        }
    }
    NSLog(@"%i",[allContactsPhoneNumber count]);
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *dict in allContactsPhoneNumber) {
        NSString *phone = [dict objectForKey:@"phone"];
        NSString *name = [dict objectForKey:@"name"];
        NSString *subString = [phone substringToIndex:3];
        if ([subString isEqualToString:@"+61"] || [subString isEqualToString:@"+91"] || [subString isEqualToString:@"+85"]) {
            NSString *string = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:name,@"name",string,@"phone", nil];
            [tempArray addObject:dict];
        }
    }
    allContactsPhoneNumber = tempArray;
}

- (NSString *) getName: (ABRecordRef) person
{
    NSString *firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString *lastName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    NSString *biz = (__bridge NSString *)ABRecordCopyValue(person, kABPersonOrganizationProperty);
    
    
    if ((!firstName) && !(lastName))
    {
        if (biz) return biz;
        return @"[No name supplied]";
    }
    
    if (!lastName) lastName = @"";
    if (!firstName) firstName = @"";
    
    return [NSString stringWithFormat:@"%@ %@", firstName, lastName];
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
    if (popoverController2) {
        [popoverController2 dismissPopoverAnimated:NO];
        popoverController2 = nil;
    }
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
    if ([string isEqualToString:filtered]) {
        NSString *newString = [textField.text stringByAppendingString:string];
        if (string.length == 0 && textField.text.length > 0) {
            newString = [textField.text substringToIndex:textField.text.length-1];
        }
        if (popoverController) {
            [popoverController dismissPopoverAnimated:NO];
            popoverController = nil;
        }
        if ([allContactsPhoneNumber count] > 0) {
            
        
        NSString *toNumber = [NSString stringWithFormat:@"%@%@",[codeList objectAtIndex:currentIndex],newString];
        NSPredicate *sPredicate = [NSPredicate predicateWithFormat:@"phone CONTAINS[cd] %@", toNumber];
        NSArray *tempArray = [allContactsPhoneNumber filteredArrayUsingPredicate:sPredicate];
        NSMutableArray *menuList = [[NSMutableArray alloc] initWithCapacity:0];
        NSMutableArray *subMenulist = [[NSMutableArray alloc] initWithCapacity:0];
        
        for (NSDictionary *dict in tempArray) {
            [menuList addObject:[dict objectForKey:@"name"]];
            [subMenulist addObject:[dict objectForKey:@"phone"]];
        }
       // NSArray *tempArray = [allContactsPhoneNumber filteredArrayUsingPredicate:sPredicate];
        //if (!popoverController2) {
            //UIButton *button = (UIButton*)sender;
            WEPopoverContentViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
            contentViewController.delegate = self;
            contentViewController.menuList = menuList;
            contentViewController.subtitleList = subMenulist;
            contentViewController.width = 250;
            popoverController2 = [[WEPopoverController alloc] initWithContentViewController:contentViewController] ;
            [contentViewController.tableView setScrollEnabled:YES];
            [contentViewController.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
            [contentViewController.tableView setShowsVerticalScrollIndicator:NO];
            popoverController2.delegate = self;
            popoverController2.passthroughViews = [NSArray arrayWithObject:self.navigationController.navigationBar];
            
            //		[popoverController presentPopoverFromBarButtonItem:sender
            //                                  permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown)
            //                                                  animated:YES];
            [popoverController2 presentPopoverFromRect:textField.bounds inView:textField permittedArrowDirections:(UIPopoverArrowDirectionUp) animated:YES];
            
//        } else {
//            WEPopoverContentViewController *contentViewController = (WEPopoverContentViewController*)popoverController2.contentViewController;
//            contentViewController.menuList = menuList;
//            contentViewController.subtitleList = subMenulist;
//            [contentViewController refreshMenu];
//           // popoverController = nil;
//        }
        }
    }
    return [string isEqualToString:filtered];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length+1 <= 160) {
        return YES;
    }
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (popoverController2) {
        [popoverController2 dismissPopoverAnimated:NO];
        popoverController2 = nil;
    }
    return YES;
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
    if (!popoverController2) {
        currentIndex = index;
        [codeAreaBT setTitle:[codeList objectAtIndex:index] forState:UIControlStateNormal];
        [popoverController dismissPopoverAnimated:YES];
        popoverController = nil;
    }
    else
    {
    NSString *toNumber = [NSString stringWithFormat:@"%@%@",[codeList objectAtIndex:currentIndex],toTF.text];
    NSPredicate *sPredicate = [NSPredicate predicateWithFormat:@"phone CONTAINS[cd] %@", toNumber];
    NSArray *result = [allContactsPhoneNumber filteredArrayUsingPredicate:sPredicate];
    if ([result count]>index) {
        toTF.text = [[[result objectAtIndex:index] objectForKey:@"phone"] substringFromIndex:3];
    }
        [popoverController2 dismissPopoverAnimated:NO];
        popoverController2 = nil;
    }
}
@end
