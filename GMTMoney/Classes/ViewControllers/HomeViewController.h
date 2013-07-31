//
//  ViewController.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UIAlertViewDelegate>
{
    BOOL isViewDidLoad;
    IBOutlet UIButton *loginButton;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)facebook_click:(id)sender;
- (IBAction)login_Click:(id)sender;
- (IBAction)account_Click:(id)sender;
- (IBAction)sms_Click:(id)sender;

@end
