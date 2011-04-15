//
//  SIteListInfoCell.h
//  Mercury
//
//  Created by puretears on 3/31/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SiteListInfoCell : UITableViewCell {
    UIView *info;
    UIView *plot;
    UILabel *siteName;
}

@property (nonatomic, retain) UIView *info;
@property (nonatomic, retain) UIView *plot;
@property (nonatomic, retain) UILabel *siteName;

@end
