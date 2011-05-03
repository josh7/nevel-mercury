//
//  MercuryMainboardViewController.m
//  Mercury
//
//  Created by puretears on 3/13/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import "MercuryAppDelegate.h"
#import "MercuryMainboardViewController.h"
#import "MercuryDomainListViewController.h"
#import "MercuryAccountTableViewController.h"
#import "MercurySettingsViewController.h"
#import "MercuryHelpViewController.h"


@implementation MercuryMainboardViewController
@synthesize mainboardTabBarController;
@synthesize domainListNavigationController;
@synthesize accountNavigationController;
@synthesize settingsNavigationController;
@synthesize helpNavigationController;
@synthesize mainboardUIContent;

- (void)dealloc {
    [mainboardTabBarController release];
    [domainListNavigationController release];
    [accountNavigationController release];
    [settingsNavigationController release];
    [helpNavigationController release];
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

    /* +----------------------------- The domain list subview ------------------------+ */
    MercuryDomainListViewController *dlTemp = [[MercuryDomainListViewController alloc] init];
    dlTemp.title = [self.mainboardUIContent.uiMainboardKeys objectAtIndex:MB_EN_DOMAIN_LIST];
    UINavigationController *domainListVCTemp = [[UINavigationController alloc] 
                                                initWithRootViewController:dlTemp];
    [dlTemp release];
    domainListVCTemp.navigationBar.barStyle = UIBarStyleBlack;
    // TODO: use a translucent bar here, and fix the site list view.
//    domainListVCTemp.navigationBar.translucent = YES;
    self.domainListNavigationController = domainListVCTemp;
    [domainListVCTemp release];
    
    // TODO: Chage a new tab image here.
    // Set sites list tab bar item of sites list view controller.
    UIImage *domainListTabBarItemImage = [UIImage imageNamed:MainboardTabbarView];
    NSString *domainListTabBarItemTitle = 
    [self.mainboardUIContent.uiMainboardKeys objectAtIndex:MB_EN_DOMAIN_LIST];
    UITabBarItem *domainListTabBar = [[UITabBarItem alloc] initWithTitle:domainListTabBarItemTitle
                                                                  image:domainListTabBarItemImage 
                                                                    tag:0];
    self.domainListNavigationController.tabBarItem = domainListTabBar;
    [domainListTabBar release];
    /* +-------------------------- End of domain list subview ------------------------+ */
    
    /* +----------------------------- The account subview ----------------------------+ */
    MercuryAccountTableViewController *atTemp = [[MercuryAccountTableViewController alloc] init];
    UINavigationController *accountVCTemp = [[UINavigationController alloc]
                                             initWithRootViewController:atTemp];
    [atTemp release];
    accountVCTemp.navigationBar.barStyle = UIBarStyleBlack;
    self.accountNavigationController = accountVCTemp;
    [accountVCTemp release];
    
    // TODO: Chage a new tab image here.
    // Set settings tab bar item of settings view controller.
    UIImage *accountTabBarItemImage = [UIImage imageNamed:MainboardTabbarView];
    NSString *accountTabBarItemTitle = 
    [self.mainboardUIContent.uiMainboardKeys objectAtIndex:MB_EN_ACCOUNT];
    UITabBarItem *accountTabBar = [[UITabBarItem alloc] initWithTitle:accountTabBarItemTitle
                                                                 image:accountTabBarItemImage 
                                                                   tag:1];
    self.accountNavigationController.tabBarItem = accountTabBar;
    [accountTabBar release];
    /* +-------------------------- End of account subview ----------------------------+ */

    /* +----------------------------- The settings subview ---------------------------+ */
    MercurySettingsViewController *sTemp = [[MercurySettingsViewController alloc] init];
    UINavigationController *settingsVCTemp = [[UINavigationController alloc] 
                                              initWithRootViewController:sTemp];
    [sTemp release];
    settingsVCTemp.navigationBar.barStyle = UIBarStyleBlack;
    self.settingsNavigationController = settingsVCTemp;
    [settingsVCTemp release];
    
    // TODO: Chage a new tab image here.
    // Set settings tab bar item of settings view controller.
    UIImage *settingsTabBarItemImage = [UIImage imageNamed:MainboardTabbarView];
    NSString *settingsTabBarItemTitle = 
        [self.mainboardUIContent.uiMainboardKeys objectAtIndex:MB_EN_SETTINGS];
    UITabBarItem *settingsTabBar = [[UITabBarItem alloc] initWithTitle:settingsTabBarItemTitle
                                                                 image:settingsTabBarItemImage 
                                                                   tag:2];
    self.settingsNavigationController.tabBarItem = settingsTabBar;
    [settingsTabBar release];
    /* +-------------------------- End of settings subview ---------------------------+ */
    
    /* +------------------------------- The help subview -----------------------------+ */
    MercuryHelpViewController *hTemp = [[MercuryHelpViewController alloc] init];
    UINavigationController *helpVCTemp = [[UINavigationController alloc] 
                                          initWithRootViewController:hTemp];
    [hTemp release];
    helpVCTemp.navigationBar.barStyle = UIBarStyleBlack;
    self.helpNavigationController = helpVCTemp;
    [helpVCTemp release];
    
    // TODO: Chage a new tab image here.
    // Set settings tab bar item of settings view controller.
    UIImage *helpTabBarItemImage = [UIImage imageNamed:MainboardTabbarView];
    NSString *helpTabBarItemTitle = 
    [self.mainboardUIContent.uiMainboardKeys objectAtIndex:MB_EN_HELP];
    UITabBarItem *helpTabBar = [[UITabBarItem alloc] initWithTitle:helpTabBarItemTitle
                                                                 image:helpTabBarItemImage 
                                                                   tag:3];
    self.helpNavigationController.tabBarItem = helpTabBar;
    [helpTabBar release];
    /* +---------------------------- End of help subview -----------------------------+ */
    
    /* +----------------------------- The root tab bar view --------------------------+ */
    UITabBarController *tabBarTemp = [[UITabBarController alloc] init];
    self.mainboardTabBarController = tabBarTemp;
    [tabBarTemp release];
    
    self.mainboardTabBarController.delegate = self;
    
    // Add the Navigation Controllers to Tab Bar Controller
    NSArray *controllersArray = [[NSArray alloc] initWithObjects:
                                 self.domainListNavigationController,
                                 self.accountNavigationController,
                                 self.settingsNavigationController,
                                 self.helpNavigationController, nil];
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
