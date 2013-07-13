//
//  ViewController.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMSViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{

    IBOutlet UITextView *contentTV;
    IBOutlet UITextField *toTF;
    IBOutlet UILabel *titleLB;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;
- (IBAction)send_click:(id)sender;

@end
