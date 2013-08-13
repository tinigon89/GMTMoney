//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "NewSenderViewController.h"
#import "AppDelegate.h"
#import "define.h"
#import "ServiceManager.h"
@interface NewSenderViewController ()

@end

@implementation NewSenderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
    scrollView.contentSize = CGSizeMake(320, 1300);
    if(IS_IPAD())
    {
        scrollView.contentSize = CGSizeMake(768, 900);
    }
    countryList = [[NSUserDefaults standardUserDefaults] objectForKey:kCountryList];
    currentList = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *dict in countryList) {
        [currentList addObject:[dict objectForKey:@"CountryName"]];
    }
    indentifyList = [[NSArray alloc] initWithObjects:@"Alien registration number",@"Bank account",@"Benefits card/ID",@"Birth certificate",@"Business registration/licence",@"Credit/debit card",@"Customer account/ID",@"Driver's licence",@"Employee ID",@"Employer number",@"Identity card/number",@"Membership ID",@"Passport",@"Photo ID",@"Security ID",@"Social security ID",@"Student ID",@"Tax number/ID", nil];
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

- (IBAction)dateofbirth_Click:(id)sender
{
    selectedTF = dateofbirthTF;
    [self showDatePickerView];
}

- (IBAction)nation_Click:(id)sender
{
    if (!popoverController) {
        selectedTF = nationTF;
        UIButton *button = (UIButton*)sender;
		WEPopoverContentViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        contentViewController.delegate = self;
        contentViewController.menuList = currentList;
        contentViewController.width = 188;
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

- (IBAction)ident_Click:(id)sender
{
    if (!popoverController) {
        selectedTF = identificationTF;
        UIButton *button = (UIButton*)sender;
		WEPopoverContentViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        contentViewController.delegate = self;
        contentViewController.menuList = indentifyList;
        contentViewController.width = 188;
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

- (IBAction)idexpired_Click:(id)sender
{
    selectedTF = idExpiredTF;
    [self showDatePickerView];
}

- (IBAction)rstart_Click:(id)sender {
    if (!popoverController) {
        selectedTF = rstateTF;
        UIButton *button = (UIButton*)sender;
		WEPopoverContentViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        contentViewController.delegate = self;
        contentViewController.menuList = stateList;
        contentViewController.width = 188;
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

- (IBAction)rcontry_Click:(id)sender {
    if (!popoverController) {
        selectedTF = rCountryTF;
        UIButton *button = (UIButton*)sender;
		WEPopoverContentViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        contentViewController.delegate = self;
        contentViewController.menuList = currentList;
        contentViewController.width = 188;
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

- (IBAction)pstate_Click:(id)sender {
    if (!popoverController) {
        selectedTF = pstateTF;
        UIButton *button = (UIButton*)sender;
		WEPopoverContentViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        contentViewController.delegate = self;
        contentViewController.menuList = stateList;
        contentViewController.width = 188;
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

- (IBAction)pcountry_Click:(id)sender {
    if (!popoverController) {
        selectedTF = pCountryTF;
        UIButton *button = (UIButton*)sender;
		WEPopoverContentViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        contentViewController.delegate = self;
        contentViewController.menuList = currentList;
        contentViewController.width = 188;
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

- (IBAction)pcontact_Click:(id)sender {
    if (!popoverController) {
        selectedTF = pContact1;
        UIButton *button = (UIButton*)sender;
		WEPopoverContentViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        contentViewController.delegate = self;
        contentViewController.menuList = contactList;
        contentViewController.width = 188;
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

- (IBAction)sContact_Click:(id)sender {
    if (!popoverController) {
        selectedTF = sContact1TF;
        UIButton *button = (UIButton*)sender;
		WEPopoverContentViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        contentViewController.delegate = self;
        contentViewController.menuList = contactList;
        contentViewController.width = 188;
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

- (IBAction)accept_Click:(id)sender {
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
        
        [Util showAlertWithString:@"Please enter your first name!"];
        return;
        
    }
    
    if (snameTF.text == nil || [snameTF.text length] == 0
        ||[[snameTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                          whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter your last name!"];
        return;
        
    }
    
    if (dateofbirthTF.text == nil || [dateofbirthTF.text length] == 0
        ||[[dateofbirthTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                          whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please select date of birth!"];
        return;
        
    }
    
    if (identificationTF.text == nil || [identificationTF.text length] == 0
        ||[[identificationTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                                whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please select identification!"];
        return;
        
    }
    
    if (idnumTF.text == nil || [idnumTF.text length] == 0
        ||[[idnumTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                          whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter your identification number!"];
        return;
        
    }
    
    if (idExpiredTF.text == nil || [idExpiredTF.text length] == 0
        ||[[idExpiredTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                                   whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please select id expiry!"];
        return;
        
    }

    if (idIssuerTF.text == nil || [idIssuerTF.text length] == 0
        ||[[idIssuerTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                          whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter ID issuer!"];
        return;
        
    }
    
    if (occupation.text == nil || [occupation.text length] == 0
        ||[[occupation.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                             whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter your occupation!"];
        return;
        
    }
    
    if (rstreetTF.text == nil || [rstreetTF.text length] == 0
        ||[[rstreetTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                             whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter street address!"];
        return;
        
    }
    
    if (rsubburbTF.text == nil || [rsubburbTF.text length] == 0
        ||[[rsubburbTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                            whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter subburb!"];
        return;
        
    }
    
    if (rstateTF.text == nil || [rstateTF.text length] == 0
        ||[[rstateTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                              whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please select state!"];
        return;
        
    }
    
    if (rpostcodeTF.text == nil || [rpostcodeTF.text length] == 0
        ||[[rpostcodeTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                             whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter postcode!"];
        return;
        
    }
    
    if (rCountryTF.text == nil || [rCountryTF.text length] == 0
        ||[[rCountryTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                           whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please select country!"];
        return;
        
    }
    
    if(!pSameAboveBT.selected)
    {
        if (pstreetTF.text == nil || [pstreetTF.text length] == 0
            ||[[pstreetTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                                whitespaceAndNewlineCharacterSet]] length] == 0 )
        {
            
            [Util showAlertWithString:@"Please enter street address in postal address!"];
            return;
            
        }
        
        if (psubburbTF.text == nil || [psubburbTF.text length] == 0
            ||[[psubburbTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                                 whitespaceAndNewlineCharacterSet]] length] == 0 )
        {
            
            [Util showAlertWithString:@"Please enter subburb in postal address!"];
            return;
            
        }
        
        if (pstateTF.text == nil || [pstateTF.text length] == 0
            ||[[pstateTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                               whitespaceAndNewlineCharacterSet]] length] == 0 )
        {
            
            [Util showAlertWithString:@"Please select state in postal address!"];
            return;
            
        }
        
        if (ppostcodeTF.text == nil || [ppostcodeTF.text length] == 0
            ||[[ppostcodeTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                                  whitespaceAndNewlineCharacterSet]] length] == 0 )
        {
            
            [Util showAlertWithString:@"Please enter postcode in postal address!"];
            return;
            
        }
        
        if (pCountryTF.text == nil || [pCountryTF.text length] == 0
            ||[[pCountryTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                                 whitespaceAndNewlineCharacterSet]] length] == 0 )
        {
            
            [Util showAlertWithString:@"Please select country in postal address!"];
            return;
            
        }
    }
    
    
    if (pContact1.text == nil || [pContact1.text length] == 0
        ||[[pContact1.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                           whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please select primary contact type!"];
        return;
        
    }
    
    if (pContact2TF.text == nil || [pContact2TF.text length] == 0
        ||[[pContact2TF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                              whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter primary contact info!"];
        return;
        
    }
    
    if (emailTF.text == nil || [emailTF.text length] == 0
        ||[[emailTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                              whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter email!"];
        return;
        
    }
    
    
int nationID = [[[countryList  objectAtIndex:nationIndex] objectForKey:@"CountryID"] intValue];
int rCountryID = [[[countryList  objectAtIndex:rCountryIndex] objectForKey:@"CountryID"] intValue];
NSString *street = rstreetTF.text;
NSString *sub = rsubburbTF.text;
NSString *state = rstateTF.text;
NSString *postcode = rpostcodeTF.text;
int pCountryID = rCountryID;
    if(!pSameAboveBT.selected)
{
    street = pstreetTF.text;
    sub = psubburbTF.text;
    state = pstateTF.text;
    postcode = ppostcodeTF.text;
    pCountryID = [[[countryList  objectAtIndex:pCountryIndex] objectForKey:@"CountryID"] intValue];
}
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo];
    NSString *regid = [dict objectForKey:@"RegisterID"];
    [self performSelectorInBackground:@selector(showProcess) withObject:nil];
    BOOL success = [ServiceManager createNewSenderWithRegid:regid email:emailTF.text FName:fnameTF.text SurName:snameTF.text BisName:bnameTF.text DBirth:dateofbirthTF.text NationID:nationID IdentyID:identIndex+1 IdCode:idnumTF.text IDExpiry:idExpiredTF.text IDIssuer:idIssuerTF.text Occup:occupation.text RStreet:rstreetTF.text RSub:rsubburbTF.text RState:rstateTF.text RPost:rpostcodeTF.text RCountryID:rCountryID PStatus:pSameAboveBT.selected PStreet:street PSub:sub PState:state PPost:postcode PCountryID:pCountryID PCDet:[NSString stringWithFormat:@"%i",pContactIndex] PContact:pContact2TF.text SCDet:[NSString stringWithFormat:@"%i",sContactIndex] SContact:sContact2TF.text];
    if (success) {
        [SVProgressHUD dismiss];
        [Util showAlertWithString:@"Successful!"];
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
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"y/MM/dd"];
    if (selectedTF == dateofbirthTF) {
        dateofbirthTF.text = [formatter stringFromDate:datepicker.date];
    }
    else if(selectedTF == idExpiredTF)
    {
        idExpiredTF.text = [formatter stringFromDate:datepicker.date];
    }
    
    
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

- (BOOL)popoverControllerShouldDismissPopover:(WEPopoverController *)thePopoverController {
	//The popover is automatically dismissed if you click outside it, unless you return NO here
	return YES;
}

- (void)didSelectMenuAtIndex:(int)index
{
    if ([selectedTF isEqual:nationTF]) {
        nationIndex = index;
        nationTF.text = [currentList objectAtIndex:index] ;
    }
    else if ([selectedTF isEqual:identificationTF])
    {
        identIndex = index;
        identificationTF.text = [indentifyList objectAtIndex:index] ;
    }
    else if ([selectedTF isEqual:rstateTF])
    {
        rstateIndex = index;
        rstateTF.text = [stateList objectAtIndex:index] ;
    }
    else if ([selectedTF isEqual:rCountryTF])
    {
        rCountryIndex = index;
        rCountryTF.text = [currentList objectAtIndex:index] ;
    }
    else if ([selectedTF isEqual:pstateTF])
    {
        pstateIndex = index;
        pstateTF.text = [stateList objectAtIndex:index] ;
    }
    else if ([selectedTF isEqual:pCountryTF])
    {
        rCountryIndex = index;
        pCountryTF.text = [currentList objectAtIndex:index] ;
    }
    else if ([selectedTF isEqual:pContact1])
    {
        pContactIndex = index;
        pContact1.text = [contactList objectAtIndex:index] ;
    }
    else if ([selectedTF isEqual:sContact1TF])
    {
        sContactIndex = index;
        sContact1TF.text = [contactList objectAtIndex:index] ;
    }
    
    [popoverController dismissPopoverAnimated:YES];
    popoverController = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    activeField = textField;
    return YES;
}
@end
