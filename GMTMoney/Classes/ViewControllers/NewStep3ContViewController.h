//
//  ViewController.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NewStep3ContViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray *searchByArray;
    NSArray *beneList;
    int currentIndex;
    NSArray *searchList;
    NSArray *countryList;
    IBOutlet UITableView *searchTableView;
    int selectedSender;
    NSIndexPath *selectedIndexPath;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;

- (IBAction)next_Click:(id)sender;

@end
