//
//  MercutyAccountSettingsViewController.h
//  Mercury
//
//  Created by Jeffrey on 11-4-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIContent.h"
#import "AppConfig.h"


@interface MercuryAccountSettingsViewController : UIViewController {
    // The UI contorllers.
    UISegmentedControl *loginTypeSegmentedControl;
    NSString *currentAccountNameString;
    UIButton *logOutButton;
    
    // Object for UI text.
    UIContent *accountSettingsUIContent;
    
    // Objuct for user cnfigurations.
    AppConfig *accountSettingsConfig;

}

@property (nonatomic, retain) UISegmentedControl *loginTypeSegmentedControl;
@property (nonatomic, retain) NSString *currentAccountNameString;
@property (nonatomic, retain) UIContent *accountSettingsUIContent;
@property (nonatomic, retain) AppConfig *accountSettingsConfig;

// Segmented control action.
- (void)segmentedControlPressed:(id)sender;
- (void)buttonPressed:(id)sender;
@end
