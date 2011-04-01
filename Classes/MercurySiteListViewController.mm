//
//  MercurySiteListViewController.m
//  Mercury
//
//  Created by Jeffrey on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MercurySiteListViewController.h"
#import "SiteListInfoCell.h"
#import "SiteListPlotCell.h"



@implementation MercurySiteListViewController 

- (void)dealloc
{
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor brownColor];
    self.title = @"Site List";

    CGRect displayRect;
    displayRect.origin.x = 0.0f;
    displayRect.origin.y = 0.0f;
    displayRect.size.width = SCREEN_WIDTH;
    displayRect.size.height = SCREEN_HEIGHT - DEFAULT_TABBAR_HEIGHT - DEFAULT_NAVBAR_HEIGHT;
    
    siteScroll = [[[UIScrollView alloc] initWithFrame:displayRect] autorelease];
    siteScroll.contentSize = CGSizeMake(SCREEN_WIDTH, NSITES * 85);
    siteScroll.pagingEnabled = YES;
    siteScroll.delegate = self;
    
    paramaterScroll = [[[UIScrollView alloc] initWithFrame:displayRect] autorelease];
    paramaterScroll.contentSize = CGSizeMake(NSITES * SCREEN_WIDTH, displayRect.size.height);
//    paramaterScroll.contentSize = 
//        CGSizeMake(NSITES * SCREEN_WIDTH, 1700.0f);
    //paramaterScroll.bounces = NO;
    paramaterScroll.alwaysBounceVertical = NO;
    paramaterScroll.directionalLockEnabled = YES;
    
    // Create the BIG PLOT VIEW.
    CGRect plotRect = CGRectMake(0, 0, PARANUM * 320, NSITES * 85);
    UIView *plotHoldersTemp = [[UIView alloc] initWithFrame:plotRect];
    plotHolders = plotHoldersTemp;
    [plotHoldersTemp release];
    
    // Generate all plot tables and add them into the BIG VIEW.
    for (int i = 0; i < PARANUM; i++) {
        corePlotInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, 
                                                                          SCREEN_WIDTH * (i + 1), 
                                                                          NSITES * 85)];
    }
    
    
//    
//    CGRect tableViewRect = viewRect;
//    tableViewRect.size.height = 1700;
    generalInfoTable = [[UITableView alloc] initWithFrame:displayRect];
    generalInfoTable.delegate = self;
    generalInfoTable.dataSource = self;
    generalInfoTable.rowHeight = 85; // Calculated from SiteListInfoCell
    generalInfoTable.scrollEnabled = NO;
    generalInfoTable.backgroundColor = [UIColor clearColor];
    
    corePlotInfoTable = [[UITableView alloc] initWithFrame:displayRect];
    corePlotInfoTable.delegate = self;
    corePlotInfoTable.dataSource = self;
    corePlotInfoTable.rowHeight = 85;
    corePlotInfoTable.backgroundColor = [UIColor clearColor];
    corePlotInfoTable.scrollEnabled = NO;
    
    [paramaterScroll addSubview:corePlotInfoTable];
    [siteScroll addSubview:generalInfoTable];
    [siteScroll addSubview:paramaterScroll];
    
    //[siteScroll addSubview:generalInfoTable];
    //[siteScroll addSubview:corePlotInfoTable];
    
    [self.view addSubview:siteScroll];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableView Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"bigCell";
    UITableViewCellStyle style = UITableViewCellStyleDefault;
    
    if (tableView == generalInfoTable) {
        SiteListInfoCell *cell = 
            (SiteListInfoCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
        
        if (cell == nil) {
            cell = [[[SiteListInfoCell alloc] initWithStyle:style 
                                          reuseIdentifier:cellIdentify] autorelease];   
        }
        return cell;
    }
    else {
        SiteListPlotCell *cell = 
        (SiteListPlotCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
        
        if (cell == nil) {
            cell = [[[SiteListPlotCell alloc] initWithStyle:style 
                                            reuseIdentifier:cellIdentify] autorelease];   
        }
        return cell;
    }
}

@end
