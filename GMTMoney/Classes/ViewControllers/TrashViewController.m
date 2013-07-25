//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "TrashViewController.h"
#import "AppDelegate.h"

@interface TrashViewController ()

@end

@implementation TrashViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString* url = @"http://www.instantcashworldwide.com/include/transtatus.asp";
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)home_click:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
