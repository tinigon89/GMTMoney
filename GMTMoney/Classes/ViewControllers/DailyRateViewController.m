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
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo])
    {
        isShowCashRate = YES;
    }

}


- (void)viewWillAppear:(BOOL)animated
{
    [self.taskbarView addSubview:[AppDelegate sharedInstance].taskbarView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self performSelectorInBackground:@selector(showProcess) withObject:nil];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [ServiceManager getDailyRates];
    if ([userDefault objectForKey:kDailyRateInfo]) {
        dailyRateList = [userDefault objectForKey:kDailyRateInfo];
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order"
                                                     ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *sortedArray;
        sortedArray = [dailyRateList sortedArrayUsingDescriptors:sortDescriptors];
        dailyRateList = [sortedArray mutableCopy];;
    }
    [rateTableView reloadData];
    if ([userDefault objectForKey:kLastestUpdate]) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[userDefault doubleForKey:kLastestUpdate]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM/dd/y h:mm a"];
        lastestLB.text = [NSString stringWithFormat:@"Lastest update: %@",[formatter stringFromDate:date]];
    }
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

- (IBAction)refresh_Click:(id)sender {
    [self viewDidAppear:YES];
}

- (IBAction)sort:(id)sender {
    rateTableView.editing = !rateTableView.editing;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dailyRateList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isShowCashRate) {
        return 100;
    }
    return 57;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indentify = @"DailyRateCell";
    if (isShowCashRate) {
        indentify = @"DailyRateCell2";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    NSDictionary *dict = [dailyRateList objectAtIndex:indexPath.row];
    UIImageView *imgView = (UIImageView*)[cell viewWithTag:1];
    UILabel *currSym = (UILabel*)[cell viewWithTag:2];
    UILabel *curText = (UILabel*)[cell viewWithTag:3];
    UILabel *eRate = (UILabel*)[cell viewWithTag:4];
    
    NSString *currency = [dict objectForKey:@"CurrSym"];
    currSym.text = currency;
    curText.text = [dict objectForKey:@"CurText"];
    eRate.text = [NSString stringWithFormat:@"%.4f",[[dict objectForKey:@"ERate"] floatValue]];
    if (isShowCashRate) {
        UILabel *eRateS = (UILabel*)[cell viewWithTag:5];
        eRateS.text = [NSString stringWithFormat:@"%.4f",[[dict objectForKey:@"ERateS"] floatValue]];
    }
    
    NSString *imageName = [[currency substringToIndex:2] lowercaseString];
    imageName = [NSString stringWithFormat:@"%@.png",imageName];
    imgView.image = [UIImage imageNamed:imageName];
    cell.showsReorderControl = YES;
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

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSMutableDictionary *fromDict = [[dailyRateList objectAtIndex:sourceIndexPath.row] mutableCopy];
    NSMutableDictionary *toDict = [[dailyRateList objectAtIndex:destinationIndexPath.row] mutableCopy];
    int toOrder = [[toDict objectForKey:@"order"] intValue];
    [fromDict setObject:[NSNumber numberWithInt:toOrder] forKey:@"order"];
    [dailyRateList replaceObjectAtIndex:sourceIndexPath.row withObject:fromDict];
    if (sourceIndexPath.row > destinationIndexPath.row) {
        for (int i = destinationIndexPath.row; i < sourceIndexPath.row; i++) {
            NSMutableDictionary *dict = [[dailyRateList objectAtIndex:i] mutableCopy];
            int newOrder = [[dict objectForKey:@"order"] intValue];
            [dict setObject:[NSNumber numberWithInt:newOrder+1] forKey:@"order"];
            [dailyRateList replaceObjectAtIndex:i withObject:dict];
        }
    }
    else
    {
        for (int i = sourceIndexPath.row+1; i <= destinationIndexPath.row; i++) {
            NSMutableDictionary *dict = [[dailyRateList objectAtIndex:i] mutableCopy];
            int newOrder = [[dict objectForKey:@"order"] intValue];
            [dict setObject:[NSNumber numberWithInt:newOrder-1] forKey:@"order"];
            [dailyRateList replaceObjectAtIndex:i withObject:dict];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:dailyRateList forKey:kDailyRateInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order"
                                                     ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray;
    sortedArray = [dailyRateList sortedArrayUsingDescriptors:sortDescriptors];
    dailyRateList = [sortedArray mutableCopy];;
    [rateTableView reloadData];
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
