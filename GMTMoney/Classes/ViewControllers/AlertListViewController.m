//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "AlertListViewController.h"
#import "AppDelegate.h"
#import "ServiceManager.h"
#import "define.h"

@interface AlertListViewController ()

@end

@implementation AlertListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    rateList = [[NSUserDefaults standardUserDefaults] objectForKey:kDailyRateInfo];
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [rateList sortedArrayUsingDescriptors:sortDescriptors];
    rateList = [sortedArray mutableCopy];
    for (NSDictionary *dict in rateList) {
        if ([[dict objectForKey:@"CurrSym"] isEqualToString:@"AUD"]) {
            [rateList removeObject:dict];
            break;
        }
    }
	// Do any additional setup after loading the view, typically from a nib.

}


- (void)viewWillAppear:(BOOL)animated
{
    [self.taskbarView addSubview:[AppDelegate sharedInstance].taskbarView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self performSelectorInBackground:@selector(showProcess) withObject:nil];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *device_id = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceId];
    [ServiceManager getAlertWithDevice:device_id];
    if ([userDefault objectForKey:kAlarmInfo]) {
        alertList = [userDefault objectForKey:kAlarmInfo];
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date_added"
                                                     ascending:NO];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *sortedArray;
        sortedArray = [alertList sortedArrayUsingDescriptors:sortDescriptors];
        alertList = [sortedArray mutableCopy];
    }
    [rateTableView reloadData];
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)home_click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)refresh_Click:(id)sender {
    [self viewDidAppear:YES];
}

- (IBAction)sort:(id)sender {
    if (!isSearch) {
        rateTableView.editing = !rateTableView.editing;
    }
    
}

- (IBAction)unsubscribe_click:(id)sender {
    selectedSender = sender;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Do you want to unsubscribe?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"YES", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UITableViewCell *cell = (UITableViewCell*)((UIButton*)selectedSender).superview.superview;
        NSIndexPath *indexPath = [rateTableView indexPathForCell:cell];
        NSDictionary *dict  = [alertList objectAtIndex:indexPath.row];
        [self performSelectorInBackground:@selector(showProcess) withObject:nil];
        if ([ServiceManager deleteAlert:[dict objectForKey:@"alert_id"]]) {
            NSString *device_id = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceId];
            [ServiceManager getAlertWithDevice:device_id];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:kAlarmInfo]) {
                alertList = [[NSUserDefaults standardUserDefaults] objectForKey:kAlarmInfo];
                NSSortDescriptor *sortDescriptor;
                sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date_added"
                                                             ascending:NO];
                NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
                NSArray *sortedArray;
                sortedArray = [alertList sortedArrayUsingDescriptors:sortDescriptors];
                alertList = [sortedArray mutableCopy];
            }
            [rateTableView reloadData];
        }
        [SVProgressHUD dismiss];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSearch) {
        return  [searchArray count];
    }
    return [alertList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indentify = @"AlertCell";
    if (isShowCashRate) {
        indentify = @"DailyRateCell2";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    NSDictionary *dict;
    if (!isSearch) {
        dict  = [alertList objectAtIndex:indexPath.row];
    }
    else{
        dict = [searchArray objectAtIndex:indexPath.row];
    }
    UILabel *currSym = (UILabel*)[cell viewWithTag:1];
    NSArray *tempArray = [rateList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"CurrID = %i",[[dict objectForKey:@"currency_id"] intValue]]];
    if ([tempArray count] > 0) {
        NSDictionary *tempDict = [tempArray objectAtIndex:0];
        currSym.text = [NSString stringWithFormat:@"AUD/%@",[tempDict objectForKey:@"CurrSym"]];
    }
    
    UILabel *rate_alert = (UILabel*)[cell viewWithTag:2];
    rate_alert.text = [dict objectForKey:@"rate_alert"];
    UILabel *email = (UILabel*)[cell viewWithTag:3];
    email.text = [dict objectForKey:@"email"];
    UILabel *date = (UILabel*)[cell viewWithTag:4];
    date.text = [dict objectForKey:@"date_added"];
    UILabel *type = (UILabel*)[cell viewWithTag:5];
    if ([[dict objectForKey:@"device_token"] length] > 0) {
        type.text = @"Type: Email & Push";
    }
    else
    {
        type.text = @"Type: Email";
    }
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



-(BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return NO;
}

- (void)showProcess
{
    [SVProgressHUD showWithStatus:@"Loading"];
}
@end
