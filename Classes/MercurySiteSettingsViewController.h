//
//  MercurySiteSettingsViewController.h
//  Mercury
//
//  Created by Jeffrey on 12/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIContent.h"


@interface MercurySiteSettingsViewController : UITableViewController<UIAlertViewDelegate> {
    // Object for UI text.
    NSArray *siteSettingsUIContent;
    
    // The controllers.
    UIView *footerView;
    UIButton *deleteButton;
    UIButton *purgeChcheButton;
    UISwitch *enableNevelSwitch;
    UISwitch *highSecurityLevelSwitch;
    UISwitch *cacheDynamicContentSwitch;
    UISwitch *WAFSecuritySwitch;
    UISwitch *emailObfuscationSwitch;
    UISwitch *alwaysOnlineSwitch;
    UISwitch *HotlikPrevensionSwitch;
}

// Set switch controller to each cell.
- (id)setCellSwitchBy:(UISwitch *)cellSwitch;

// The switch actions.
- (void)enableNevelDidSwitch:(id)sender;
- (void)highSecurityLevelDidSwitch:(id)sender;
- (void)cacheDynamicContentDidSwitch:(id)sender;
- (void)WAFSecurityDidSwitch:(id)sender;
- (void)emailObfuscationDidSwitch:(id)sender;
- (void)alwaysOnlineDidSwitch:(id)sender;
- (void)HotlikPrevensionDidSwitch:(id)sender;

// The button actions.
- (void)deleteButtonPressed:(id)sender;
- (void)purgeChcheButtonPressed:(id)sender;

// UIAlertView delegate.
- (void)deleteAlertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
