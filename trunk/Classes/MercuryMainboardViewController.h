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
    NSArray *mainboardUIContent;
}

@end