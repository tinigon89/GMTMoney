//
//  ViewController.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookLikeView.h"
#import "Facebook.h"
@interface FacebookViewController : UIViewController<UIWebViewDelegate,FacebookLikeViewDelegate,FBSessionDelegate>
{
    Facebook *_facebook;
    IBOutlet UIWebView *webview;
    BOOL isFinish;
    IBOutlet FacebookLikeView *likeView;

}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;


@end
