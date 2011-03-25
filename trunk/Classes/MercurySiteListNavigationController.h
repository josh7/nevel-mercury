//
//  MercurySiteListViewController.h
//  Mercury
//
//  Created by Jeffrey on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MercurySiteListViewController.h"


@interface MercurySiteListNavigationController : UINavigationController {
    MercurySiteListViewController *siteListViewController;
    UIImageView *siteListBgImageView;
    UITabBarItem *siteListTabBarItem;
    UIViewController *siteListNavRootViewController;
}
@property (nonatomic, retain)MercurySiteListViewController *siteListViewController;
@property (nonatomic, retain)UIImageView *siteListBgImageView;
@property (nonatomic, retain)UITabBarItem *siteListTabBarItem;
@property (nonatomic, retain)UIViewController *siteListNavRootViewController;

@end
