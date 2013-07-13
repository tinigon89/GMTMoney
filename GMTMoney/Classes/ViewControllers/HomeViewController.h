//
//  ViewController.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
{
    BOOL isViewDidLoad;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)facebook_click:(id)sender;

@end
