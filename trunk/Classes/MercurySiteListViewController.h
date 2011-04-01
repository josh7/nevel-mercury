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
#define NSITES 6
#define PARANUM 6

#define DEFAULT_TABBAR_HEIGHT 49
#define DEFAULT_NAVBAR_HEIGHT 44

#define SCREEN_WIDTH screenRect.size.width
#define SCREEN_HEIGHT screenRect.size.height
#define TABLEVIEW_CONTENT_HEIGHT NSITES * 85



@interface MercurySiteListViewController : 
UIViewController<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate> {
    // Parameter indicator
    UIPageControl *siteIndicator;
    // ParamaterScroll is a subview of siteScroll.
    UIScrollView *siteScroll;
    UIScrollView *paramaterScroll;
    // The table holds all site names.
    UITableView *generalInfoTable;
    // The table holds paramater plots.
    UITableView *corePlotInfoTable;
    // The big view hold all plot tables
    UIView *plotHolders;
}


@end
