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
@interface NewStep1ViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate,UITextViewDelegate,WEPopoverContentViewControllerDelegate,WEPopoverControllerDelegate>
{
WEPopoverController *popoverController;
    IBOutlet UIScrollView *scrollView;
    UIView *activeField;
    IBOutlet UITextField *purpostTF;
    IBOutlet UITextField *paymentAmountTF;
    IBOutlet UITextField *foreignAmountTF;
    IBOutlet UITextField *fCurrencyTF;
    IBOutlet UISegmentedControl *segment;
    IBOutlet UITextField *lessCommission;
    IBOutlet UITextField *transferAmount;

    IBOutlet UITextField *exchangeRate;
    IBOutlet UITextView *commentTV;
    int currentIndex;
    NSMutableArray *currencyList;
    NSMutableArray *dailyRateList;
    IBOutlet UILabel *foreignAmount;
    BOOL isViewDidLoad;
    NSDictionary *userInfo;
    BOOL isOnlineGreat;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;

- (IBAction)segment_Click:(id)sender;

- (IBAction)next_Click:(id)sender;
- (IBAction)fcurrency_Click:(id)sender;
@end
