//
//  MercutyAccountSettingsViewController.m
//  Mercury
//
//  Created by Jeffrey on 11-4-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MercuryAccountSettingsViewController.h"
#import "MercuryAppDelegate.h"
#import "UIContent.h"

@implementation MercuryAccountSettingsViewController
@synthesize currentAccountNameString;


- (void)dealloc
{
    [currentAccountNameString release];
    [accountSettingsUIContent release];
    [accountSettingsConfig release];
    [footerView release];
    [sectionHeaderView release];
    [sectionHeader release];
    [MercuryReloginViewController release];
    [super dealloc];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

- (void)loadView {
    [super loadView];
    
    // Load the global UI helper object.
    MercuryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    accountSettingsUIContent = appDelegate.uiContent.uiAccountSettingsKeys;
    
    // Set the app configuration object.
    accountSettingsConfig = [[AppConfig alloc] init];
    [accountSettingsConfig initWithAppConfig];
    
    // Initialize our table view.
    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.scrollEnabled = NO;
    
    // Add a footer to hold "Log Out" button.
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 68)];
    UIButton *logOutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    logOutButton.frame = CGRectMake(10, 10, 300, 44);
    [logOutButton setTitle:[accountSettingsUIContent objectAtIndex:AS_EN_LOG_OUT] 
                  forState:UIControlStateNormal];
    [logOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [logOutButton addTarget:self 
                     action:@selector(logOutButtonPressed:) 
           forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:logOutButton];
    self.tableView.tableFooterView = footerView;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    NSArray *keyObject = [accountSettingsUIContent objectAtIndex:section];
    return [keyObject count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SectionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSUInteger sectionIndex = indexPath.section;
    NSUInteger rowIndex = indexPath.row;
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:cellIdentifier] autorelease];
        // Configure the cell.
        NSString *row = [[accountSettingsUIContent objectAtIndex:sectionIndex] 
                         objectAtIndex:rowIndex];
        cell.textLabel.text = row;
        cell.textLabel.textColor = [UIColor colorWithRed:0 green:0.5 blue:1 alpha:1];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:0 green:0.05 blue:0.15 alpha:1];
        
        // The current account section.
        if (sectionIndex == SECTION_ACCOUNT_NAME && rowIndex == AS_EN_ACCOUNT_NAME) {
            cell.textLabel.text = self.currentAccountNameString;
            cell.textLabel.lineBreakMode = UILineBreakModeCharacterWrap;
            cell.textLabel.numberOfLines = 0;
            // TODO: Adjust the cell height according to text in the cells.
        }
        
        // The account type section.
        else if (sectionIndex == SECTION_ACCOUNT_TYPE && rowIndex == AS_EN_ACCOUNT_TYPE) {
            // TODO: Judge the account type, if advanced, do not show footer.
        }
    }
    return cell;
}



- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == SECTION_ACCOUNT_TYPE) {
        return [accountSettingsUIContent objectAtIndex:AS_EN_FOOTER_ADVANCED];
    }
    else return nil;
}


#pragma mark - Table view delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    
    // Add a header lable to the section header view.
    sectionHeader = [[UILabel alloc] initWithFrame:CGRectMake(22, 7, 300, 15)];
    sectionHeader.backgroundColor = [UIColor clearColor];
    sectionHeader.font = [UIFont fontWithName:@"Verdana" size:headerFontSize];
    sectionHeader.text = [[accountSettingsUIContent objectAtIndex:SECTION_HEADE] 
                   objectAtIndex:section];
    sectionHeader.textColor = [UIColor whiteColor];
    sectionHeader.shadowColor = [UIColor grayColor];
    sectionHeader.shadowOffset = CGSizeMake(0, 1);
    [sectionHeaderView addSubview:sectionHeader];
    return sectionHeaderView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == SECTION_ACCOUNT_NAME) {
        return 60;
    }
    else return 44;
}

#pragma mark - Log Out button action
             
- (void)logOutButtonPressed:(id)sender {
    // Get rid of mainboard view controller and add the login view.
	MercuryReloginViewController = [[MercuryLoginViewController alloc] init];
    
    // Remove current main board and add new login view.
    MercuryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    // We remove all the subview of window.
    for (UIView *view in [appDelegate.window subviews]) {
        [view removeFromSuperview];
    }
    [appDelegate.window addSubview:MercuryReloginViewController.view];
    // Tell the MercuryLoginViewController that this is not first login but relogin.
    MercuryReloginViewController.didRelogIn = YES;
    // Our new login view will show up from buttom.
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [MercuryReloginViewController.view.layer addAnimation:animation forKey:@"animation"];
}


@end
