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
    // The root view controller of the mainboard.
    UITabBarController *mainboardTabBarController;
    
    // The tab view controllers of the mainboard.
    UINavigationController *domainListNavigationController;
    UINavigationController *accountNavigationController;
    UINavigationController *settingsNavigationController;
    UINavigationController *helpNavigationController;
    
    // Object for UI text.
    UIContent *mainboardUIContent;
}

@property (nonatomic, retain) UITabBarController *mainboardTabBarController;
@property (nonatomic, retain) UINavigationController *domainListNavigationController;
@property (nonatomic, retain) UINavigationController *accountNavigationController;
@property (nonatomic, retain) UINavigationController *settingsNavigationController;
@property (nonatomic, retain) UINavigationController *helpNavigationController;
@property (nonatomic, retain) UIContent *mainboardUIContent;

@end