//
//  MercurySiteListViewController.m
//  Mercury
//
//  Created by Jeffrey on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#include <list>

#import "MercurySiteListViewController.h"
#import "SiteListInfoCell.h"
#import "SiteListPlotCell.h"



@implementation MercurySiteListViewController 
@synthesize plotHolders;
@synthesize paramaterScroll;

- (void)dealloc
{
    delete corePlotList;
    
    [paraIndicator release];
    [siteScroll release];
    [paramaterScroll release];
    [generalInfoTable release];
    [corePlotInfoTable release];
    [plotHolders release];
    [paraTitle release];
    [plotColor release];
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
/*
 * The total view size:
 * +-------------------------PARANUM * SCREEN_WIDTH----------------------------+
 * +-----------------------------paramaterScroll-------------------------------+
 * +---*--SCREEN_WIDTH--*--+---------------------------------------------------+
 * |   |                |  |                                                   |
 * |   |                |  |                                                   |
 * |   |                |  |                                                   |
 * |   |                |  |                                                   |
 * |   |                |  |                                                   |
 * | SCREEN_HEIGHT      |  |                                                   |
 * |   |                |  |                                                   |
 * |   |   mainScreen   |  |                                                   |
 * |   |                |  |                                                   |
 * |   |                |  |                                                   |
 * |   |                |  |  Scroll from right                                |
 * |   |                |  |                   <=== OR ===>                    |
 * |   |                |  |                               Scroll from Left    |
 * |   |                |  |                                                   |
 * |   |                |  |                                                   |
 * |   |                |  |                                                   |
 * +---*--SCREEN_WIDTH--|--+                                                   |
 * |                    |  |                                                   |
 * |                    |  |                                                   |
 * |        siteListScroll |                                                   |
 * |           NSITES * 85 |                                                   |
 * |                    |  |                                                   |
 * |                    |  |                                                   |
 * |                    |  |                                                   |
 * |                    |  |                                                   |
 * |                    |  |                                                   |
 * |                    |  |                                                   |
 * |                    |  |                                                   |
 * +----SCREEN_WIDTH----*--+---------------------------------------------------+
 */
- (void)loadView
{
    [super loadView];
    // TODO: Just for demo here, load the UI text from UI.plist.
    paraTitle = [[NSArray alloc] initWithObjects:@"Monitoring", @"Availability", @"Page View", 
                 @"Threat", @"Latency", @"Security", @"Alert", nil];
    plotColor = [[NSArray alloc] initWithObjects:[UIColor grayColor], 
                 [UIColor orangeColor], 
                 [UIColor redColor],
                 [UIColor purpleColor],
                 [UIColor magentaColor], 
                 [UIColor greenColor],
                 [UIColor blueColor], nil];

    
    // A NULL table list.
    corePlotList = new std::list<UITableView *>();
    self.view.backgroundColor = [UIColor brownColor];
    self.title = [paraTitle objectAtIndex:NEVEL_ENABLE_TABLE];
    
    // The page indicator
    paraIndicator = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 320, 15)];
    paraIndicator.numberOfPages = PARANUM;
    paraIndicator.currentPage = 0;
    [paraIndicator  addTarget:self 
                       action:@selector(tableTurn:) 
             forControlEvents:UIControlEventValueChanged];
    
    /*
     * The y axis scroll control (scroll websites).
     */
    CGRect displayRect;
    displayRect.origin.x = 0.0f;
    displayRect.origin.y = PAGEINDICATOR_HEIGHT;
    displayRect.size.width = SCREEN_WIDTH;
    displayRect.size.height = 
        SCREEN_HEIGHT - DEFAULT_TABBAR_HEIGHT - DEFAULT_NAVBAR_HEIGHT - PAGEINDICATOR_HEIGHT;
    
    siteScroll = [[[UIScrollView alloc] initWithFrame:displayRect] autorelease];
    siteScroll.contentSize = CGSizeMake(SCREEN_WIDTH, NSITES * 85);
    siteScroll.pagingEnabled = NO;
    siteScroll.delegate = self;
    siteScroll.backgroundColor = [UIColor clearColor];
    siteScroll.alwaysBounceVertical = FALSE;
	siteScroll.bounces = NO;
    
    /*
     * The x axis scroll control (scroll paramaters).
     */
    CGRect paraScrollRect;
    paraScrollRect.origin.x = 0.0f;
    paraScrollRect.origin.y = 0.0f;
    paraScrollRect.size.width = SCREEN_WIDTH;
    paraScrollRect.size.height = NSITES * 85;
    
    /* The frame and contentsize must be the same to limit the V-scroll of paramaterScroll.*/
    paramaterScroll = [[[UIScrollView alloc] initWithFrame:paraScrollRect] autorelease];
    paramaterScroll.contentSize = CGSizeMake(PARANUM * SCREEN_WIDTH, NSITES * 85);
    paramaterScroll.delegate = self;
   	paramaterScroll.alwaysBounceHorizontal = FALSE;
	paramaterScroll.bounces = NO;
    paramaterScroll.backgroundColor = [UIColor clearColor];
    paramaterScroll.pagingEnabled = YES;
    paramaterScroll.directionalLockEnabled = YES;
    
    // The site list bar table view.
    generalInfoTable = [[UITableView alloc] 
                        initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TABLEVIEW_CONTENT_HEIGHT)];
    generalInfoTable.delegate = self;
    generalInfoTable.dataSource = self;
    generalInfoTable.rowHeight = 85; // Calculated from SiteListInfoCell
    generalInfoTable.scrollEnabled = NO;
    generalInfoTable.backgroundColor = [UIColor clearColor];
    
    // Create the BIG PLOT VIEW.
    CGRect plotRect = CGRectMake(0, 0, (PARANUM) * SCREEN_WIDTH, NSITES * 85);
    UIView *plotHoldersTemp = [[UIView alloc] initWithFrame:plotRect];
    self.plotHolders = plotHoldersTemp;
    [plotHoldersTemp release];
    self.plotHolders.backgroundColor = [UIColor clearColor];
    
    // Generate all plot tables and add them into the BIG VIEW.
    for (int i = 0; i < PARANUM; i++) {
        corePlotInfoTable = [[UITableView alloc] 
                             initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, 
                                                      SCREEN_WIDTH * (i + 1), 
                                                      TABLEVIEW_CONTENT_HEIGHT)];
        corePlotInfoTable.delegate = self;
        corePlotInfoTable.dataSource = self;
        corePlotInfoTable.rowHeight = 85;
        corePlotInfoTable.scrollEnabled = NO;
        corePlotInfoTable.backgroundColor = [UIColor clearColor];
        corePlotInfoTable.tag = COREPLOT_TAG_BASE + i;
        corePlotList->push_back(corePlotInfoTable);
        [self.plotHolders addSubview:corePlotInfoTable];
    }
    currentTableIndex = 0;
    /*
     * The view hierarchy (from top to bottom):
     * 
     *     +--paraIndicator
     *     |                 +--- plotHolders
     *     |                 |
     *     |      +--- paramaterScroll
     *     |      |
     *     |      +--- generalInfoTable
     *     |      |
     *     +--siteScroll
     *     |
     +--view
     */
    
    [paramaterScroll addSubview:plotHolders];
    [siteScroll addSubview:generalInfoTable];
    [siteScroll addSubview:paramaterScroll];
    
    [self.view addSubview:siteScroll];
    [self.view addSubview:paraIndicator];
    
#ifdef DEBUG
    NSLog(@"[paraIndicator: ]%d", paraIndicator.currentPage);
    NSLog(@"[currentTableIndex: ]%d", currentTableIndex);
#endif
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView 
                  willDecelerate:(BOOL)decelerate {
    if (scrollView == paramaterScroll) {
        int offset1 = scrollView.contentOffset.x;
        int offset2 = originScrollOffset.x;
        int offset = offset1 - offset2;
        
        //        if (offset > SCREEN_WIDTH / 2) {
        if (offset > 0) {
            // Scroll left
            paraIndicator.currentPage++;
            currentTableIndex++;
            
            // TODO: we should catch the out of bound exception.
            if (currentTableIndex >= PARANUM) {
                currentTableIndex = PARANUM - 1;
            }
            self.title = [paraTitle objectAtIndex:currentTableIndex]; 
            
#ifdef DEBUG
            NSLog(@"[paraIndicator: ]%d", paraIndicator.currentPage);
            NSLog(@"[currentTableIndex: ]%d", currentTableIndex);
            NSLog(@"[offset1: ]%d", offset1);
#endif
            
        }
        else if (offset < 0) {
            //        else if (offset < (-SCREEN_WIDTH / 2)) {
            paraIndicator.currentPage--;
            currentTableIndex--;
            
            // TODO: we also need to catch the minus index exception.
            if (currentTableIndex < 0) {
                currentTableIndex = 0;
            }
            self.title = [paraTitle objectAtIndex:currentTableIndex];
            
#ifdef DEBUG
            NSLog(@"[paraIndicator: ]%d", paraIndicator.currentPage);
            NSLog(@"[currentTableIndex: ]%d", currentTableIndex);
#endif
        }
        else { 
            // May be never reach here.
            return;
        }
        originScrollOffset = scrollView.contentOffset;
    }
}


#pragma mark - UITableView Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return NSITES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"bigCell";
    UITableViewCellStyle style = UITableViewCellStyleDefault;
    
    // Draw the label part of the compound table.
    if (tableView == generalInfoTable) {
        SiteListInfoCell *cell = 
            (SiteListInfoCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
        
        if (cell == nil) {
            cell = [[[SiteListInfoCell alloc] initWithStyle:style 
                                            reuseIdentifier:cellIdentify] autorelease];   
        }
        return cell;
    }
    else { // corePlotInfoTable here.
        SiteListPlotCell *cell = 
        (SiteListPlotCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentify];
        
        if (cell == nil) {
            cell = [[[SiteListPlotCell alloc] initWithStyle:style 
                                            reuseIdentifier:cellIdentify] autorelease];  
            // Get the current table from the table list.
            std::list<UITableView *>::iterator tableIterator = corePlotList->begin();
            int i = 0;
            while (*tableIterator != tableView) {
                i++;
                tableIterator++;
            }
            cell.down.backgroundColor = [plotColor objectAtIndex:i];

            // TODO: we should catch it as an exception.
            if (i >= PARANUM) {
                // ???! There must be something wrong. :(
                NSLog(@"Doesn't match any table!!!");
            }
                        
        } // End of if (cell == nil)
        return cell;
    } // End of if (tableView == generalInfoTable)
}

#pragma mark - private members
- (void)tableTurn:(UIPageControl *)pageControl {
    int currentPage = pageControl.currentPage;
    
    [UIView animateWithDuration:0.3f 
                          delay:0.0f 
                        options:UIViewAnimationOptionCurveEaseInOut 
                     animations:^{
                         self.paramaterScroll.contentOffset = 
                            CGPointMake(SCREEN_WIDTH * currentPage, 0.0f); } 
                     completion:nil];
    
    originScrollOffset = self.paramaterScroll.contentOffset;
    currentTableIndex++;
}

@end