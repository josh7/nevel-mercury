//
//  MercurySettingsViewController.m
//  Mercury
//
//  Created by puretears on 3/27/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import "MercurySettingsViewController.h"
#import "MercuryAppDelegate.h"
#import "UIContent.h"
#import "MercuryAccountTableViewController.h"

@implementation MercurySettingsViewController
@synthesize settingsTable;
@synthesize settingsUIContent;
@synthesize footerView;
@synthesize bgImageView;
@synthesize notificationSwitch;
@synthesize wifiOnlySwitch;
@synthesize soundAlertSwitch;
@synthesize vibtatorAlertSwitch;
@synthesize copyright;
@synthesize nevel;
@synthesize sendCrashReportSegmentedControl;
@synthesize settingsConfig;


- (void)dealloc {
    [settingsTable release];
    [settingsUIContent release];
    [footerView release];
    [notificationSwitch release];
    [wifiOnlySwitch release];
    [soundAlertSwitch release];
    [vibtatorAlertSwitch release];
    [copyright release];
    [nevel release];
    [sendCrashReportSegmentedControl release];
    [settingsConfig release];
    [super dealloc];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];
    sendCrashReportCellCanBeSelected = YES;
    themeCellCanBeSelected = YES;
    
    // Load the global UI helper object.
    MercuryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.settingsUIContent = appDelegate.uiContent;
    textOfCrashReportDetailTextLabel = [[self.settingsUIContent.uiSettingsKeys 
                                         objectAtIndex:SECTION_REPORT] objectAtIndex:ST_EN_ALWAYS];
    
    // Set the app configuration object.
    AppConfig *appConfigTemp = [[AppConfig alloc] init];
    self.settingsConfig = appConfigTemp;
    [appConfigTemp release];
    [self.settingsConfig initWithAppConfig];
    
    // Add the navigation title.
    self.title = [settingsUIContent.uiMainboardKeys objectAtIndex:MB_EN_SETTINGS];
    
    // Add background image.
    
    /* +--------------------------- Initialize table view ----------------------------+ */
    // Create settings table view.
    CGRect displayRect;
    displayRect.origin.x = 0.0f;
    displayRect.origin.y = 0.0f;
    displayRect.size.width = SCREEN_WIDTH;
    displayRect.size.height = SCREEN_HEIGHT - DEFAULT_TABBAR_HEIGHT - DEFAULT_NAVBAR_HEIGHT;
    UITableView *tvTemp = [[UITableView alloc] initWithFrame:displayRect 
                                                       style:UITableViewStyleGrouped];
    self.settingsTable = tvTemp;
    [tvTemp release];
    self.settingsTable.backgroundColor = [UIColor clearColor];
    self.settingsTable.delegate = self;
    self.settingsTable.dataSource = self;
    
    // Add a footer to the table view to display copyright.
    NSArray *footer = [self.settingsUIContent.uiSettingsKeys 
                      objectAtIndex:SECTION_COPYRIGHT];
    UIView *viewTemp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 68)];
    self.footerView = viewTemp;
    [viewTemp release];
    
    // The lable to disply a fun text in table footer. (Tempt)
    UILabel *nevelTemp = [[UILabel alloc] 
                          initWithFrame:CGRectMake(0, 10, 320, 24)];
    self.nevel = nevelTemp;
    [nevelTemp release];
    self.nevel.backgroundColor = [UIColor clearColor];
    self.nevel.textAlignment = UITextAlignmentCenter;
    // TODO: We can try more elegant text shadow here. 
    self.nevel.shadowColor = [UIColor lightGrayColor];
    self.nevel.shadowOffset = CGSizeMake(0, 1);
    self.nevel.font = [UIFont fontWithName:@"Verdana" size:14];
    self.nevel.textColor = [UIColor colorWithRed:0 green:0.5 blue:1 alpha:1];
    self.nevel.text = [footer objectAtIndex:ST_EN_FOR_FUN];
    [self.footerView addSubview:nevel];
    
    // The lable to display nevel copyright in table footer.
    UILabel *lbTemp = [[UILabel alloc] 
                       initWithFrame:CGRectMake(0, 44, 320, 24)];
    self.copyright = lbTemp;
    [lbTemp release];
    self.copyright.backgroundColor = [UIColor clearColor];
    self.copyright.textAlignment = UITextAlignmentCenter;
    self.copyright.font = [UIFont fontWithName:@"Verdana" size:12];
    self.copyright.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    self.copyright.text = [footer objectAtIndex:ST_EN_COPYRIGHT];
    [self.footerView addSubview:copyright];

    self.settingsTable.tableFooterView = self.footerView;
    [self.view addSubview:self.settingsTable];
    /* +------------------------ End of nitialize each cell --------------------------+ */
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


#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    NSArray *keyObject = [self.settingsUIContent.uiSettingsKeys objectAtIndex:section];
    return [keyObject count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // We do NOT use reuseIdentifier here in order to avoid disordering table.
    // May be we can find a way to use reuseIdentifier, so we keep this for a while.
//    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
//							 SectionsTableIdentifier];
    UITableViewCell *cell = nil;
    
    NSUInteger sectionIndex = indexPath.section;
    NSUInteger rowIndex = indexPath.row;
    
    // TODO: if we do not find a way to use reuseIdentifier, we should delete this "if".
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:nil] autorelease];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        /* +---------------------------- Initialize each cell ----------------------------+ */
        // The networks section.
        if (sectionIndex == SECTION_NETWORKS) {
            switch (rowIndex) {
                case ST_EN_NOTIFICATIONS: {
                    self.notificationSwitch = [self setSwitchStyleForCell:cell];
                    self.notificationSwitch.on = YES;
                    [cell.contentView addSubview:self.notificationSwitch];
                    [self.notificationSwitch addTarget:self
                                                action:@selector(notificationDidSwitch:) 
                                      forControlEvents:UIControlEventValueChanged];
                }
                    break;
                    
                case ST_EN_WIFI_ONLY: {
                    self.wifiOnlySwitch = [self setSwitchStyleForCell:cell];
                    self.wifiOnlySwitch.on = NO;
                    [cell.contentView addSubview:self.wifiOnlySwitch];
                    [self.wifiOnlySwitch addTarget:self
                                            action:@selector(wifiDidSwitch:) 
                                  forControlEvents:UIControlEventValueChanged];
                }
                    break;
                    
                case ST_EN_SEND_REPORT: {
                    cell = [self setAccessoryStyleForCell:cell 
                                      withDetailLableText:textOfCrashReportDetailTextLabel];
                }
                    break;
                
                case (ST_EN_SEND_REPORT+1): {
                    cell.backgroundColor = [UIColor lightGrayColor];
                    
                    // We add the segmented control to the new cell here.
                    // Initialize segmented control.
                    NSArray *segmentedControlArray =
                    [self.settingsUIContent.uiSettingsKeys objectAtIndex:SECTION_REPORT];
                    UISegmentedControl *scTemp = [[UISegmentedControl alloc] 
                                                  initWithItems:segmentedControlArray];
                    self.sendCrashReportSegmentedControl = scTemp;
                    [scTemp release];
                    self.sendCrashReportSegmentedControl.selectedSegmentIndex = 
                        [segmentedControlArray indexOfObject:textOfCrashReportDetailTextLabel];
                    self.sendCrashReportSegmentedControl.frame = CGRectMake(0, -10, 300, 54);
                    [self.sendCrashReportSegmentedControl 
                                                addTarget:self 
                                                   action:@selector(segmentedControlPressed:) 
                                         forControlEvents:UIControlEventValueChanged];
                    [cell.contentView addSubview:self.sendCrashReportSegmentedControl];
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        // The external section.
        else if (sectionIndex == SECTION_EXTERNAL) {
            switch (rowIndex) {
                case ST_EN_SOUND_ALERT: {
                    self.soundAlertSwitch = [self setSwitchStyleForCell:cell];
                    self.soundAlertSwitch.on = YES;
                    [cell.contentView addSubview:self.soundAlertSwitch];
                }
                    break;
                        
                case ST_EN_VIBRATOR_ALERT: {
                    self.vibtatorAlertSwitch = [self setSwitchStyleForCell:cell];
                    self.vibtatorAlertSwitch.on = NO;
                    [cell.contentView addSubview:self.vibtatorAlertSwitch];
                }
                    break;
                    
                case ST_EN_THEME: {
                    NSArray *theme = [self.settingsUIContent.uiSettingsKeys 
                                            objectAtIndex:SECTION_THEME];
                    cell = [self setAccessoryStyleForCell:cell 
                                      withDetailLableText:[theme 
                                                           objectAtIndex:ST_EN_NEVEL_CLASSIC]];
                }
                    break;
                    
                default:
                    break;
            }
        }
                
        // The about section.
        else if (sectionIndex == SECTION_ABOUT) {
            NSArray *about = [self.settingsUIContent.uiSettingsKeys 
                              objectAtIndex:SECTION_COPYRIGHT];
            cell = [self setAccessoryStyleForCell:cell 
                              withDetailLableText:[about objectAtIndex:ST_EN_VERSION_NO]];
            cell.accessoryView = nil;
            cell.selectionStyle = UITableViewCellEditingStyleNone;
        }
        /* +------------------------- End of initialize each cell ------------------------+ */
        
        // Display text and set colors in each cell.
        NSArray *section = [self.settingsUIContent.uiSettingsKeys objectAtIndex:sectionIndex];
        NSString *row = [section objectAtIndex:rowIndex];
        cell.textLabel.text = row;
        cell.textLabel.backgroundColor = [UIColor clearColor];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
        cell.textLabel.textColor = [UIColor colorWithRed:0 green:0.5 blue:1 alpha:1];
        if (sectionIndex == SECTION_EXTERNAL && rowIndex == (ST_EN_THEME+1)) {
            UIImage *imageTemp = [UIImage imageNamed:themeNevelClassic];
            UIImageView *ivTemp = [[UIImageView alloc] initWithImage:imageTemp];
            cell.backgroundView = ivTemp;
            [ivTemp release];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.textAlignment = UITextAlignmentRight;
        }
        else if (sectionIndex == SECTION_EXTERNAL && rowIndex == (ST_EN_THEME+2)) {
            cell.backgroundColor = [UIColor blackColor];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.textAlignment = UITextAlignmentRight;
        }
        else {
        cell.backgroundColor = 
        [UIColor colorWithRed:0 green:0.05 blue:0.15 alpha:1]; // The cell backgrond color.
        }
    }
    
    return cell;
}


// Set the style of switch cell uniformly.
- (id)setSwitchStyleForCell:(UITableViewCell *)switchCell {
    UISwitch *switchTemp = [[[UISwitch alloc] 
                            initWithFrame:CGRectMake(196, 8, 94, 27)] autorelease];
    return switchTemp;
}


// Set the style of accessory cell uniformly.
- (id)setAccessoryStyleForCell:(UITableViewCell *)accessoryCell 
       withDetailLableText:(NSString *)detailText {
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    accessoryCell = [[[UITableViewCell alloc]
             initWithStyle:UITableViewCellStyleValue1
             reuseIdentifier:SectionsTableIdentifier] autorelease];
    accessoryCell.detailTextLabel.text = detailText;
    accessoryCell.detailTextLabel.backgroundColor = [UIColor clearColor];
    accessoryCell.selectionStyle = UITableViewCellSelectionStyleBlue;
    UIImageView *blueDownAccessoryView = [[UIImageView alloc] 
                                      initWithImage:[UIImage imageNamed:arrowDown]];
    accessoryCell.accessoryView = blueDownAccessoryView;
    [blueDownAccessoryView release];
    return accessoryCell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger sectionIndex = indexPath.section;
    NSUInteger rowIndex = indexPath.row;
    
    /* +-------------------- Configure crash report sending type ---------------------+ */
    // We insert a cell to hold our crash report sending type when press the cell.
    if (sectionIndex == SECTION_NETWORKS && 
        rowIndex == ST_EN_SEND_REPORT) {
        NSIndexPath *ipSendCrashReport = [NSIndexPath indexPathForRow:(ST_EN_SEND_REPORT+1) 
                                                            inSection:SECTION_NETWORKS];
        if (sendCrashReportCellCanBeSelected ==YES) {
            // Prepare the a new array that are the data source of insert row.
            [[self.settingsUIContent.uiSettingsKeys objectAtIndex:SECTION_NETWORKS] 
             insertObject:@"" 
             atIndex:(ST_EN_SEND_REPORT+1)];
            NSArray *insertSendReportArray = [NSArray arrayWithObject:ipSendCrashReport];
            
            // Insert the theme row.
            [self.settingsTable beginUpdates];
            [self.settingsTable insertRowsAtIndexPaths:insertSendReportArray 
                                      withRowAnimation:UITableViewRowAnimationTop];
            sendCrashReportCellCanBeSelected = NO;
            [self.settingsTable endUpdates];
        }
        
        // We delete the cell holding segmented control when press the cell.
        else {
            [[self.settingsUIContent.uiSettingsKeys objectAtIndex:SECTION_NETWORKS]
             removeObjectAtIndex:(ST_EN_SEND_REPORT+1)];
            NSArray *deleteReportArray = [NSArray arrayWithObject:ipSendCrashReport];
            
            // Delete the theme rows.
            [self.settingsTable beginUpdates];
            [self.settingsTable deleteRowsAtIndexPaths:deleteReportArray 
                                      withRowAnimation:UITableViewRowAnimationTop];
            sendCrashReportCellCanBeSelected = YES;
            [self.settingsTable endUpdates];
        }        
    }
    
    /* +----------------- End of configure crash report sending type -----------------+ */

    /* +---------------------------- Configure theme type ----------------------------+ */
    else if (sectionIndex == SECTION_EXTERNAL) {
        NSArray *themeUIArray = [self.settingsUIContent.uiSettingsKeys 
                                 objectAtIndex:SECTION_THEME];
        
        // We insert a cell to hold our themes when press the themecell.
        if (rowIndex == ST_EN_THEME && themeCellCanBeSelected ==YES) {
            // Prepare the a new array that are the data source of insert row.
            [[self.settingsUIContent.uiSettingsKeys objectAtIndex:SECTION_EXTERNAL] 
                insertObject:[themeUIArray objectAtIndex:ST_EN_NEVEL_CLASSIC] 
                     atIndex:(ST_EN_THEME+1)];
            [[self.settingsUIContent.uiSettingsKeys objectAtIndex:SECTION_EXTERNAL] 
                insertObject:[themeUIArray objectAtIndex:ST_EN_BLACKHOLE]
                     atIndex:(ST_EN_THEME+2)];
            NSArray *insertThemeArray = [NSArray arrayWithObjects:
                [NSIndexPath indexPathForRow:(ST_EN_THEME+1) inSection:SECTION_EXTERNAL],
                [NSIndexPath indexPathForRow:(ST_EN_THEME+2) inSection:SECTION_EXTERNAL], nil];
            
            // Insert the theme row.
            [self.settingsTable beginUpdates];
            [self.settingsTable insertRowsAtIndexPaths:insertThemeArray 
                                      withRowAnimation:UITableViewRowAnimationTop];
            themeCellCanBeSelected = NO;
            [self.settingsTable endUpdates];
        }
        
        // We delete the cells holding our themes after chooseing a theme.
        // There are 3 situations: 1)press"Theme"; 2)press"Nevel classic"; 3)press"Blackhole".
        else if ((rowIndex == ST_EN_THEME && themeCellCanBeSelected == NO) ||
                  rowIndex == (ST_EN_THEME+1) ||
                  rowIndex == (ST_EN_THEME+2)) {
            [[self.settingsUIContent.uiSettingsKeys objectAtIndex:SECTION_EXTERNAL]
                removeObjectAtIndex:(ST_EN_THEME+1)];
            [[self.settingsUIContent.uiSettingsKeys objectAtIndex:SECTION_EXTERNAL] 
                removeObjectAtIndex:(ST_EN_THEME+1)];
            NSArray *deleteThemeArray = [NSArray arrayWithObjects:
                [NSIndexPath indexPathForRow:(ST_EN_THEME+1) inSection:SECTION_EXTERNAL],
                [NSIndexPath indexPathForRow:(ST_EN_THEME+2) inSection:SECTION_EXTERNAL], nil];
            
            // Delete the theme rows.
            [self.settingsTable beginUpdates];
            [self.settingsTable deleteRowsAtIndexPaths:deleteThemeArray 
                                      withRowAnimation:UITableViewRowAnimationTop];
            themeCellCanBeSelected = YES;
            [self.settingsTable endUpdates];
            
            // Update the text of detail text lable in real time.
            NSIndexPath *ipTheme = [NSIndexPath indexPathForRow:ST_EN_THEME 
                                                      inSection:SECTION_EXTERNAL];
            if (rowIndex == (ST_EN_THEME+1)) {
                [self.settingsTable cellForRowAtIndexPath:ipTheme].detailTextLabel.text = 
                    [themeUIArray objectAtIndex:ST_EN_NEVEL_CLASSIC];
                [self.settingsConfig setTheme:ST_EN_NEVEL_CLASSIC];
            }
            
            else if (rowIndex == (ST_EN_THEME+2)) {
                [self.settingsTable cellForRowAtIndexPath:ipTheme].detailTextLabel.text = 
                    [themeUIArray objectAtIndex:ST_EN_BLACKHOLE];
                [self.settingsConfig setTheme:ST_EN_BLACKHOLE];
            }
        }
    }
    /* +------------------------- End of onfigure theme type -------------------------+ */
}


#pragma mark - Segmented control action
- (void)segmentedControlPressed:(id)sender {
    // Pass the crash report sending type to app configuration detailed label of cell.
    NSUInteger selectSegmentIndex = self.sendCrashReportSegmentedControl.selectedSegmentIndex;
    [self.settingsConfig setCrashReportSendingType:selectSegmentIndex];
    textOfCrashReportDetailTextLabel = [self.sendCrashReportSegmentedControl 
                                        titleForSegmentAtIndex:selectSegmentIndex];
    NSIndexPath *ipSendCrashReport = [NSIndexPath indexPathForRow:ST_EN_SEND_REPORT 
                                                        inSection:SECTION_NETWORKS];
    UITableViewCell *selectCell = [self.settingsTable 
                                   cellForRowAtIndexPath:ipSendCrashReport];
    selectCell.detailTextLabel.text = textOfCrashReportDetailTextLabel;
    
    // Delete the theme rows.
    NSIndexPath *ipSendCrashReportSegment = [NSIndexPath indexPathForRow:(ST_EN_SEND_REPORT+1) 
                                                        inSection:SECTION_NETWORKS];
    [[self.settingsUIContent.uiSettingsKeys objectAtIndex:SECTION_NETWORKS]
     removeObjectAtIndex:(ST_EN_SEND_REPORT+1)];
    NSArray *deleteReportArrayByPressing = [NSArray arrayWithObject:ipSendCrashReportSegment];
    
    [self.settingsTable beginUpdates];
    [self.settingsTable deleteRowsAtIndexPaths:deleteReportArrayByPressing 
                              withRowAnimation:UITableViewRowAnimationTop];
    sendCrashReportCellCanBeSelected = YES;
    [self.settingsTable endUpdates];
}


#pragma mark - AppConfig methods
- (void)notificationDidSwitch:(id)sender {
    self.notificationSwitch.on == NO ? [self.settingsConfig setNotificationType:NO]:
                                       [self.settingsConfig setNotificationType:YES];
}


- (void)wifiDidSwitch:(id)sender {
    self.wifiOnlySwitch.on == YES ? [self.settingsConfig setWifiOnlyType:YES]:
                                    [self.settingsConfig setNotificationType:NO];
}


- (void)sountAlertDidSwitch:(id)sender {
    self.soundAlertSwitch.on == NO ? [self.settingsConfig setSoundAlertType:NO]:
                                     [self.settingsConfig setNotificationType:YES];
}


- (void)vibtatorAlertDidSwitch:(id)sender {
    self.vibtatorAlertSwitch.on == YES ? [self.settingsConfig setVibratorAlertType:YES]:
                                         [self.settingsConfig setNotificationType:NO];
}


@end
