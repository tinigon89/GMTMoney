//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "FeedDetailViewController.h"
#import "AppDelegate.h"

@interface FeedDetailViewController ()

@end

@implementation FeedDetailViewController
@synthesize url,titleString,description;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
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
    if (!description) {
        NSURL* nsUrl = [NSURL URLWithString:url];
        
        NSURLRequest* request = [NSURLRequest requestWithURL:nsUrl];
        webview.delegate = self;
        [webview loadRequest:request];
    }
    else
    {
        NSArray *array = [description componentsSeparatedByString:@"<img"];
        if ([array count] > 0) {
            description = [array objectAtIndex:0];
            description = [description stringByAppendingFormat:@"</br><a href=\"%@\">Click to read more....</>",url];
        }
        [webview loadHTMLString:description baseURL:nil];
    }
    
   
    titleLB.text = titleString;
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
