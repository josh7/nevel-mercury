//
//  SiteListPlotCell.h
//  Mercury
//
//  Created by Jeffrey on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SiteListPlotCell : UITableViewCell {
    UILabel *up;
    UILabel *down;
}

@property (nonatomic, retain) UILabel *up;
@property (nonatomic, retain) UILabel *down;
@end
