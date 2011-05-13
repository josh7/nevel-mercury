//
//  MercurySiteViewController.h
//  Mercury
//
//  Created by Jeffrey on 12/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIContent.h"
#import "MercurySiteSettingsViewController.h"


@interface MercurySiteViewController : UIViewController {
    // The site settings navigation bar button item.
    UIBarButtonItem *settingsBarButton;
    
    MercurySiteSettingsViewController *siteSettingsViewController;
    
    // Object for UI text.
    NSArray *siteUIContent;
}

// The site settings button action.
- (void)siteSettingsButtonPressed:(id)sender;

@end
