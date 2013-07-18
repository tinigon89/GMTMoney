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
}

-
 (void)viewDidAppear:(BOOL)animated
{
    if (!viewDidLoad) {
        [self performSelectorInBackground:@selector(showProcess) withObject:nil];
        NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo];
        NSString *regid = [dict objectForKey:@"RegisterID"];
        [ServiceManager getSenderList:regid];
        [ServiceManager getBenList:regid];
        [SVProgressHUD dismiss];
        viewDidLoad = YES;
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

- (void)showProcess
{
    [SVProgressHUD showWithStatus:@"Loading"];
}
@end
