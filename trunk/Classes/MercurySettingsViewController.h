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

#define DEFAULT_TABBAR_HEIGHT 49
#define DEFAULT_NAVBAR_HEIGHT 44

#define SCREEN_WIDTH screenRect.size.width
#define SCREEN_HEIGHT screenRect.size.height

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
    UIPickerView *crashReportPicker;
    UIActionSheet *crashReportActionSheet;
    UIPickerView *themePicker;
    
    // Object for UI text.
    UIContent *settingsUIContent;
    NSString *textOfCrashReportDetailTextLabel;
    NSString *textOfThemeDetailTextLabel;
    NSIndexPath *crashReportIndexPath;
    
    // Objuct for user cnfigurations.
    AppConfig *settingsConfig;
    
    // For fun ~
    UILabel *nevel;
}

@property (nonatomic, retain) UIImageView *bgImageView;
@property (nonatomic, retain) UITableView *settingsTable;
@property (nonatomic, retain) UIView *footerView;
@property (nonatomic, retain) UISwitch *notificationSwitch;
@property (nonatomic, retain) UISwitch *wifiOnlySwitch;
@property (nonatomic, retain) UISwitch *soundAlertSwitch;
@property (nonatomic, retain) UISwitch *vibtatorAlertSwitch;
@property (nonatomic, retain) UILabel *copyright;
@property (nonatomic, retain) UILabel *nevel;
@property (nonatomic, retain) UIPickerView *crashReportPicker;
@property (nonatomic, retain) UIActionSheet *crashReportActionSheet;
@property (nonatomic, retain) UIPickerView *themePicker;
@property (nonatomic, retain) UIContent *settingsUIContent;
@property (nonatomic, retain) AppConfig *settingsConfig;

- (id)setSwitchStyleForCell:(UITableViewCell *)switchCell;
- (id)setAccessoryStyleForCell:(UITableViewCell *)accessoryCell 
           withDetailLableText:(NSString *)detailText;

// App configuration methods.
- (void)notificationDidSwitch:(id)sender;
- (void)wifiDidSwitch:(id)sender;
- (void)sountAlertDidSwitch:(id)sender;
- (void)vibtatorAlertDidSwitch:(id)sender;

// Display detail text lable in real time methods.
//- (void)setCrashReportDetailTextLabel:(NSIndexPath *)indexPath inSection:(NSArray *)section;


@end
