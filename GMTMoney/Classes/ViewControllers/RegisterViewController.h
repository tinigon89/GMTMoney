//
//  ViewController.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *webview;
    BOOL isFinish;
    IBOutlet UIScrollView *scrollView;

}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;


@end