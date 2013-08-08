//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "AccountViewController.h"
#import "AppDelegate.h"
#import "define.h"
#import "ServiceManager.h"
#import "TranStatusViewController.h"
@interface AccountViewController ()

@end

@implementation AccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString* url = @"https://instantcashworldwide.ae/InstantcashworldwideOffload/agentsearch_en.aspx";
    NSURL* nsUrl = [NSURL URLWithString:url];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl];
    webview.delegate = self;
    [webview loadRequest:request];
    
}



- (void)webViewDidFinishLoad:(UIWebView *)theWebView
{
    if (!isFinish) {
        CGSize contentSize = theWebView.scrollView.contentSize;
        CGSize viewSize = self.view.bounds.size;
        
        float rw = viewSize.width / contentSize.width;
        
        theWebView.scrollView.zoomScale = rw;
        isFinish = YES;
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.taskbarView addSubview:[AppDelegate sharedInstance].taskbarView];
    
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo];
    usernameLB.text =[NSString stringWithFormat:@"Hi,%@",[[dict objectForKey:@"UserName"] uppercaseString]];
}

-
 (void)viewDidAppear:(BOOL)animated
{
    if (!viewDidLoad) {
//        [self performSelectorInBackground:@selector(showProcess) withObject:nil];
//        NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo];
//        NSString *regid = [dict objectForKey:@"RegisterID"];
//        [ServiceManager getSenderList:regid];
//        [ServiceManager getBenList:regid];
//        [SVProgressHUD dismiss];
//        viewDidLoad = YES;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)home_click:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)status_Click:(id)sender {
    TranStatusViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TranStatusViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)sendMail_Click:(id)sender {
    actionsheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Photo Library" otherButtonTitles:@"Camera", nil];
    [actionsheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [Util showAlertWithString:@"No Camera Available"];
            return;
        }
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    switch(buttonIndex) {
        case 1:
            NSLog(@"user wants to take new picture");
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.allowsEditing= YES;
            break;
        case 0:
            NSLog(@"user wants to choose existing picture");
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        default:
            return;
    }
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

// Image Picker Delegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
	[picker dismissViewControllerAnimated:NO completion:nil];
	UIImage *image = [[UIImage alloc] init];
	image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self sendMail:image];
}

- (void)sendMail:(UIImage *)image
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        
        // Set Subject
        [mailer setSubject:@""];
        
        // Set Default To Receiptients
        NSArray *toRecipients = [NSArray arrayWithObjects:@"Admin@gmtmoney.com.au",@"Gmtmoneyt@gmail.com", nil];
        [mailer setToRecipients:toRecipients];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        [mailer addAttachmentData:imageData mimeType:@"image/jpeg" fileName:[NSString stringWithFormat:@"photo.jpg"]];
        [self presentViewController:mailer animated:YES completion:nil];
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showProcess
{
    [SVProgressHUD showWithStatus:@"Loading"];
}

@end
