//
//  MercuryMainboardViewController.m
//  Mercury
//
//  Created by puretears on 3/13/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import "MercuryAppDelegate.h"
#import "MercuryMainboardViewController.h"
#import "MercurySiteListViewController.h"
#import "MercurySettingsViewController.h"


@implementation MercuryMainboardViewController
@synthesize mainboardTabBarController;
@synthesize sitesListNavigationController;
@synthesize settingsNavigationController;
@synthesize mainboardUIContent;

- (void)dealloc {
    [mainboardTabBarController release];
    [sitesListNavigationController release];
    [settingsNavigationController release];
    [mainboardUIContent release];
    [super dealloc];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];
    
    // Load the global UI helper object.
    MercuryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.mainboardUIContent = appDelegate.uiContent;

    /* +----------------------------- The sites list subview -------------------------+ */
    UINavigationController *sitesListVCTemp = 
        [[UINavigationController alloc] 
            initWithRootViewController:[[MercurySiteListViewController alloc] init]]; 
    self.sitesListNavigationController = sitesListVCTemp;
    [sitesListVCTemp release];
       
    // TODO: Chage a new tab image here.
    // Set sites list tab bar item of sites list view controller.
    UIImage *sitesListTabBarItemImage = [UIImage imageNamed:@"nevel_icon.png"];
    NSString *sitesListTabBarItemTitle = 
    [self.mainboardUIContent.uiMainboardKeys objectAtIndex:MB_EN_SITESLIST];
    UITabBarItem *sitesListTabBar = [[UITabBarItem alloc] initWithTitle:sitesListTabBarItemTitle
                                                                  image:sitesListTabBarItemImage 
                                                                    tag:0];
    self.sitesListNavigationController.tabBarItem = sitesListTabBar;
    [sitesListTabBar release];
    /* +-------------------------- End of sites list subview -------------------------+ */

    /* +----------------------------- The settings subview ---------------------------+ */
    UINavigationController *settingsVCTemp = 
        [[UINavigationController alloc] 
            initWithRootViewController:[[MercurySettingsViewController alloc] init]]; 
    self.settingsNavigationController = settingsVCTemp;
    [settingsVCTemp release];
    
    // TODO: Chage a new tab image here.
    // Set settings tab bar item of settings view controller.
    UIImage *settingsTabBarItemImage = [UIImage imageNamed:@"nevel_icon.png"];
    NSString *settingsTabBarItemTitle = 
        [self.mainboardUIContent.uiMainboardKeys objectAtIndex:MB_EN_SETTING];
    UITabBarItem *settingsTabBar = [[UITabBarItem alloc] initWithTitle:settingsTabBarItemTitle
                                                                 image:settingsTabBarItemImage 
                                                                   tag:1];
    self.settingsNavigationController.tabBarItem = settingsTabBar;
    [settingsTabBar release];
    /* +-------------------------- End of settings subview ---------------------------+ */
    
    /* +----------------------------- The root tab bar view --------------------------+ */
    UITabBarController *tabBarTemp = [[UITabBarController alloc] init];
    self.mainboardTabBarController = tabBarTemp;
    [tabBarTemp release];
    
    self.mainboardTabBarController.delegate = self;
    
    // Add the Navigation Controllers to Tab Bar Controller
    NSArray *controllersArray = [[NSArray alloc] initWithObjects:
                                 self.sitesListNavigationController, 
                                 self.settingsNavigationController, 
                                 nil];
    self.mainboardTabBarController.viewControllers = controllersArray;
    [controllersArray release];

    [self.view addSubview:self.mainboardTabBarController.view];
    /* +------------------------ End of root tab bar view ---------------------------+ */
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController 
shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
