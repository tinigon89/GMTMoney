//
//  MoreViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/11/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

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

- (IBAction)help_Click:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.gmtmoney.com.au/faq.php"]];
}

- (IBAction)visit_Click:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.gmtmoney.com.au/"]];
}

- (IBAction)news_Click:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.gmtmoney.com.au/"]];
}
@end
