//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "TranStatusViewController.h"
#import "AppDelegate.h"
#import "ServiceManager.h"
#import "define.h"
#import "NewStep1ViewController.h"
@interface TranStatusViewController ()

@end

@implementation TranStatusViewController
@synthesize isDuplicate,duplicateList;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dailyRates = [[NSUserDefaults standardUserDefaults] objectForKey:kDailyRateInfo];
    userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo];
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.taskbarView addSubview:[AppDelegate sharedInstance].taskbarView];

    titleLB.text = @"Transaction History";
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!isDuplicate) {
        [self performSelectorInBackground:@selector(showProcess) withObject:nil];
        
        NSString *regid = [userInfo objectForKey:@"RegisterID"];
        
        
        [ServiceManager getTransactionHistory:regid];
        transList = [[NSUserDefaults standardUserDefaults] objectForKey:kTransHistoryInfo];
        
        
        [transTableView reloadData];
        [SVProgressHUD dismiss];
    }
    else
    {
        titleLB.text = @"Transaction List";
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 159;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isDuplicate) {
        return [duplicateList count];
    }
    return [transList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indentify = @"TransStatusCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    
    NSDictionary *dict;
    if (isDuplicate) {
        dict = [duplicateList objectAtIndex:indexPath.row];
    }
    else
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        dict = [transList objectAtIndex:indexPath.row];
    }
    UILabel *idLB = (UILabel*)[cell viewWithTag:1];
    UILabel *dateLB = (UILabel*)[cell viewWithTag:2];
    UILabel *senderLB = (UILabel*)[cell viewWithTag:3];
    UILabel *beneLB = (UILabel*)[cell viewWithTag:4];
    UILabel *statusLB = (UILabel*)[cell viewWithTag:5];
    UILabel *depositLB = (UILabel*)[cell viewWithTag:6];
    UILabel *rateLB = (UILabel*)[cell viewWithTag:7];
    UILabel *amount = (UILabel*)[cell viewWithTag:8];
    UILabel *paymentType = (UILabel*)[cell viewWithTag:9];
    UILabel *bankInfo = (UILabel*)[cell viewWithTag:10];
    UILabel *accountNo = (UILabel*)[cell viewWithTag:11];
    idLB.text = [NSString stringWithFormat:@"OTT%@",[dict objectForKey:@"RemitId"]];
    depositLB.text = [NSString stringWithFormat:@"%.4f AUD",[[dict objectForKey:@"PayAmt"] floatValue]];
    rateLB.text = [NSString stringWithFormat:@"%.4f",[[dict objectForKey:@"ExRate"] floatValue]];
    NSArray *tempArray = [dailyRates filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"CurrID1 = %@",[dict objectForKey:@"CurrMainID"]]];

    if ([tempArray count] > 0) {
        NSDictionary *tempDict = [tempArray objectAtIndex:0];
        amount.text = [NSString stringWithFormat:@"%.4f %@",[[dict objectForKey:@"ForAmt"] floatValue],[tempDict objectForKey:@"CurrSym"]];
    }
    
    if ([[userInfo objectForKey:@"UType"] intValue] != 0) {
//        tempArray = [senderList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SendersID = %@",[dict objectForKey:@"SendersID"]]];
//        if ([tempArray count] > 0) {
//            NSDictionary *tempDict = [tempArray objectAtIndex:0];
//            senderLB.text = [NSString stringWithFormat:@"%@ %@",[tempDict objectForKey:@"FName"],[tempDict objectForKey:@"SurName"]];
//        }
//        else{
//            senderLB.text = @"";
//        }
        senderLB.text = [NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"Fname2"],[dict objectForKey:@"SurName2"]];
    }
    else
    {
        senderLB.text = [NSString stringWithFormat:@"%@ %@",[userInfo objectForKey:@"FName"],[userInfo objectForKey:@"SurName"]];
    }
    
    
//    tempArray = [beneList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"BeneficiaryID = %@",[dict objectForKey:@"BeneficiaryID"]]];
//    if ([tempArray count] > 0) {
//        NSDictionary *tempDict = [tempArray objectAtIndex:0];
        beneLB.text = [NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"FirstN"],[dict objectForKey:@"SurN"]];
   // }
    NSString *dateString = [dict objectForKey:@"RDate"];
    dateString = [dateString stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
    dateString = [dateString substringToIndex:10];
    double rtimeInterval = [dateString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:rtimeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"M/d/y h:mm a"];
    dateLB.text = [dateFormatter stringFromDate:date];
    paymentType.text = @"CASH PAYMENT";
    bankInfo.hidden = YES;
    accountNo.hidden = YES;
    if ([[dict objectForKey:@"Paymethod"] intValue] != 1) {
        paymentType.text = @"ACCOUNT DEPOSIT";
        bankInfo.text = [NSString stringWithFormat:@"Bank: %@",[dict objectForKey:@"BankName"]];
        bankInfo.hidden = NO;
        accountNo.hidden = NO;
        accountNo.text = [NSString stringWithFormat:@"AccNo: %@",[dict objectForKey:@"ACNo"]];
    }
    UIImageView *redImage = (UIImageView*)[cell viewWithTag:100];
    UIImageView *greenImage = (UIImageView*)[cell viewWithTag:101];
    if ([[dict objectForKey:@"RState"] intValue] == 1) {
        statusLB.text = @"PENDING";
        statusLB.textColor = [UIColor redColor];
        redImage.hidden = NO;
        greenImage.hidden = YES;
    }
    else
    {
        statusLB.text = @"PROCESSED";
        UIColor *myColor = [UIColor colorWithRed:6.0f/255.0f green:117.0f/255.0f blue:22.0f/255.0f alpha:1.0f];
        statusLB.textColor = myColor;
        redImage.hidden = YES;
        greenImage.hidden = NO;
    }
    //amount.text = [NSString stringWithFormat:@"%.4f %@",[[dict objectForKey:@"ForAmt"] floatValue],];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
    if (isDuplicate)
    {
        
        NSDictionary *dict = [duplicateList objectAtIndex:indexPath.row];
        if ([[dict objectForKey:@"RState"] intValue] == 1) {
            [Util showAlertWithString:@"This transaction must be processed before can duplicate"];
            return;
        }

        NewStep1ViewController *viewcontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"NewStep1ViewController"];
        viewcontroller.isDuplicate = YES;
        viewcontroller.duplicateDict = dict;
        [self.navigationController pushViewController:viewcontroller animated:YES];
        
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)home_click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showProcess
{
    [SVProgressHUD showWithStatus:@"Loading"];
}
@end
