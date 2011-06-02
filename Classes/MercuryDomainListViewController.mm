//
//  MercuryDomainListViewController.m
//  Mercury
//
//  Created by Jeffrey on 29/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MercuryDomainListViewController.h"
#import "DomainListCell.h"
#import "UIContent.h"

#define noticeValueOfPowered @"OFF"
#define noticeValueOfLogs @"0"
#define noticeValueOfAlerts @"0"

@implementation MercuryDomainListViewController
//@synthesize domainName;


- (void)dealloc {
//    [domainName release];
    [siteListViewController release];
    [super dealloc];
}


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization here.
        self.view.backgroundColor = [UIColor blackColor];
    }
    
    // TODO: load the xml data to these array.
    // We pretent to loading info from a xml, and we put them in arrays.
    
    return self;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // TODO: count the sections from xml, here is just for test.
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger sectionIndex = indexPath.section;
    
    // TODO: load the xml data to these array.
    // We pretent to loading info from a xml, and we put them in arrays.
    NSArray *domainName = [NSArray arrayWithObjects:
                           @"nevel.com", 
                           @"kerneldiy.com", 
                           @"btpao.com", 
                           nil];
    NSArray *nevelPowered = [NSArray arrayWithObjects:@"ON", @"OFF", @"ON", nil];
    NSArray *securityLogs = [NSArray arrayWithObjects:@"0", @"5", @"20", nil];
    NSArray *alerts = [NSArray arrayWithObjects:@"8", @"20", @"0", nil];
    
    static NSString *customerDomainCellIdentifier = @"CustomerDomainCellIdentifier";
    
    DomainListCell *cell = 
    (DomainListCell *)[tableView dequeueReusableCellWithIdentifier:customerDomainCellIdentifier];
    
    if (cell == nil) {
        cell = [[[DomainListCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                      reuseIdentifier:customerDomainCellIdentifier] autorelease];
        
        // Display each cell's contents
        NSString *stDomainName = [NSString stringWithString:
                                  [domainName objectAtIndex:sectionIndex]];
        NSString *stPoweredValue = [NSString stringWithString:
                                    [nevelPowered objectAtIndex:sectionIndex]];
        NSString *stSecurityLogs = [NSString stringWithString:
                                    [securityLogs objectAtIndex:sectionIndex]];
        NSString *stAlerts = [NSString stringWithString:
                                    [alerts objectAtIndex:sectionIndex]];
        if (stPoweredValue == noticeValueOfPowered) {
            cell.nevelPoweredValue.textColor = [UIColor orangeColor];
        }
        if (stSecurityLogs == noticeValueOfLogs) {
            cell.securityLogsValue.textColor = [UIColor lightGrayColor];
        }
        if (stAlerts == noticeValueOfAlerts) {
            cell.alertsValue.textColor = [UIColor greenColor];
            cell.alertsValue.font = [UIFont boldSystemFontOfSize:normalFontSize];
        }
        
        // The alert icon will show if nevel powered off or have alerts.
        if (stPoweredValue == noticeValueOfPowered || stAlerts != noticeValueOfAlerts) {
            cell.stateIconView.image = [UIImage imageNamed:iconAlert];
        }
        
        cell.domainNameLabel.text = stDomainName;
        cell.nevelPoweredValue.text = stPoweredValue;
        cell.securityLogsValue.text = stSecurityLogs;
        cell.alertsValue.text = stAlerts;
        }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Create and push site list view controller.
    siteListViewController = [[MercurySiteListViewController alloc] init];
    siteListViewController.hidesBottomBarWhenPushed = YES;
    [[self navigationController] pushViewController:siteListViewController animated:YES];
    
    // Manage the cell highlighting after selection.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return largeCellHeight;
}

@end
