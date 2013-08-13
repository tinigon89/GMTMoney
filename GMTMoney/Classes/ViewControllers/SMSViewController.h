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
@interface SMSViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,WEPopoverControllerDelegate,WEPopoverContentViewControllerDelegate>
{
    WEPopoverController *popoverController;
    WEPopoverController *popoverController2;
    int currentIndex;
    IBOutlet UILabel *smsLabel;
    IBOutlet UITextView *contentTV;
    IBOutlet UITextField *toTF;
    IBOutlet UILabel *titleLB;
    IBOutlet UIButton *codeAreaBT;
    NSArray *codeList;
    NSMutableArray *allContactsPhoneNumber;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;
- (IBAction)send_click:(id)sender;
- (IBAction)codeArea_Click:(id)sender;

@end
