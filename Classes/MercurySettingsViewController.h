//
//  MercurySettingsViewController.h
//  Mercury
//
//  Created by puretears on 3/27/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIContent.h"
#import "AppConfig.h"
#import "Common.h"


/* 
 * Customize settings root view controller here.
 * Push new view by appDelegate.mercuryMainboardViewcontroller.settingsNavigationController.view.
 */
@interface MercurySettingsViewController : UIViewController <
UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>{
    // The UI controls.
    UIImageView *bgImageView;
    UITableView *settingsTable;
    UIView *footerView;
    UISwitch *notificationSwitch;
    UISwitch *wifiOnlySwitch;
    UISwitch *soundAlertSwitch;
    UISwitch *vibtatorAlertSwitch;
    UILabel *copyright;
    UISegmentedControl *sendCrashReportSegmentedControl;
    
    // Object for UI text.
    UIContent *settingsUIContent;
    NSString *textOfCrashReportDetailTextLabel;
    
    // Objuct for user cnfigurations.
    AppConfig *settingsConfig;
    
    // For fun ~
    UILabel *nevel;
    
    // Flag to mark whether the cell should be selectable.
    BOOL themeCellCanBeSelected;
    BOOL sendCrashReportCellCanBeSelected;
}

// TODO: Clean thses propertise.
@property (nonatomic, retain) UIImageView *bgImageView;
@property (nonatomic, retain) UITableView *settingsTable;
@property (nonatomic, retain) UIView *footerView;
@property (nonatomic, retain) UISwitch *notificationSwitch;
@property (nonatomic, retain) UISwitch *wifiOnlySwitch;
@property (nonatomic, retain) UISwitch *soundAlertSwitch;
@property (nonatomic, retain) UISwitch *vibtatorAlertSwitch;
@property (nonatomic, retain) UILabel *copyright;
@property (nonatomic, retain) UILabel *nevel;
@property (nonatomic, retain) UISegmentedControl *sendCrashReportSegmentedControl;
@property (nonatomic, retain) UIContent *settingsUIContent;
@property (nonatomic, retain) AppConfig *settingsConfig;

// Set two kinds cell uniformly.
- (id)setSwitchStyleForCell:(UITableViewCell *)switchCell;
- (id)setAccessoryStyleForCell:(UITableViewCell *)accessoryCell 
           withDetailLableText:(NSString *)detailText;

// App configuration action.
- (void)notificationDidSwitch:(id)sender;
- (void)wifiDidSwitch:(id)sender;
- (void)sountAlertDidSwitch:(id)sender;
- (void)vibtatorAlertDidSwitch:(id)sender;

// Segmented control action.
- (void)segmentedControlPressed:(id)sender;


@end
