//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "NewStep3ViewController.h"
#import "AppDelegate.h"
#import "define.h"
#import "ServiceManager.h"
#import "NewStep3ContViewController.h"
#import "NewStep4ViewController.h"
@interface NewStep3ViewController ()

@end

@implementation NewStep3ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    selectedSender = -1;
	// Do any additional setup after loading the view, typically from a nib.
    //scrollView.contentSize = CGSizeMake(320, 660);
    //[self registerForKeyboardNotifications];
    searchByArray = [[NSArray alloc] initWithObjects:@"FirstName",@"Sur name",@"Company Name",@"Phone", nil];
    beneList = [[NSUserDefaults standardUserDefaults] objectForKey:kBeneInfo];
    countryList = [[NSUserDefaults standardUserDefaults] objectForKey:kCountryList];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"Step3Date"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.taskbarView addSubview:[AppDelegate sharedInstance].taskbarView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    //[self didSelectMenuAtIndex:currentIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)home_click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)select_Click:(id)sender {
    if (!popoverController) {
        UIButton *button = (UIButton*)sender;
		WEPopoverContentViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        contentViewController.delegate = self;
        contentViewController.menuList = searchByArray;
        contentViewController.width = 224;
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

- (IBAction)search_Click:(id)sender
{
    selectedSender = -1;
    [self performSelectorInBackground:@selector(showProcess) withObject:nil];
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo];
    NSString *regid = [dict objectForKey:@"RegisterID"];
    searchList = [ServiceManager searchBeneList:regid searchIndex:currentIndex searchString:searchTF.text];
    [SVProgressHUD dismiss];
    [searchTableView reloadData];
    [self.view endEditing:YES];
}

- (IBAction)next_Click:(id)sender
{
    if (selectedSender == -1) {
        [Util showAlertWithString:@"Please select a beneficiary!"];
        return;
    }
    NSDate *viewDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"Step3Date"];
    if ([[NSDate date] timeIntervalSince1970] - [viewDate timeIntervalSince1970] > 60*10) {
        [Util showAlertWithString:@"Your session has expired!"];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        return;
    }
    [self performSelectorInBackground:@selector(showProcess) withObject:nil];
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo];
    NSString *regid = [dict objectForKey:@"RegisterID"];
    int utype = [[dict objectForKey:@"UType"] intValue];
    int online = 0;
    if (utype == 0) {
        online = 1;
    }
    NSString *remid = [[NSUserDefaults standardUserDefaults] objectForKey:kRemitID];
    NSDictionary *senderDict = [searchList objectAtIndex:selectedSender];
    NSString *beneId = [senderDict objectForKey:@"BeneficiaryID"];
    int paytype = [[[NSUserDefaults standardUserDefaults] objectForKey:kPaymentType] intValue];
    BOOL result = [ServiceManager submitStep3:regid remid:remid benID:beneId paytype:paytype online:online];
    [SVProgressHUD dismiss];
    if (result) {
        [[NSUserDefaults standardUserDefaults] setObject:senderDict forKey:kBeneInfo];
        [[NSUserDefaults standardUserDefaults] setObject:beneId  forKey:kBeneID];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (paytype == 2) {
            NewStep3ContViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewStep3ContViewController"];
            [self.navigationController pushViewController:viewController animated:YES];
        }
        else
        {
            //Confirm Screen
            NewStep4ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewStep4ViewController"];
            [self.navigationController pushViewController:viewController animated:YES];
        }
        
    }
}

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
    searchByTF.text = [searchByArray objectAtIndex:index];
    [popoverController dismissPopoverAnimated:YES];
    popoverController = nil;
}

- (void)showProcess
{
    [SVProgressHUD showWithStatus:@"Loading"];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 57;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [searchList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indentify = @"SenderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    NSDictionary *dict = [searchList objectAtIndex:indexPath.row];
    UILabel *sendername = (UILabel*)[cell viewWithTag:1];
    UILabel *senderid = (UILabel*)[cell viewWithTag:2];
    UILabel *address = (UILabel*)[cell viewWithTag:3];
    UIImageView *image = (UIImageView*)[cell viewWithTag:4];
    image.hidden = YES;
    sendername.text = [NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"FirstN"],[dict objectForKey:@"SurN"]];
    senderid.text = [[dict objectForKey:@"BeneficiaryID"] stringValue];
    NSArray *tempArray = [countryList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"CountryID = %@",[dict objectForKey:@"CountryID"]]];
    NSString *country = @"";
    if ([tempArray count] > 0) {
        NSDictionary *tempDict = [tempArray objectAtIndex:0];
        country = [tempDict objectForKey:@"CountryName"];
    }

    address.text = [NSString stringWithFormat:@"%@ %@,%@,%@,%@",[dict objectForKey:@"AddL1"],[dict objectForKey:@"Cityy"],[dict objectForKey:@"States"],[dict objectForKey:@"PostCode"],country];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedSender != -1) {
        UITableViewCell *temp = [tableView cellForRowAtIndexPath:selectedIndexPath];
        UIImageView *image = (UIImageView*)[temp viewWithTag:4];
        image.hidden = YES;
    }
    selectedSender = indexPath.row;
    selectedIndexPath = indexPath;
    UITableViewCell *temp = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView *image = (UIImageView*)[temp viewWithTag:4];
    image.hidden = NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
