//
//  ViewController.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface AccountViewController : UIViewController<UIWebViewDelegate,MFMailComposeViewControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    IBOutlet UIWebView *webview;
    BOOL isFinish;
    BOOL viewDidLoad;
    UIActionSheet *actionsheet;
    UIPopoverController *popoverController;
    IBOutlet UILabel *usernameLB;
    IBOutlet UIButton *addBT;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;

- (IBAction)status_Click:(id)sender;

- (IBAction)sendMail_Click:(id)sender;

@end
