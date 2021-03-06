//
//  ViewController.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyRateViewController : UIViewController<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *rateTableView;
    NSMutableArray *dailyRateList;
    IBOutlet UILabel *lastestLB;
    BOOL isShowCashRate;
    BOOL isSearch;
    NSArray *searchArray;
    IBOutlet UISearchBar *rateSearchBar;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;
- (IBAction)refresh_Click:(id)sender;
- (IBAction)sort:(id)sender;

@end
