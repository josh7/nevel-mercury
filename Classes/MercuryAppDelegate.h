//
//  MercuryAppDelegate.h
//  Mercury
//
//  Created by puretears on 3/6/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MercuryLoginViewController.h"
#import "MercuryMainboardViewController.h"
#import "UIContent.h"

@interface MercuryAppDelegate : NSObject <UIApplicationDelegate> {
    // The UI Controls.
    UIWindow *window;
    MercuryLoginViewController *mercuryLoginViewController;
    MercuryMainboardViewController *mercuryMainboardViewController;
    
    // Object for UI text.
    UIContent *uiContent;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UIContent *uiContent;
@property (nonatomic, retain) MercuryLoginViewController *mercuryLoginViewController;
@property (nonatomic, retain) MercuryMainboardViewController *mercuryMainboardViewController;

@end

