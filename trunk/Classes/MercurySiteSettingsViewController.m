//
//  MercurySiteSettingsViewController.m
//  Mercury
//
//  Created by Jeffrey on 12/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MercurySiteSettingsViewController.h"
#import "MercuryAppDelegate.h"
#define frameOfUISwitch         216,   8,  94, 27


@implementation MercurySiteSettingsViewController


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

- (void)loadView {
    [super loadView];
    
    // Load the global UI helper object.
    MercuryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    siteSettingsUIContent = appDelegate.uiContent.uiSiteSettingsKeys;
    
    // Initialize our table view.
    self.view.backgroundColor = [UIColor blackColor];
    
    // Add a footer to hold "Log Out" button.
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 68)];
    deleteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    deleteButton.frame = CGRectMake(10, 10, 300, 44);
    [deleteButton setTitle:[siteSettingsUIContent objectAtIndex:SS_EN_DELETE] 
                  forState:UIControlStateNormal];
    [deleteButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [deleteButton addTarget:self 
                     action:@selector(deleteButtonPressed:) 
           forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:deleteButton];
    self.tableView.tableFooterView = footerView;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[siteSettingsUIContent objectAtIndex:SECTION_ITEMS] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger rowIndex = indexPath.row;
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:CellIdentifier] autorelease];
        
        NSString *row = [[siteSettingsUIContent objectAtIndex:SECTION_ITEMS] 
                         objectAtIndex:rowIndex];
        cell.textLabel.text = row;
        cell.textLabel.textColor = [UIColor colorWithRed:0 green:0.5 blue:1 alpha:1];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:normalFontSize];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        
        // Add the UI switch to each row.
        switch (rowIndex) {
            case SS_EN_ENABLE_NEVEL: {
                enableNevelSwitch = [self setCellSwitchBy:enableNevelSwitch];
                [cell.contentView addSubview:enableNevelSwitch];
                [enableNevelSwitch addTarget:self 
                                      action:@selector(enableNevelDidSwitch:) 
                            forControlEvents:UIControlEventValueChanged];
            }
                break;
                
            case SS_EN_HIGH_SECURITY: {
                highSecurityLevelSwitch = [self setCellSwitchBy:highSecurityLevelSwitch];
                [cell.contentView addSubview:highSecurityLevelSwitch];
                [highSecurityLevelSwitch addTarget:self
                                            action:@selector(highSecurityLevelDidSwitch:) 
                                  forControlEvents:UIControlEventValueChanged];
            }
                break;
            
            case SS_EN_CACHE_DYNAMIC: {
                cacheDynamicContentSwitch = [self setCellSwitchBy:cacheDynamicContentSwitch];
                [cell.contentView addSubview:cacheDynamicContentSwitch];
                [cacheDynamicContentSwitch addTarget:self 
                                              action:@selector(cacheDynamicContentDidSwitch:)
                                    forControlEvents:UIControlEventValueChanged];
            }
                break;
                
            case SS_EN_WAF_SECURITY: {
                WAFSecuritySwitch = [self setCellSwitchBy:WAFSecuritySwitch];
                [cell.contentView addSubview:WAFSecuritySwitch];
                [WAFSecuritySwitch addTarget:self
                                      action:@selector(WAFSecurityDidSwitch:) 
                            forControlEvents:UIControlEventValueChanged];
            }
                break;
                
            case SS_EN_EMAIL_OBFUSCATION: {
                emailObfuscationSwitch = [self setCellSwitchBy:emailObfuscationSwitch];
                [cell.contentView addSubview:emailObfuscationSwitch];
                [emailObfuscationSwitch addTarget:self 
                                           action:@selector(emailObfuscationDidSwitch:) 
                                 forControlEvents:UIControlEventValueChanged];
            }
                break;
                
            case SS_EN_ALWAYS_ONLINE: {
                alwaysOnlineSwitch = [self setCellSwitchBy:alwaysOnlineSwitch];
                [cell.contentView addSubview:alwaysOnlineSwitch];
                [alwaysOnlineSwitch addTarget:self
                                       action:@selector(alwaysOnlineDidSwitch:) 
                             forControlEvents:UIControlEventValueChanged];
            }
                break;
                
            case SS_EN_HOTLINK: {
                HotlikPrevensionSwitch = [self setCellSwitchBy:HotlikPrevensionSwitch];
                [cell.contentView addSubview:HotlikPrevensionSwitch];
                [HotlikPrevensionSwitch addTarget:self
                                           action:@selector(HotlikPrevensionDidSwitch:)
                                 forControlEvents:UIControlEventValueChanged];
            }
                break;
                
            case SS_EN_PURGE_CACHE: {
                purgeChcheButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                purgeChcheButton.frame = CGRectMake(frameOfUISwitch);
                [purgeChcheButton setTitle:[[siteSettingsUIContent objectAtIndex:SECTION_ITEMS] 
                                                                   objectAtIndex:SS_EN_PURGE_CACHE]
                                                                   forState:UIControlStateNormal];
                [cell.contentView addSubview:purgeChcheButton];
                [purgeChcheButton addTarget:self 
                                     action:@selector(purgeChcheButtonPressed:) 
                           forControlEvents:UIControlEventTouchUpInside];
            }
                break;
                
            default:
                break;
        }
         
    }
    return cell;
}


- (id)setCellSwitchBy:(UISwitch *)cellSwitch {
    cellSwitch = [[[UISwitch alloc] initWithFrame:CGRectMake(frameOfUISwitch)] autorelease];
    cellSwitch.on = YES;
    return cellSwitch;
}


#pragma mark - UISwitch actions.

- (void)enableNevelDidSwitch:(id)sender {
    if (enableNevelSwitch.on == YES) {
        UIAlertView *disbleNevelAlert  = [[UIAlertView alloc] 
                    initWithTitle:[siteSettingsUIContent objectAtIndex:SS_EN_ALERT] 
                          message:[siteSettingsUIContent objectAtIndex:SS_EN_DISABLE_NEVEL_MSG] 
                         delegate:self 
                cancelButtonTitle:[siteSettingsUIContent objectAtIndex:SS_EN_NO] 
                otherButtonTitles:[siteSettingsUIContent objectAtIndex:SS_EN_YES], nil];
        [disbleNevelAlert show];
        [disbleNevelAlert release];
    }
}


- (void)highSecurityLevelDidSwitch:(id)sender {
    // Handle high securuty level changed here.
}


- (void)cacheDynamicContentDidSwitch:(id)sender {
    // Handle cache dynamic content changed here.
}


- (void)WAFSecurityDidSwitch:(id)sender {
    // Handle WAF security changed here.
}


- (void)emailObfuscationDidSwitch:(id)sender {
    // Handle email of obfuscation changed here.
}


- (void)alwaysOnlineDidSwitch:(id)sender {
    // Handle always on line changed here.
}


- (void)HotlikPrevensionDidSwitch:(id)sender{
    // Handle hot link prevension changed here.
}


#pragma mark - UIButton actions.

- (void)purgeChcheButtonPressed:(id)sender{
    UIAlertView *purgeChcheAlert  = [[UIAlertView alloc] 
                initWithTitle:[siteSettingsUIContent objectAtIndex:SS_EN_ALERT] 
                      message:[siteSettingsUIContent objectAtIndex:SS_EN_PURGE_CACHE_MSG] 
                     delegate:self 
            cancelButtonTitle:[siteSettingsUIContent objectAtIndex:SS_EN_NO] 
            otherButtonTitles:[siteSettingsUIContent objectAtIndex:SS_EN_YES], nil];
    [purgeChcheAlert show];
    [purgeChcheAlert release];
}


- (void)deleteButtonPressed:(id)sender{
    UIAlertView *deleteAlert  = [[UIAlertView alloc] 
                initWithTitle:[siteSettingsUIContent objectAtIndex:SS_EN_ALERT] 
                      message:[siteSettingsUIContent objectAtIndex:SS_EN_DELETE_MSG] 
                     delegate:self
            cancelButtonTitle:[siteSettingsUIContent objectAtIndex:SS_EN_NO] 
            otherButtonTitles:[siteSettingsUIContent objectAtIndex:SS_EN_YES], nil];
    [deleteAlert show];
    [deleteAlert release];
}


#pragma mark - UIAction sheet delegate.
- (void)deleteAlertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // Specify different choices of alert.
    // Handle enable nevel changed here.
    // Handle purge cache here.
    // Handle delete site here.
}
@end
