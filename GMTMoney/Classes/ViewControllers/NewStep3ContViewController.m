//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "NewStep3ContViewController.h"
#import "AppDelegate.h"
#import "define.h"
#import "ServiceManager.h"
#import "NewStep4ViewController.h"
@interface NewStep3ContViewController ()

@end

@implementation NewStep3ContViewController

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
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"Step3CDate"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.taskbarView addSubview:[AppDelegate sharedInstance].taskbarView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
        [self performSelectorInBackground:@selector(showProcess) withObject:nil];
       // NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo];
        NSString *bene = [[NSUserDefaults standardUserDefaults] objectForKey:kBeneID];
        searchList = [ServiceManager searchBankForBeneID:bene];
        [SVProgressHUD dismiss];
    [searchTableView reloadData];
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



- (IBAction)next_Click:(id)sender
{
    if (selectedSender == -1) {
        [Util showAlertWithString:@"Please select a bank account!"];
        return;
    }
    NSDate *viewDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"Step3CDate"];
    if ([[NSDate date] timeIntervalSince1970] - [viewDate timeIntervalSince1970] > 60*10) {
        [Util showAlertWithString:@"Your session has expired!"];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        return;
    }
    NSDictionary *dict = [searchList objectAtIndex:selectedSender];
    [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"BankACID"] forKey:kBankID];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:kSelectedBank];
     [[NSUserDefaults standardUserDefaults] synchronize];
            //Confirm Screen
    NewStep4ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewStep4ViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
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
    UILabel *bankname = (UILabel*)[cell viewWithTag:1];
    UILabel *accountNum = (UILabel*)[cell viewWithTag:2];
    UILabel *holder = (UILabel*)[cell viewWithTag:3];
    bankname.text = [dict objectForKey:@"BankName"];
    accountNum.text = [dict objectForKey:@"ACNo"];
    holder.text = [dict objectForKey:@"AcHolderName"];
    UIImageView *image = (UIImageView*)[cell viewWithTag:4];
    image.hidden = YES;
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
