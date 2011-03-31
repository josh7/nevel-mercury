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


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    	self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self) {
        // Initialization code
        CGRect rect = CGRectMake(0, 0, 320, 25);
        //CELL_INIT(up, UIView, rect);
        UILabel *upTemp = [[UILabel alloc] initWithFrame:rect];
        self.info = upTemp;
        [upTemp release];
        self.info.backgroundColor = [UIColor yellowColor];
                
        rect = CGRectMake(0, 38, 320, 60);
        CELL_INIT(plot, UILabel, rect);
        plot.alpha = 0;
        
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
