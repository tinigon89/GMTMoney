//
//  taskbarView.h
//  GMTMoney
//
//  Created by Jacky on 7/10/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEPopoverController.h"
#import <MessageUI/MessageUI.h>
@interface TaskbarView : UIView<WEPopoverControllerDelegate,MFMailComposeViewControllerDelegate,UIPopoverControllerDelegate>
{
    WEPopoverController *popoverController;
    UIPopoverController *popoverController2;
}
- (IBAction)bankdetail_Click:(id)sender;
- (IBAction)contactus_Click:(id)sender;
- (IBAction)refer_Click:(id)sender;
- (IBAction)more_Click:(id)sender;

@end
