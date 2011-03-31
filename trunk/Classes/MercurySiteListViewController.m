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
#define NSITES 6
#define DEFAULT_BAR_HEIGHT 49

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
    
    self.view.backgroundColor = [UIColor brownColor];
    self.title = @"Site List";
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect viewRect;
    viewRect.origin.x = 0.0f;
    viewRect.origin.y = 0.0f;
    viewRect.size.width = screenRect.size.width;
    viewRect.size.height = screenRect.size.height - DEFAULT_BAR_HEIGHT;
    
    siteScroll = [[[UIScrollView alloc] initWithFrame:viewRect] autorelease];
    siteScroll.contentSize = CGSizeMake(0, 1040.0f);
    siteScroll.pagingEnabled = YES;
    siteScroll.delegate = self;
    
    generalInfoTable = [[UITableView alloc] initWithFrame:viewRect];
    generalInfoTable.delegate = self;
    generalInfoTable.dataSource = self;
    generalInfoTable.rowHeight = 85; // Calculated from SiteListInfoCell
    generalInfoTable.scrollEnabled = NO;
    generalInfoTable.backgroundColor = [UIColor clearColor];
    
    corePlotInfoTable = [[UITableView alloc] initWithFrame:viewRect];
    corePlotInfoTable.delegate = self;
    corePlotInfoTable.dataSource = self;
    corePlotInfoTable.rowHeight = 85;
    corePlotInfoTable.backgroundColor = [UIColor clearColor];
    corePlotInfoTable.scrollEnabled = NO;
    
    [siteScroll addSubview:generalInfoTable];
    [siteScroll addSubview:corePlotInfoTable];
    
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
