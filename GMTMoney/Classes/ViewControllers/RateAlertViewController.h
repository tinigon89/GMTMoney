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
@interface RateAlertViewController : UIViewController<UIWebViewDelegate,WEPopoverControllerDelegate,WEPopoverContentViewControllerDelegate,UITextFieldDelegate>
{
    IBOutlet UITextField *toTF;
    WEPopoverController *popoverController;
    int currentIndex;
    NSMutableArray *currencyList;
    NSMutableArray *dailyRateList;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;
- (IBAction)to_Click:(id)sender;
- (IBAction)check_click:(id)sender;
@end