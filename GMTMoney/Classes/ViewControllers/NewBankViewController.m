//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "NewBankViewController.h"
#import "AppDelegate.h"
#import "define.h"
#import "ServiceManager.h"
@interface NewBankViewController ()

@end

@implementation NewBankViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollView.contentSize = CGSizeMake(320, 780);
    countryList = [[NSUserDefaults standardUserDefaults] objectForKey:kCountryList];
    currentList = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *dict in countryList) {
        [currentList addObject:[dict objectForKey:@"CountryName"]];
    }
    indentifyList = [[NSArray alloc] initWithObjects:@"National ID Card",@"Driving Licence",@"Passport", nil];
    stateList = [[NSArray alloc] initWithObjects:@"NSW",@"ACT",@"VIC",@"QLD",@"SA",@"WA",@"NT",@"TAS",@"OTHER",@"N/A", nil];
    contactList = [[NSArray alloc] initWithObjects:@"HOME PHONE",@"WORK PHONE",@"MOBILE",@"FAX", nil];
    sourceList = [[NSArray alloc] initWithObjects:@"Website",@"Newspaper/Magazine",@"Poster",@"Printed/Web Article",@"Direct Post",@"Pamphlet",@"Internet search engineer",@"Email",@"Seminar",@"Tradeshow/Function",@"Word of Mouth",@"Others", nil];
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



- (IBAction)home_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)rcontry_Click:(id)sender {
    if (!popoverController) {
        selectedTF = rCountryTF;
        UIButton *button = (UIButton*)sender;
		WEPopoverContentViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        contentViewController.delegate = self;
        contentViewController.menuList = currentList;
        contentViewController.width = 200;
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

- (IBAction)sameabove_Click:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (!button.selected) {
        button.selected = YES;
    }
    else
    {
        button.selected = NO;
    }
}





- (IBAction)submit_Click:(id)sender
{
        
    if (fnameTF.text == nil || [fnameTF.text length] == 0
        ||[[fnameTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                             whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter account holder name!"];
        return;
        
    }        
    
    
    if (accountNumTF.text == nil || [accountNumTF.text length] == 0
        ||[[accountNumTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                             whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter account number!"];
        return;
        
    }
    
    if (bankNameTF.text == nil || [bankNameTF.text length] == 0
        ||[[bankNameTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                              whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter bank name!"];
        return;
        
    }
    
    
    
int rCountryID = [[[countryList  objectAtIndex:rCountryIndex] objectForKey:@"CountryID"] intValue];

    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo];
    NSString *beneId = [[[NSUserDefaults standardUserDefaults] objectForKey:kBeneID] stringValue];
    NSString *regid = [dict objectForKey:@"RegisterID"];
    [self performSelectorInBackground:@selector(showProcess) withObject:nil];
    BOOL success = [ServiceManager createNewbankWithRegid:regid BeneID:beneId ACHolderName:fnameTF.text ACNo:accountNumTF.text BankName:bankNameTF.text BankCode:bankCodeTF.text SwiftCode:swiftCodeTF.text RoutNo:routingNumberTF.text Add1:rstreetTF.text Add2:rsubburbTF.text City:rcityTF.text State:rstateTF.text PostCode:rpostcodeTF.text Country:rCountryID];
    if (success) {
        [Util showAlertWithString:@"Successful!"];
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
        return;
        
    }
    [SVProgressHUD dismiss];
}

- (void)showProcess
{
    [SVProgressHUD showWithStatus:@"Loading"];
}


- (void)showDatePickerView
{
    if (!datepicker) {
        datepicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, 0.0, 0.0)];
        datepicker.datePickerMode = UIDatePickerModeDate;
    }
    
    
    UIToolbar *pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    pickerDateToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerDateToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(buttonDoneClick)];
    [barItems addObject:doneBtn];
    
    [pickerDateToolbar setItems:barItems animated:YES];
    actionsheet = [[UIActionSheet alloc] init];
    [actionsheet addSubview:pickerDateToolbar];
    [actionsheet addSubview:datepicker];
    [actionsheet showInView:self.view];
    [actionsheet setBounds:CGRectMake(0,0,320, 464)];
}

- (void)buttonDoneClick
{
    [actionsheet dismissWithClickedButtonIndex:100 animated:YES];
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
    
     if ([selectedTF isEqual:rstateTF])
    {
        rstateIndex = index;
        rstateTF.text = [stateList objectAtIndex:index] ;
    }
    else if ([selectedTF isEqual:rCountryTF])
    {
        rCountryIndex = index;
        rCountryTF.text = [currentList objectAtIndex:index] ;
    }

    
    [popoverController dismissPopoverAnimated:YES];
    popoverController = nil;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
