//
//  SIteListInfoCell.m
//  Mercury
//
//  Created by puretears on 3/31/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import "SIteListInfoCell.h"


#define CELL_INIT(var, ControlType, frame) \
    ControlType *var##Temp = [[ControlType alloc] initWithFrame:frame]; \
    self.var = var##Temp; \
    [var##Temp release];


@implementation SiteListInfoCell
@synthesize info;
@synthesize plot;
@synthesize siteName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    	self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self) {
        // Initialization code
        CGRect rectView = CGRectMake(0, 0, 320, 25);
        UIView *upTemp = [[UIView alloc] initWithFrame:rectView];
        self.info = upTemp;
        [upTemp release];
        self.info.backgroundColor = [UIColor yellowColor];
                
        rectView = CGRectMake(0, 38, 320, 60);
        CELL_INIT(plot, UIView, rectView);
        self.plot.alpha = 0;
        
        rectView = CGRectMake(10, 3, 200, 20);
        CELL_INIT(siteName, UILabel, rectView);
        self.siteName.backgroundColor = [UIColor clearColor];
        
        [self.info addSubview:siteName];
        [self.contentView addSubview:info];
        [self.contentView addSubview:plot];
        
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
