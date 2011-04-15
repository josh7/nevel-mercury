//
//  MercurySiteListViewController.h
//  Mercury
//
//  Created by puretears on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#include <iostream>
#include <list>
#import <UIKit/UIKit.h>
#import "Common.h"
#import "MercuryLoginViewController.h"
#import "MercuryAppDelegate.h"
#import "MercuryPlotDraw.h"

/* 
 * Customize site list root view controller here.
 * Push new view by appDelegate.mercuryMainboardViewcontroller.sitesListNavigationController.view.
 */
#define NSITES [self.mercuryLoginViewController.xmlParser.siteNames count]

#define COREPLOT_TAG_BASE   0
#define NEVEL_ENABLE_TABLE  0
#define AVAIL_TABLE         1
#define PV_TABLE            2
#define THREAT_TABLE        3
#define LATENCY_TABLE       4
#define SECURITY_LOGS_TABLE 5
#define ALERT_LOGS_TABLE    6

#define PARANUM 7

#define PAGEINDICATOR_HEIGHT 15

#define DEFAULT_TABBAR_HEIGHT 49
#define DEFAULT_NAVBAR_HEIGHT 44


#define TABLEVIEW_CONTENT_HEIGHT NSITES * 85



@interface MercurySiteListViewController : 
UIViewController<UITableViewDelegate, 
                 UITableViewDataSource, 
                 UIScrollViewDelegate> {
                     
    // Parameter indicator
    UIPageControl *paraIndicator;
    // ParamaterScroll is a subview of siteScroll.
    UIScrollView *siteScroll;
    UIScrollView *paramaterScroll;
    // The table holds all site names.
    UITableView *generalInfoTable;
    // The table holds paramater plots.
    UITableView *corePlotInfoTable;
    // The big view hold all plot tables
    UIView *plotHolders;
    // The plot table list.
    std::list<UITableView *> *corePlotList;
    
    // Just for data comminication
    MercuryLoginViewController *mercuryLoginViewController;
    
@private
    /* 
     * Save this position to judge whether user scroll the 
     * paramater table from left or right.
     */
    CGPoint originScrollOffset;
    // Save this index to update the title on the navigation bar.
    int currentTableIndex;
    // When the user tab the paraIndicator, save the index
    // before tabbing.
    int pageBeforeTabbing;
    /* 
     * NOTE: we should load the UI from UI.plist.
     * DEMO only!
     */
    NSArray *paraTitle;
    NSArray *plotColor;
}

@property (nonatomic, retain) UIView *plotHolders;
@property (nonatomic, retain) UIScrollView *paramaterScroll;
@property (nonatomic, retain) MercuryLoginViewController *mercuryLoginViewController;

- (void)tableTurn:(UIPageControl *)pageControl;
@end
