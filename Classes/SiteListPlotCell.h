//
//  SiteListPlotCell.h
//  Mercury
//
//  Created by puretears on 3/31/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SiteListPlotCell : UITableViewCell {
    UILabel *up;
    UILabel *down;
}

@property (nonatomic, retain) UILabel *up;
@property (nonatomic, retain) UILabel *down;
@end
