//
//  ContactUsViewController.m
//  GMTMoney
//
//  Created by Jacky on 8/6/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "ContactUsViewController.h"
#import "define.h"
#import "AppDelegate.h"
@interface ContactUsViewController ()

@end

@implementation ContactUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)emailButton_Click:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        
        // Set Subject
        [mailer setSubject:@""];
        
        // Set Default To Receiptients
        NSArray *toRecipients = [NSArray arrayWithObjects:@"Info@gmtmoney.com.au", nil];
        [mailer setToRecipients:toRecipients];
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

- (IBAction)hotline_Click:(id)sender {
    callNumber = @"1300783036";
    NSString *message = [NSString stringWithFormat:@"Do you want to call this number:%@?",callNumber];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
}

- (IBAction)tel1_click:(id)sender {
    callNumber = @"+61286773534";
    NSString *message = [NSString stringWithFormat:@"Do you want to call this number:%@?",callNumber];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
}

- (IBAction)tel2_click:(id)sender {
    callNumber = @"0466392621";
    NSString *message = [NSString stringWithFormat:@"Do you want to call this number:%@?",callNumber];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UIDevice *device = [UIDevice currentDevice];
        if ([[device model] isEqualToString:@"iPhone"] ) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",callNumber]]];
        } else {
            NSString *message = [NSString stringWithFormat:@"Your device doesn't support this feature. Call us: %@",callNumber];
            UIAlertView *notpermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [notpermitted show];
        }
    }
}


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
            [Util showAlertWithString:@"Your email has been sent"];
            break;
        case MFMailComposeResultFailed:
            [Util showAlertWithString:error.localizedDescription];
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    [controller dismissViewControllerAnimated:YES completion:nil];
}
@end
