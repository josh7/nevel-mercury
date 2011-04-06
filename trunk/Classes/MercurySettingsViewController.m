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
#define numberOfUnsectionItem 3

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
@synthesize crashReportPicker;
@synthesize crashReportActionSheet;
@synthesize themePicker;
@synthesize settingsConfig;


- (void)dealloc
{
    [settingsTable release];
    [settingsUIContent release];
    [footerView release];
    [notificationSwitch release];
    [wifiOnlySwitch release];
    [soundAlertSwitch release];
    [vibtatorAlertSwitch release];
    [copyright release];
    [nevel release];
    [crashReportPicker release];
    [crashReportActionSheet release];
    [themePicker release];
    [settingsConfig release];
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
    // PURETEARS: we used the MACRO in Common.h so screenRect can retire.
    //CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    // Load the global UI helper object.
    MercuryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.settingsUIContent = appDelegate.uiContent;
    
    // Set the app configuration object.
    AppConfig *appConfigTemp = [[AppConfig alloc] init];
    self.settingsConfig = appConfigTemp;
    [appConfigTemp release];
    [self.settingsConfig initWithAppConfig];
    
    // Add the navigation title.
    self.title = [settingsUIContent.uiMainboardKeys objectAtIndex:MB_EN_SETTING];
    
    // Add background image.
    
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
    self.settingsTable.backgroundColor = [UIColor blackColor];
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
    return ([self.settingsUIContent.uiSettingsKeys count]-numberOfUnsectionItem);
}


- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    NSArray *keyObject = [self.settingsUIContent.uiSettingsKeys objectAtIndex:section];
    return [keyObject count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
							 SectionsTableIdentifier];
    
    NSUInteger sectionIndex = indexPath.section;
    NSUInteger rowIndex = indexPath.row;
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:SectionsTableIdentifier] autorelease];
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
                }
                    break;
                    
                case ST_EN_SEND_REPORT: {
                    NSArray *crashReport = [self.settingsUIContent.uiSettingsKeys 
                                            objectAtIndex:SECTION_REPORT];
                    cell = [self setAccessoryStyleForCell:cell 
                                      withDetailLableText:[crashReport 
                                                           objectAtIndex:ST_EN_ALWAYS]];
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        // The external section.
        if (sectionIndex == SECTION_EXTERNAL) {
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
                    
                case 4:
                    NSLog(@"hshs");
                    break;
                        
                default:
                    break;
            }
        }
        
        // The account section.
        if (sectionIndex == SECTION_ACCOUNT) {
            cell = [self setAccessoryStyleForCell:cell 
                              withDetailLableText:@"admin"];
        }
        
        // The about section.
        if (sectionIndex == SECTION_ABOUT) {
            NSArray *about = [self.settingsUIContent.uiSettingsKeys 
                              objectAtIndex:SECTION_COPYRIGHT];
            cell = [self setAccessoryStyleForCell:cell 
                              withDetailLableText:[about objectAtIndex:ST_EN_VERSION_NO]];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellEditingStyleNone;
        }
        /* +------------------------- End of initialize each cell ------------------------+ */
    }

    
    // Display the text in each cell.
    NSArray *section = [self.settingsUIContent.uiSettingsKeys objectAtIndex:sectionIndex];
    NSString *row = [section objectAtIndex:rowIndex];
    cell.textLabel.text = row;
    cell.textLabel.backgroundColor = [UIColor clearColor];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
    cell.textLabel.textColor = [UIColor colorWithRed:0 green:0.5 blue:1 alpha:1];
    cell.backgroundColor = 
        [UIColor colorWithRed:0 green:0.05 blue:0.15 alpha:1]; // The cell backgrond color.
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
    accessoryCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    accessoryCell.selectionStyle = UITableViewCellSelectionStyleBlue;
    return accessoryCell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger sectionIndex = indexPath.section;
    NSUInteger rowIndex = indexPath.row;
    
    // Manage the configuration of sending crash report.
    if (sectionIndex == SECTION_NETWORKS && rowIndex == ST_EN_SEND_REPORT) {
        // TODO: Use inserting cell instead of action sheet here.
        // Add an action sheet to display crash report options.
        NSArray *crashReport = [self.settingsUIContent.uiSettingsKeys 
                                objectAtIndex:SECTION_REPORT];

        UIActionSheet *asTemp = [[UIActionSheet alloc] 
                                 initWithTitle:nil 
                                      delegate:self
                             cancelButtonTitle:@"Cancel" 
                        destructiveButtonTitle:nil 
                             otherButtonTitles:[crashReport objectAtIndex:ST_EN_ALWAYS], 
                                               [crashReport objectAtIndex:ST_EN_ASK],
                                               [crashReport objectAtIndex:ST_EN_NEVER], nil];
        self.crashReportActionSheet = asTemp;
        [asTemp release];
        self.crashReportActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        
        // Update the text of detail text lable in real time.
        crashReportIndexPath = indexPath;
        textOfCrashReportDetailTextLabel = [crashReport objectAtIndex:ST_EN_ALWAYS];
        
        // Display action sheet.
        [self.crashReportActionSheet showFromTabBar:[self tabBarController].tabBar];
        
        
        // useless
//        // Add picker to action sheet.
//        UIPickerView *pvTemp = [[UIPickerView alloc] init];
//        self.crashReportPicker = pvTemp;
//        [pvTemp release];
//        self.crashReportPicker.backgroundColor = [UIColor blueColor];
//        self.crashReportPicker.delegate = self;
//        self.crashReportPicker.dataSource = self;
//        self.crashReportPicker.frame = CGRectMake(0, 0, 160, 110);
//        [self.crashReportActionSheet addSubview:self.crashReportPicker];
//        
//        // Add the buttons on action sheet.
//        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        doneButton.frame = CGRectMake(170, 10, 140, 40);
//        doneButton.showsTouchWhenHighlighted = YES;
//        doneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//        doneButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//        [doneButton setTitle:@"Done" forState:UIControlStateNormal];
//        [doneButton setTitleColor:[UIColor colorWithRed:0 green:0.5 blue:1 alpha:1] 
//                           forState:UIControlStateSelected];
//        [doneButton addTarget:self 
//                    action:@selector(sendCrashReportDonePressed:) 
//          forControlEvents:UIControlEventTouchUpInside];
//        [self.crashReportActionSheet addSubview:doneButton];
//        
//        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        cancelButton.frame = CGRectMake(170, 60, 140, 40);
//        cancelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//        cancelButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//        [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
//        [cancelButton setTitleColor:[UIColor colorWithRed:0 green:0.5 blue:1 alpha:1] 
//                           forState:UIControlStateSelected];
//        [cancelButton addTarget:self 
//                         action:@selector(cancelPressed:) 
//               forControlEvents:UIControlEventTouchUpInside];
//        [self.crashReportActionSheet addSubview:cancelButton];
    }
    
    // We insert a cell hold our themes when press the themecell.
    if (sectionIndex == SECTION_EXTERNAL && rowIndex == ST_EN_THEME) {
        // Prepare the a new array that are the data source of insert row.
        [[self.settingsUIContent.uiSettingsKeys objectAtIndex:SECTION_EXTERNAL] 
                                                 insertObject:@"Nevel classic" 
                                                      atIndex:(ST_EN_THEME+1)];
        NSArray *insertThemeArray = [NSArray arrayWithObject:
                              [NSIndexPath indexPathForRow:(ST_EN_THEME+1) 
                                                 inSection:SECTION_EXTERNAL]];
        // Insert the theme row.
        [self.settingsTable beginUpdates];
        [self.settingsTable insertRowsAtIndexPaths:insertThemeArray 
                         withRowAnimation:UITableViewRowAnimationTop];
        [self.settingsTable endUpdates];
    }
    
    // We delete a cell hold our themes when press the themecell.
    if (sectionIndex == SECTION_EXTERNAL && rowIndex == (ST_EN_THEME+1)) {
        [[self.settingsUIContent.uiSettingsKeys objectAtIndex:SECTION_EXTERNAL]
                                          removeObjectAtIndex:(ST_EN_THEME+1)];
        NSArray *deleteThemeArray = [NSArray arrayWithObject:
                                     [NSIndexPath indexPathForRow:(ST_EN_THEME+1) 
                                                        inSection:SECTION_EXTERNAL]];
        // Delete the theme row.
        [self.settingsTable beginUpdates];
        [self.settingsTable deleteRowsAtIndexPaths:deleteThemeArray 
                                  withRowAnimation:UITableViewRowAnimationTop];
        [self.settingsTable endUpdates];

    }
}


#pragma mark - UIActionSheet delegate and methods.
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        [self.settingsConfig setCrashReportSendingType:buttonIndex];
        textOfCrashReportDetailTextLabel = [self.crashReportActionSheet 
                                            buttonTitleAtIndex:buttonIndex];
        UITableViewCell *selectCell = [self.settingsTable 
                                       cellForRowAtIndexPath:crashReportIndexPath];
        selectCell.detailTextLabel.text = textOfCrashReportDetailTextLabel;
    }
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


- (void)sountAlertDidSwitch:(id)sender{
    self.soundAlertSwitch.on == NO ? [self.settingsConfig setSoundAlertType:NO]:
                                     [self.settingsConfig setNotificationType:YES];
}


- (void)vibtatorAlertDidSwitch:(id)sender {
    self.vibtatorAlertSwitch.on == YES ? [self.settingsConfig setVibratorAlertType:YES]:
                                         [self.settingsConfig setNotificationType:NO];
}


//#pragma mark -UIPickerView datasource
//- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
//    return 1;
//}
//
//
//- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
//    return [[self.settingsUIContent.uiSettingsKeys objectAtIndex:SECTION_REPORT] count];
//    NSLog(@"%@", [[self.settingsUIContent.uiSettingsKeys objectAtIndex:SECTION_REPORT] count]);
//}
//
//
//#pragma mark - UIPickerView delegate
//- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row 
//             forComponent:(NSInteger)component {
//    NSArray *crashReport = [self.settingsUIContent.uiSettingsKeys objectAtIndex:SECTION_REPORT];
//    return [crashReport objectAtIndex:row];
//}


@end
