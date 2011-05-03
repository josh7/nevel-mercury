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
    MercuryLoginViewController *MercuryLoginViewController;
    MercuryMainboardViewController *MercuryMainboardViewController;
    
    // Object for UI text.
    NSString *currentAccountNameString;
    NSArray *accountSettingsUIContent;
    
    // Objuct for user cnfigurations.
    AppConfig *accountSettingsConfig;
}

@property (nonatomic, retain) UIView *footerView;
@property (nonatomic, retain) UIView *sectionHeaderView;
@property (nonatomic, retain) UILabel *sectionHeader;
@property (nonatomic, retain) NSString *currentAccountNameString;
@property (nonatomic, retain) NSArray *accountSettingsUIContent;
@property (nonatomic, retain) AppConfig *accountSettingsConfig;
@property (nonatomic, retain) MercuryLoginViewController *MercuryLoginViewController;
@property (nonatomic, retain) MercuryMainboardViewController *MercuryMainboardViewController;

// Log out button action.
- (void)logOutButtonPressed:(id)sender;

@end
