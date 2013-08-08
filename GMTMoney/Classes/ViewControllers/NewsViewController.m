//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "NewsViewController.h"
#import "AppDelegate.h"
#import "FeedViewController.h"
@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    scrollView.contentSize = CGSizeMake(320, 460);
	// Do any additional setup after loading the view, typically from a nib.
    
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)topnews_click:(id)sender {
    FeedViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedViewController"];
    controller.index = 0;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)business_click:(id)sender {
    FeedViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedViewController"];
    controller.index = 1;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)science_Click:(id)sender {
    FeedViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedViewController"];
    controller.index = 2;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)world_Click:(id)sender {
    FeedViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedViewController"];
    controller.index = 3;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)skynews_Click:(id)sender {
    FeedViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedViewController"];
    controller.index = 4;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)usnews_Click:(id)sender {
    FeedViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedViewController"];
    controller.index = 5;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)ggNews_Click:(id)sender {
    FeedViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedViewController"];
    controller.index = 6;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)bollywood_Click:(id)sender {
    FeedViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedViewController"];
    controller.index = 7;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)underb_Click:(id)sender {
    FeedViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedViewController"];
    controller.index = 8;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
