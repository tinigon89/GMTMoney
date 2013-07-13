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
@interface CalculateViewController : UIViewController<UIWebViewDelegate,WEPopoverControllerDelegate,WEPopoverContentViewControllerDelegate,UITextFieldDelegate>
{
    IBOutlet UIWebView *webview;
    BOOL isFinish;
    IBOutlet UITextField *toTF;
    IBOutlet UITextField *amountTF;
    IBOutlet UITextField *rateTF;
    IBOutlet UITextField *totalAmountTF;
    WEPopoverController *popoverController;
    int currentIndex;
    NSMutableArray *currencyList;
    NSMutableArray *dailyRateList;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;
- (IBAction)to_Click:(id)sender;
- (IBAction)sendmoney_Click:(id)sender;
@end
