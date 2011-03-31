//
//  SIteListInfoCell.h
//  Mercury
//
//  Created by puretears on 3/31/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SiteListInfoCell : UITableViewCell {
    UILabel *info;
    UILabel *plot;
}

@property (nonatomic, retain) UILabel *info;
@property (nonatomic, retain) UILabel *plot;
@end
