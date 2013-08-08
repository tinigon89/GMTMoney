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
@interface RateAlertViewController : UIViewController<UIWebViewDelegate,WEPopoverControllerDelegate,WEPopoverContentViewControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    IBOutlet UITextField *toTF;
    WEPopoverController *popoverController;
    int currentIndex;
    NSMutableArray *currencyList;
    NSMutableArray *dailyRateList;
    IBOutlet UITextField *emailTF;
    IBOutlet UITextField *rateAlertTF;
    IBOutlet UIButton *pushButton;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;
- (IBAction)to_Click:(id)sender;
- (IBAction)check_click:(id)sender;
- (IBAction)regist_Click:(id)sender;
@end
