//
//  MercurySiteListViewController.h
//  Mercury
//
//  Created by Jeffrey on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MercurySiteListViewController.h"


@interface MercurySitesListNavigationController : UINavigationController {
    // Root view of navigation controller.
    //MercurySiteListViewController *siteListNavRootViewController;
    UIImageView *siteListBgImageView;
}
//@property (nonatomic, retain)MercurySiteListViewController *siteListNavRootViewController;
@property (nonatomic, retain)UIImageView *siteListBgImageView;

@end
