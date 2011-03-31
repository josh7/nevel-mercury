//
//  MercurySiteListViewController.h
//  Mercury
//
//  Created by Jeffrey on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/* 
 * Customize site list root view controller here.
 * Push new view by appDelegate.mercuryMainboardViewcontroller.sitesListNavigationController.view.
 */
@interface MercurySiteListViewController : 
UIViewController<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate> {
    UIPageControl *siteIndicator;
    UIScrollView *siteScroll;
    UITableView *generalInfoTable;
    UITableView *corePlotInfoTable;
}


@end
