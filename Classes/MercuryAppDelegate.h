//
//  MercuryAppDelegate.h
//  Mercury
//
//  Created by puretears on 3/6/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MercuryLoginViewController.h"

@interface MercuryAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UIView *baseView;
    MercuryLoginViewController *mercuryLoginViewController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) MercuryLoginViewController *mercuryLoginViewController;
@property (nonatomic, retain) UIView *baseView;
@end

