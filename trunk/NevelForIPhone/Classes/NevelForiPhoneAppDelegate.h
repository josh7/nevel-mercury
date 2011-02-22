//
//  NevelForiPhoneAppDelegate.h
//  NevelForiPhone
//
//  Created by Jeffrey on 11-2-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SiteListNavViewController.h"
#import "AppSettingsNavViewController.h"

@interface NevelForiPhoneAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *appRootController;
	SiteListNavViewController *siteListNavViewController;
	AppSettingsNavViewController *appSettingsNavViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *appRootController;
@property (nonatomic, retain) SiteListNavViewController *siteListNavViewController;
@property (nonatomic, retain) AppSettingsNavViewController *appSettingsNavViewController;

@end