//
//  MercuryMainboardViewController.h
//  Mercury
//
//  Created by puretears on 3/13/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIContent.h"
#import "MercurySiteListNavigationController.h"

@interface MercuryMainboardViewController : UIViewController 
<UITabBarControllerDelegate>{
    UITabBarController *mainboardTabBarController;
    MercurySiteListNavigationController *stieListNavigationController;
    UINavigationController *nevelSettingsNavigationController;
    UIContent *mainboardUIContent;
}
@property (nonatomic, retain) UITabBarController *mainboardTabBarController;
@property (nonatomic, retain) MercurySiteListNavigationController *stieListNavigationController;
@property (nonatomic, retain) UINavigationController *nevelSettingsNavigationController;

@end