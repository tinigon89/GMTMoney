//
//  ViewController.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertListViewController : UIViewController<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *rateTableView;
    NSMutableArray *rateList;
    NSMutableArray *alertList;
    IBOutlet UILabel *lastestLB;
    BOOL isShowCashRate;
    BOOL isSearch;
    NSArray *searchArray;
    IBOutlet UISearchBar *rateSearchBar;
    id selectedSender;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;
- (IBAction)refresh_Click:(id)sender;
- (IBAction)sort:(id)sender;
- (IBAction)unsubscribe_click:(id)sender;

@end
