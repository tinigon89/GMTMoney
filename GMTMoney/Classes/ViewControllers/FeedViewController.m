//
//  ViewController.m
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "FeedViewController.h"
#import "AppDelegate.h"
#import "ServiceManager.h"
#import "define.h"
#import "FeedDetailViewController.h"
@interface FeedViewController ()

@end

@implementation FeedViewController
@synthesize index;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    titleArray = [[NSArray alloc] initWithObjects:@"Top News",@"Business",@"Science",@"World",@"Skynews", nil];
    feedURLArray = [[NSArray alloc] initWithObjects:@"http://in.mobile.reuters.com/reuters/rss/TOPIN.xml",@"http://in.mobile.reuters.com/reuters/rss/BUSIN.xml",@"http://in.mobile.reuters.com/reuters/rss/SCIIN.xml",@"http://in.mobile.reuters.com/reuters/rss/WORIN.xml",@"http://www.skynews.com.au/rss/feeds/skynews_business.xml", nil];
}




- (void)viewWillAppear:(BOOL)animated
{
    [self.taskbarView addSubview:[AppDelegate sharedInstance].taskbarView];
    topTitleLB.text = [titleArray objectAtIndex:index];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!isViewDidLoad) {
        [self performSelectorInBackground:@selector(showProcess) withObject:nil];
        [ServiceManager getFeedWithURL:[feedURLArray objectAtIndex:index]];
        feedDict = [[NSUserDefaults standardUserDefaults] objectForKey:[feedURLArray objectAtIndex:index]];
        if (feedDict) {
            itemList = [feedDict objectForKey:@"item"];
            [feedTableView reloadData];
        }
        [SVProgressHUD dismiss];
        isViewDidLoad = YES;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)home_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [itemList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    NSDictionary *dict = [itemList objectAtIndex:indexPath.row];
    UILabel *title = (UILabel*)[cell viewWithTag:1];
    UILabel *desciptiion = (UILabel*)[cell viewWithTag:2];
    title.text = [[dict objectForKey:@"title"] objectForKey:@"text"];
    desciptiion.text = [[dict objectForKey:@"description"] objectForKey:@"text"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedDetailViewController"];
    NSDictionary *dict = [itemList objectAtIndex:indexPath.row];
    controller.url = [[dict objectForKey:@"link"] objectForKey:@"text"];
    controller.titleString = [[dict objectForKey:@"title"] objectForKey:@"text"];
    if (index == 4) {
        controller.description = [[dict objectForKey:@"description"] objectForKey:@"text"];
    }
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)showProcess
{
    [SVProgressHUD showWithStatus:@"Loading"];
}

@end
