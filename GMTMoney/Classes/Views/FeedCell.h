//
//  FeedCell.h
//  GMTMoney
//
//  Created by Jacky on 8/1/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCell : UITableViewCell
@property (nonatomic) int rowIndex;
@property (strong, nonatomic) id delegate;
- (IBAction)select_Click:(id)sender;
@end
