//
//  ViewController.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TranStatusViewController : UIViewController<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>
{

    IBOutlet UITableView *transTableView;
    NSArray *transList;
    NSArray *dailyRates;
    
    NSDictionary *userInfo;
    IBOutlet UILabel *titleLB;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
@property (nonatomic) BOOL isDuplicate;
@property (strong, nonatomic) NSArray *duplicateList;
- (IBAction)home_click:(id)sender;


@end
