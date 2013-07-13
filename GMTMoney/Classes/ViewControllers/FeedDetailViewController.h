//
//  ViewController.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedDetailViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *webview;
    BOOL isFinish;
    IBOutlet UILabel *titleLB;

}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *titleString;
@property (strong, nonatomic) NSString *description;
- (IBAction)home_click:(id)sender;


@end
