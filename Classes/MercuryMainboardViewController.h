//
//  MercuryMainboardViewController.h
//  Mercury
//
//  Created by puretears on 3/13/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIContent.h"

@interface MercuryMainboardViewController : UIViewController <UITabBarControllerDelegate>{
    // The root view controller of the mainboard (two tabs: site list & settings).
    UITabBarController *mainboardTabBarController;
    
    // The sites list tab view controller of the mainboard.
    UINavigationController *sitesListNavigationController;
    
    // The settings tab view controller of the mainboard.
    UINavigationController *settingsNavigationController;
    
    // Object for UI text.
    UIContent *mainboardUIContent;
}
@property (nonatomic, retain) UITabBarController *mainboardTabBarController;
@property (nonatomic, retain) UINavigationController *sitesListNavigationController;
@property (nonatomic, retain) UINavigationController *settingsNavigationController;
@property (nonatomic, retain) UIContent *mainboardUIContent;


@end