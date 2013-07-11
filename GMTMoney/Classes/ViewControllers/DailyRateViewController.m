//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "DailyRateViewController.h"
#import "AppDelegate.h"
#import "ServiceManager.h"
#import "define.h"

@interface DailyRateViewController ()

@end

@implementation DailyRateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    BOOL isSuccess = [ServiceManager getDailyRates];
    if (isSuccess) {
        dailyRateList = [userDefault objectForKey:kDailyRateInfo];
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dailyRateList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DailyRateCell"];
    NSDictionary *dict = [dailyRateList objectAtIndex:indexPath.row];
    UIImageView *imgView = (UIImageView*)[cell viewWithTag:1];
    UILabel *currSym = (UILabel*)[cell viewWithTag:2];
    UILabel *curText = (UILabel*)[cell viewWithTag:3];
    UILabel *eRate = (UILabel*)[cell viewWithTag:4];
    NSString *currency = [dict objectForKey:@"CurrSym"];
    currSym.text = currency;
    curText.text = [dict objectForKey:@"CurText"];
    eRate.text = [NSString stringWithFormat:@"%.4f",[[dict objectForKey:@"ERate"] floatValue]];
    NSString *imageName = [[currency substringToIndex:2] lowercaseString];
    imageName = [NSString stringWithFormat:@"%@.png",imageName];
    imgView.image = [UIImage imageNamed:imageName];
    return cell;
}


- (void)showProcess
{
    [SVProgressHUD showWithStatus:@"Loading"];
}
@end
