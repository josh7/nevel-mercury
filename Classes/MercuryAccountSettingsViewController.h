//
//  MercutyAccountSettingsViewController.h
//  Mercury
//
//  Created by Jeffrey on 11-4-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>   // For CATransition methods.
#import "UIContent.h"
#import "AppConfig.h"
#import "MercuryLoginViewController.h"
#import "MercuryMainboardViewController.h"


@interface MercuryAccountSettingsViewController : UITableViewController {
    // The UI contorllers.
    UIView *footerView;
    UIView *sectionHeaderView;
    UILabel *sectionHeader;
    
    // The UI controllers for log out.
    MercuryLoginViewController *MercuryReloginViewController;
    
    // Object for UI text.
    NSString *currentAccountNameString;
    NSArray *accountSettingsUIContent;
    
    // Objuct for user cnfigurations.
    AppConfig *accountSettingsConfig;
}

@property (nonatomic, retain) NSString *currentAccountNameString;

// Log out button action.
- (void)logOutButtonPressed:(id)sender;

@end
