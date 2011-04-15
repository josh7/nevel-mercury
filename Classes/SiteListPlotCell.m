//
//  SiteListPlotCell.m
//  Mercury
//
//  Created by Jeffrey on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SiteListPlotCell.h"

@implementation SiteListPlotCell
@synthesize up;
@synthesize down;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // Initialization code
        CGRect rect = CGRectMake(0, 0, 320, 25);
        UIView *upTemp = [[UIView alloc] initWithFrame:rect];
        self.up = upTemp;
        [upTemp release];
        up.alpha = 0;
        
        rect = CGRectMake(0, 25, 320, 60);
        UIView *downTemp = [[UIView alloc] initWithFrame:rect];
        self.down = downTemp;
        [downTemp release];
        
        [self.contentView addSubview:up];
        [self.contentView addSubview:down];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
}

@end
