//
//  MercuryAppDelegate.m
//  Mercury
//
//  Created by puretears on 3/6/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import "MercuryAppDelegate.h"


@implementation MercuryAppDelegate
@synthesize window;
@synthesize uiContent;
@synthesize appConfig;
@synthesize mercuryLoginViewController;
@synthesize mercuryMainboardViewController;

- (void)dealloc {
    [appConfig release];
    [uiContent release];
	[mercuryLoginViewController release];
    [mercuryMainboardViewController release];
    [window release];
    [super dealloc];
}


#pragma mark - Application lifecycle

- (BOOL)application:(UIApplication *)application 
	didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    UIContent *contentTemp = [[UIContent alloc] init];
    // Create the UI text object.
    self.uiContent = contentTemp;
    [contentTemp release];
    [self.uiContent initWithUIContent];
    
    // Create the configuration object.
    AppConfig *appConfigTemp = [AppConfig alloc];
    self.appConfig = appConfigTemp;
    [appConfigTemp release];
    [self.appConfig initWithAppConfig];
    
    // Override point for customization after application launch.
    
	// Create the window object.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Create the login view controller.
	MercuryLoginViewController *vcTemp = [[MercuryLoginViewController alloc] init];
	self.mercuryLoginViewController = vcTemp;
	[vcTemp release];
 
    // Preload the mainboard.
    MercuryMainboardViewController *boardTemp = 
    [[MercuryMainboardViewController alloc] init];
    self.mercuryMainboardViewController = boardTemp;
    [boardTemp release];
    
    // Add login view.
    [self.window addSubview:self.mercuryLoginViewController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     * Sent when the application is about to move from active to inactive 
	 * state. This can occur for certain types of temporary interruptions 
	 * (such as an incoming phone call or SMS message) or when the user 
	 * quits the application and it begins the transition to the background state.
     * Use this method to pause ongoing tasks, disable timers, and throttle 
	 * down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     * Use this method to release shared resources, save user data, invalidate 
	 * timers, and store enough application state information to restore your 
	 * application to its current state in case it is terminated later. 
     * If your application supports background execution, called instead of 
	 * applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     * Called as part of  transition from the background to the inactive state: 
	 * here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     * Restart any tasks that were paused (or not yet started) while the 
	 * application was inactive. If the application was previously in the 
	 * background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark - Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     * Free up as much memory as possible by purging cached data objects that c
	 * an be recreated (or reloaded from disk) later.
     */
}


@end
