//
//  FeedCell.m
//  GMTMoney
//
//  Created by Jacky on 8/1/13.
//  Copyright (c) 2013 Teamios. All rights reserved.
//

#import "FeedCell.h"

@implementation FeedCell
@synthesize rowIndex,delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)select_Click:(id)sender {
    if ([delegate respondsToSelector:@selector(selectRowAtCell:)]) {
        [delegate performSelector:@selector(selectRowAtCell:) withObject:self];
    }
}
@end
