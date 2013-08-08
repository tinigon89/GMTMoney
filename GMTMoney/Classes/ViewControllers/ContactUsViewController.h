//
//  ContactUsViewController.h
//  GMTMoney
//
//  Created by Jacky on 8/6/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface ContactUsViewController : UIViewController<MFMailComposeViewControllerDelegate,UIAlertViewDelegate>
{
    NSString *callNumber;
}
- (IBAction)emailButton_Click:(id)sender;
- (IBAction)hotline_Click:(id)sender;
- (IBAction)tel1_click:(id)sender;
- (IBAction)tel2_click:(id)sender;

@end
