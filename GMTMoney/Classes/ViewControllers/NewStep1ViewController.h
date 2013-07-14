//
//  ViewController.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewStep1ViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{

    IBOutlet UIScrollView *scrollView;
    UIView *activeField;
    IBOutlet UITextField *purpostTF;
    IBOutlet UITextField *paymentAmountTF;
    IBOutlet UITextField *foreignAmountTF;

}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;


@end
