//
//  ViewController.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedViewController : UIViewController<UIWebViewDelegate,UITableViewDataSource,UITableViewDelegate>
{

    IBOutlet UILabel *topTitleLB;
    NSArray *titleArray;
    NSArray *feedURLArray;
    NSDictionary *feedDict;
    NSArray *itemList;
    IBOutlet UITableView *feedTableView;
    BOOL isViewDidLoad;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
@property (nonatomic) int index;
- (IBAction)home_click:(id)sender;


@end
