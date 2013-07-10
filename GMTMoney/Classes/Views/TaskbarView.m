//
//  taskbarView.m
//  GMTMoney
//
//  Created by Jacky on 7/10/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "TaskbarView.h"
#import "AppDelegate.h"
#import "Util.h"
@implementation TaskbarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)bankdetail_Click:(id)sender
{
    if (popoverController) {
        [popoverController dismissPopoverAnimated:NO];
    }
    UIButton *button = (UIButton*)sender;
    UIViewController *viewcontroller = [[AppDelegate sharedInstance].navController.topViewController.storyboard instantiateViewControllerWithIdentifier:@"BankDetail"];

    popoverController = [[WEPopoverController alloc] initWithContentViewController:viewcontroller] ;

    popoverController.popoverContentSize = CGSizeMake(320, 390);
    popoverController.delegate = self;

    
    //		[popoverController presentPopoverFromBarButtonItem:sender
    //                                  permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown)
    //                                                  animated:YES];
    [popoverController presentPopoverFromRect:button.bounds inView:self permittedArrowDirections:(UIPopoverArrowDirectionDown) animated:YES];
}

- (IBAction)contactus_Click:(id)sender {
    
    if (popoverController) {
        [popoverController dismissPopoverAnimated:NO];
    }
    UIButton *button = (UIButton*)sender;
    UIViewController *viewcontroller = [[AppDelegate sharedInstance].navController.topViewController.storyboard instantiateViewControllerWithIdentifier:@"ContactUsDetail"];
    
    popoverController = [[WEPopoverController alloc] initWithContentViewController:viewcontroller] ;
    
    popoverController.popoverContentSize = CGSizeMake(320, 390);
    popoverController.delegate = self;
    
    
    //		[popoverController presentPopoverFromBarButtonItem:sender
    //                                  permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown)
    //                                                  animated:YES];
    [popoverController presentPopoverFromRect:button.bounds inView:self permittedArrowDirections:(UIPopoverArrowDirectionDown) animated:YES];
}

- (IBAction)refer_Click:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        
        // Set Subject
        [mailer setSubject:@"GMT MONEY"];
        
        // Set Default To Receiptients
//        NSArray *toRecipients = [NSArray arrayWithObjects:@"innocrave@gmail.com", nil];
//        [mailer setToRecipients:toRecipients];
        [[AppDelegate sharedInstance].navController.topViewController presentViewController:mailer animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Email Account"
                                                        message:@"You must set up an email account for your device before you can send mail."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }

}

- (IBAction)more_Click:(id)sender {
    if (popoverController) {
        [popoverController dismissPopoverAnimated:NO];
    }
    UIButton *button = (UIButton*)sender;
    UIViewController *viewcontroller = [[AppDelegate sharedInstance].navController.topViewController.storyboard instantiateViewControllerWithIdentifier:@"MoreDetail"];
    
    popoverController = [[WEPopoverController alloc] initWithContentViewController:viewcontroller] ;
    
    popoverController.popoverContentSize = CGSizeMake(320, 200);
    popoverController.delegate = self;
    
    
    //		[popoverController presentPopoverFromBarButtonItem:sender
    //                                  permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown)
    //                                                  animated:YES];
    [popoverController presentPopoverFromRect:button.bounds inView:self permittedArrowDirections:(UIPopoverArrowDirectionDown) animated:YES];
}

- (void)popoverControllerDidDismissPopover:(WEPopoverController *)thePopoverController {
	//Safe to release the popover here
	popoverController = nil;
}

- (BOOL)popoverControllerShouldDismissPopover:(WEPopoverController *)thePopoverController {
	//The popover is automatically dismissed if you click outside it, unless you return NO here
	return YES;
}

#pragma mark -
#pragma mark - Mail Delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    [controller dismissViewControllerAnimated:YES completion:nil];
}
@end
