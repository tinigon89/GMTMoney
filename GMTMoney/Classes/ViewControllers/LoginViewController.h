//
//  ViewController.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UIWebViewDelegate>
{

    IBOutlet UITextField *userIDTF;
    IBOutlet UITextField *passwordTF;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;
- (IBAction)login_Click:(id)sender;
- (IBAction)register_Click:(id)sender;

- (IBAction)forgot_Click:(id)sender;

@end
