//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "NewBenViewController.h"
#import "AppDelegate.h"
#import "define.h"
#import "ServiceManager.h"
@interface NewBenViewController ()

@end

@implementation NewBenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollView.contentSize = CGSizeMake(320, 900);
    if(IS_IPAD())
    {
        scrollView.contentSize = CGSizeMake(768, 800);
    }
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
    
    
    if (rstreetTF.text == nil || [rstreetTF.text length] == 0
        ||[[rstreetTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                             whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter street address!"];
        return;
        
    }
    
    if (rcityTF.text == nil || [rcityTF.text length] == 0
        ||[[rcityTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                              whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter city!"];
        return;
        
    }
    
    if (rstateTF.text == nil || [rstateTF.text length] == 0
        ||[[rstateTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                          whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please enter State!"];
        return;
        
    }
    
    if (rCountryTF.text == nil || [rCountryTF.text length] == 0
        ||[[rCountryTF.text stringByTrimmingCharactersInSet:[NSCharacterSet
                                                           whitespaceAndNewlineCharacterSet]] length] == 0 )
    {
        
        [Util showAlertWithString:@"Please select country!"];
        return;
        
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
    
int rCountryID = [[[countryList  objectAtIndex:rCountryIndex] objectForKey:@"CountryID"] intValue];

    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo];
    NSString *regid = [dict objectForKey:@"RegisterID"];
    [self performSelectorInBackground:@selector(showProcess) withObject:nil];
    BOOL success = [ServiceManager createNewBeneWithRegid:regid email:emailTF.text FName:fnameTF.text SurName:snameTF.text BisName:bnameTF.text IdentyID:[indentifyList objectAtIndex:identIndex] IdCode:idnumTF.text RStreet:rstreetTF.text RSub:rsubburbTF.text City:rcityTF.text RState:rstateTF.text RPost:rpostcodeTF.text RCountryID:rCountryID PCDet:[NSString stringWithFormat:@"%i",pContactIndex] PContact:pContact2TF.text SCDet:[NSString stringWithFormat:@"%i",sContactIndex] SContact:sContact2TF.text];
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
    
    if ([selectedTF isEqual:identificationTF])
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
@end
