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
@interface TranStatusViewController ()

@end

@implementation TranStatusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dailyRates = [[NSUserDefaults standardUserDefaults] objectForKey:kDailyRateInfo];
    senderList = [[NSUserDefaults standardUserDefaults] objectForKey:kSenderInfo];
    beneList = [[NSUserDefaults standardUserDefaults] objectForKey:kBeneInfo];
    userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo];
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.taskbarView addSubview:[AppDelegate sharedInstance].taskbarView];

    titleLB.text = @"Transaction History";
}

- (void)viewDidAppear:(BOOL)animated
{
    [self performSelectorInBackground:@selector(showProcess) withObject:nil];

    NSString *regid = [userInfo objectForKey:@"RegisterID"];

    [ServiceManager getTransactionStatus:regid];
    transList = [[NSUserDefaults standardUserDefaults] objectForKey:kTransStatusInfo];
    
    
    [transTableView reloadData];
    [SVProgressHUD dismiss];
    
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
    return [transList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indentify = @"TransStatusCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    NSDictionary *dict = [transList objectAtIndex:indexPath.row];
    UILabel *idLB = (UILabel*)[cell viewWithTag:1];
    UILabel *dateLB = (UILabel*)[cell viewWithTag:2];
    UILabel *senderLB = (UILabel*)[cell viewWithTag:3];
    UILabel *beneLB = (UILabel*)[cell viewWithTag:4];
    UILabel *statusLB = (UILabel*)[cell viewWithTag:5];
    UILabel *depositLB = (UILabel*)[cell viewWithTag:6];
    UILabel *rateLB = (UILabel*)[cell viewWithTag:7];
    UILabel *amount = (UILabel*)[cell viewWithTag:8];
    UILabel *paymentType = (UILabel*)[cell viewWithTag:9];
    
    idLB.text = [NSString stringWithFormat:@"OTT%@",[dict objectForKey:@"RemitId"]];
    depositLB.text = [NSString stringWithFormat:@"%.4f AUD",[[dict objectForKey:@"PayAmt"] floatValue]];
    rateLB.text = [NSString stringWithFormat:@"%.4f",[[dict objectForKey:@"ExRate"] floatValue]];
    NSArray *tempArray = [dailyRates filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"CurrID1 = %@",[dict objectForKey:@"CurrMainID"]]];

    if ([tempArray count] > 0) {
        NSDictionary *tempDict = [tempArray objectAtIndex:0];
        amount.text = [NSString stringWithFormat:@"%.4f %@",[[dict objectForKey:@"ForAmt"] floatValue],[tempDict objectForKey:@"CurrSym"]];
    }
    
    if ([[userInfo objectForKey:@"UType"] intValue] != 0) {
        tempArray = [senderList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SendersID = %@",[dict objectForKey:@"SendersID"]]];
        if ([tempArray count] > 0) {
            NSDictionary *tempDict = [tempArray objectAtIndex:0];
            senderLB.text = [NSString stringWithFormat:@"%@ %@",[tempDict objectForKey:@"FName"],[tempDict objectForKey:@"SurName"]];
        }
    }
    else
    {
        senderLB.text = [NSString stringWithFormat:@"%@ %@",[userInfo objectForKey:@"FName"],[userInfo objectForKey:@"SurName"]];
    }
    
    
    tempArray = [beneList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"BeneficiaryID = %@",[dict objectForKey:@"BeneficiaryID"]]];
    if ([tempArray count] > 0) {
        NSDictionary *tempDict = [tempArray objectAtIndex:0];
        beneLB.text = [NSString stringWithFormat:@"%@ %@",[tempDict objectForKey:@"FirstN"],[tempDict objectForKey:@"SurN"]];
    }
    NSString *dateString = [dict objectForKey:@"RDate"];
    dateString = [dateString stringByReplacingOccurrencesOfString:@"/Date(" withString:@""];
    dateString = [dateString stringByReplacingOccurrencesOfString:@"000)/" withString:@""];
    double rtimeInterval = [dateString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:rtimeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"M/d/y h:mm a"];
    dateLB.text = [dateFormatter stringFromDate:date];
    paymentType.text = @"CASH PAYMENT";
    if ([[dict objectForKey:@"Paymethod"] intValue] != 1) {
        paymentType.text = @"ACCOUNT DEPOSIT";
    }
    if ([[dict objectForKey:@"RState"] intValue] == 1) {
        statusLB.text = @"PENDING";
    }
    else
    {
        statusLB.text = @"PROCESSED";
    }
    //amount.text = [NSString stringWithFormat:@"%.4f %@",[[dict objectForKey:@"ForAmt"] floatValue],];
    return cell;
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
