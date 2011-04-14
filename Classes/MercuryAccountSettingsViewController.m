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
#define fontSize 14.0f
#define cellContentWidth 300.0f
#define controllersInCell 196, 8, 94, 27
#define headerFontSize 12.0f
#define headerHeight 25.0f


@implementation MercuryAccountSettingsViewController
@synthesize currentAccountNameString;
@synthesize accountSettingsUIContent;
@synthesize accountSettingsConfig;
@synthesize footerView;
@synthesize sectionHeaderView;
@synthesize sectionHeader;
@synthesize MercuryLoginViewController;
@synthesize MercuryMainboardViewController;
@synthesize rememberAccountSwitch;
@synthesize autoLoginSwitch;

- (void)dealloc
{
    [currentAccountNameString release];
    [accountSettingsUIContent release];
    [accountSettingsConfig release];
    [footerView release];
    [sectionHeaderView release];
    [sectionHeader release];
    [MercuryLoginViewController release];
    [MercuryMainboardViewController release];
    [rememberAccountSwitch release];
    [autoLoginSwitch release];
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
    self.accountSettingsUIContent = appDelegate.uiContent.uiAccountSettingsKeys;
    
    // Set the app configuration object.
    AppConfig *appConfigTemp = [[AppConfig alloc] init];
    self.accountSettingsConfig = appConfigTemp;
    [appConfigTemp release];
    [self.accountSettingsConfig initWithAppConfig];
    
    // Initialize our table view.
    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.scrollEnabled = NO;
    
    // Add a footer to hold "Log Out" button.
    UIView *viewTemp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 68)];
    self.tableView.tableFooterView = viewTemp;
    self.footerView = viewTemp;
    [viewTemp release];
    UIButton *logOutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    logOutButton.frame = CGRectMake(10, 10, 300, 44);
    [logOutButton setTitle:[self.accountSettingsUIContent objectAtIndex:4] 
                  forState:UIControlStateNormal];
    [logOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [logOutButton addTarget:self 
                     action:@selector(logOutButtonPressed:) 
           forControlEvents:UIControlEventTouchUpInside];
    [self.footerView addSubview:logOutButton];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    NSArray *keyObject = [self.accountSettingsUIContent objectAtIndex:section];
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
        NSString *row = [[self.accountSettingsUIContent objectAtIndex:sectionIndex] 
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
        
        // The login type section.
        else if (sectionIndex == SECTION_LOGIN_TYPE && rowIndex == AS_EN_REMEMBER_NAME) {
            UISwitch *spTemp = [[UISwitch alloc] initWithFrame:CGRectMake(controllersInCell)];
            self.rememberAccountSwitch = spTemp;
            [spTemp release];
            // TODO: Config the switch from user's account configurations.
            self.rememberAccountSwitch.on = YES;
            [cell.contentView addSubview:self.rememberAccountSwitch];
            [self.rememberAccountSwitch addTarget:self 
                                        action:@selector(rememberAccountDidSwitch:) 
                              forControlEvents:UIControlEventValueChanged];
        }
        else if (sectionIndex == SECTION_LOGIN_TYPE && rowIndex == AS_EN_AUTO_LOGIN) {
            UISwitch *alTemp = [[UISwitch alloc] initWithFrame:CGRectMake(controllersInCell)];
            self.autoLoginSwitch = alTemp;
            [alTemp release];
            self.autoLoginSwitch.on = YES;
            [cell.contentView addSubview:self.autoLoginSwitch];
            [self.autoLoginSwitch addTarget:self 
                                        action:@selector(autoLoginDidSwitch:) 
                              forControlEvents:UIControlEventValueChanged];
        }
    }
    
    return cell;
}



- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == SECTION_ACCOUNT_TYPE) {
        return [self.accountSettingsUIContent objectAtIndex:AS_EN_FOOTER_ADVANCED];
    }
    else return nil;
}


#pragma mark - Table view delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *vTemp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    self.sectionHeaderView = vTemp;
    [vTemp release];
    
    // Add a header lable to the section header view.
    UILabel *lbTemp = [[UILabel alloc] initWithFrame:CGRectMake(22, 7, 300, 15)];
    lbTemp.backgroundColor = [UIColor clearColor];
    lbTemp.font = [UIFont fontWithName:@"Verdana" size:headerFontSize];
    lbTemp.text = [[self.accountSettingsUIContent objectAtIndex:SECTION_HEADE] 
                   objectAtIndex:section];
    lbTemp.textColor = [UIColor whiteColor];
    lbTemp.shadowColor = [UIColor grayColor];
    lbTemp.shadowOffset = CGSizeMake(0, 1);
    self.sectionHeader = lbTemp;
    [self.sectionHeaderView addSubview:self.sectionHeader];
    return self.sectionHeaderView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return headerHeight;
}


#pragma mark - Log Out button action
             
- (void)logOutButtonPressed:(id)sender {
    // Create a new Mercury login view and tell login view that user will relogin.
    MercuryLoginViewController *liTemp = [[MercuryLoginViewController alloc] init];
	self.MercuryLoginViewController = liTemp;
    self.MercuryLoginViewController.didRelogIn = YES;
	[liTemp release];
    
    // Get rid of mainboard view controller and add the login view.
    MercuryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.mercuryMainboardViewController.view removeFromSuperview];
    [appDelegate.window addSubview:self.MercuryLoginViewController.view];
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self.MercuryLoginViewController.view.layer addAnimation:animation forKey:@"animation"];
}
     

#pragma mark - Switch action

- (void)rememberAccountDidSwitch:(id)sender {
    // Clear: If autologin switch is ON, then save password switch should be ON.
    if (self.rememberAccountSwitch.on == NO) {
        if (self.autoLoginSwitch.on == YES) {
            [self.rememberAccountSwitch setOn:YES animated:YES];
        }
        else {
            [self.accountSettingsConfig setLoginType:JUST_LOGIN];
        }
    }
    else if (self.rememberAccountSwitch.on == YES && self.autoLoginSwitch == NO) {
        [self.accountSettingsConfig setLoginType:REMEMBER_ACCOUNT];
    }
}


- (void)autoLoginDidSwitch:(id)sender {
    // Clear: If autologin switch is ON, then save password switch should be ON.
    if (self.autoLoginSwitch.on == YES) {
        [self.rememberAccountSwitch setOn:YES animated:YES];
        [self.accountSettingsConfig setLoginType:AUTO];
    }
    else if (self.rememberAccountSwitch.on == YES && self.autoLoginSwitch == NO) {
        [self.accountSettingsConfig setLoginType:REMEMBER_ACCOUNT];
    }
}
             

@end
