//
//  ViewController.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEPopoverController.h"
#import "WEPopoverContentViewController.h"
@interface NewStep3ViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate,UITextViewDelegate,WEPopoverContentViewControllerDelegate,WEPopoverControllerDelegate,UITableViewDataSource,UITableViewDelegate>
{
WEPopoverController *popoverController;
    NSArray *searchByArray;
    NSArray *beneList;
    int currentIndex;
    IBOutlet UITextField *searchByTF;
    IBOutlet UITextField *searchTF;
    NSArray *searchList;
    NSArray *countryList;
    IBOutlet UITableView *searchTableView;
    int selectedSender;
    NSIndexPath *selectedIndexPath;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;
- (IBAction)select_Click:(id)sender;
- (IBAction)search_Click:(id)sender;
- (IBAction)next_Click:(id)sender;

@end
