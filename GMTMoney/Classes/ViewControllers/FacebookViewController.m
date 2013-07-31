//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "FacebookViewController.h"
#import "AppDelegate.h"

@interface FacebookViewController ()

@end

@implementation FacebookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    _facebook = [[Facebook alloc] initWithAppId:@"563452723716020" andDelegate:self];
    
}

#pragma mark FBSessionDelegate methods

- (void)fbDidLogin {
	likeView.alpha = 1;
    [likeView load];
}

- (void)fbDidLogout {
	likeView.alpha = 1;
    [likeView load];
}

#pragma mark FacebookLikeViewDelegate methods

- (void)facebookLikeViewRequiresLogin:(FacebookLikeView *)aFacebookLikeView {
    [_facebook authorize:[NSArray array]];
}

- (void)facebookLikeViewDidRender:(FacebookLikeView *)aFacebookLikeView {
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDelay:0.5];
    likeView.alpha = 1;
    [UIView commitAnimations];
}

- (void)facebookLikeViewDidLike:(FacebookLikeView *)aFacebookLikeView {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"FinishTransaction"] && ![[NSUserDefaults standardUserDefaults] boolForKey:@"10SMS"]) {
        [[NSUserDefaults standardUserDefaults] setInteger:10 forKey:@"SMS"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"10SMS"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FinishTransaction"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you for support us!"
                                                        message:@"You got 10 SMS"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

- (void)facebookLikeViewDidUnlike:(FacebookLikeView *)aFacebookLikeView {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unliked"
                                                     message:@""
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alert show];
}



- (void)viewWillAppear:(BOOL)animated
{
    [self.taskbarView addSubview:[AppDelegate sharedInstance].taskbarView];
    likeView.href = [NSURL URLWithString:@"https://www.facebook.com/pages/Gmtmoney-transfer-and-exchange/675222772495144"];
    likeView.layout = @"button_count";
    likeView.showFaces = NO;
    
    likeView.alpha = 0;
    [likeView load];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)home_click:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
