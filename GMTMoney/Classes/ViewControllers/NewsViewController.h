//
//  ViewController.h
//  GMTMoney
//
//  Created by Jacky on 7/4/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController<UIWebViewDelegate>
{

    IBOutlet UIScrollView *scrollView;
}
@property (strong, nonatomic) IBOutlet UIView *taskbarView;
- (IBAction)home_click:(id)sender;

- (IBAction)topnews_click:(id)sender;
- (IBAction)business_click:(id)sender;
- (IBAction)science_Click:(id)sender;
- (IBAction)world_Click:(id)sender;
- (IBAction)skynews_Click:(id)sender;
- (IBAction)usnews_Click:(id)sender;
- (IBAction)ggNews_Click:(id)sender;
- (IBAction)bollywood_Click:(id)sender;
- (IBAction)underb_Click:(id)sender;

@end
