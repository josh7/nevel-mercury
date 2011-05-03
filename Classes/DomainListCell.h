//
//  DomainListCell.h
//  Mercury
//
//  Created by Jeffrey on 30/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DomainListCell : UITableViewCell {
    // The UI controllers.
    UIView *cellView;
    UIImageView *stateIconView;
    UIImageView *cellBackgroundView;
    UIImageView *blueAccessoryView;
    UILabel *domainNameLabel;
    UILabel *nevelPoweredLabel;
    UILabel *nevelPoweredValue;
    UILabel *securityLogsLabel;
    UILabel *securityLogsValue;
    UILabel *alertsLabel;
    UILabel *alertsValue;
}

@property (nonatomic, retain) UIImageView *stateIconView;
@property (nonatomic, retain) UILabel *domainNameLabel;
@property (nonatomic, retain) UILabel *nevelPoweredValue;
@property (nonatomic, retain) UILabel *securityLogsValue;
@property (nonatomic, retain) UILabel *alertsValue;

@end
