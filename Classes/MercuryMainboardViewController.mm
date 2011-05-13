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

- (void)loadView {
    [super loadView];
    
    // Load the global UI helper object.
    MercuryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    mainboardUIContent = appDelegate.uiContent.uiMainboardKeys;

    /* +----------------------------- The domain list subview ------------------------+ */
    MercuryDomainListViewController *dlTemp = [[MercuryDomainListViewController alloc] init];
    dlTemp.title = [mainboardUIContent objectAtIndex:MB_EN_DOMAIN_LIST];
    domainListNavigationController = [[UINavigationController alloc] 
                                           initWithRootViewController:dlTemp];
    [dlTemp release];
    domainListNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    // TODO: use a translucent bar here, and fix the site list view.
//    domainListVCTemp.navigationBar.translucent = YES;
    
    // TODO: Chage a new tab image here.
    // Set sites list tab bar item of sites list view controller.
    UIImage *domainListTabBarItemImage = [UIImage imageNamed:MainboardTabbarView];
    NSString *domainListTabBarItemTitle = 
    [mainboardUIContent objectAtIndex:MB_EN_DOMAIN_LIST];
    UITabBarItem *domainListTabBar = [[UITabBarItem alloc] initWithTitle:domainListTabBarItemTitle
                                                                   image:domainListTabBarItemImage 
                                                                     tag:0];
    domainListNavigationController.tabBarItem = domainListTabBar;
    [domainListTabBar release];
    /* +-------------------------- End of domain list subview ------------------------+ */
    
    /* +----------------------------- The account subview ----------------------------+ */
    MercuryAccountTableViewController *atTemp = [[MercuryAccountTableViewController alloc] init];
    accountNavigationController = [[UINavigationController alloc]
                                        initWithRootViewController:atTemp];
    atTemp.title = [mainboardUIContent objectAtIndex:MB_EN_ACCOUNT];
    [atTemp release];
    accountNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    // TODO: Chage a new tab image here.
    // Set settings tab bar item of settings view controller.
    UIImage *accountTabBarItemImage = [UIImage imageNamed:MainboardTabbarView];
    NSString *accountTabBarItemTitle = 
    [mainboardUIContent objectAtIndex:MB_EN_ACCOUNT];
    UITabBarItem *accountTabBar = [[UITabBarItem alloc] initWithTitle:accountTabBarItemTitle
                                                                 image:accountTabBarItemImage 
                                                                   tag:1];
    accountNavigationController.tabBarItem = accountTabBar;
    [accountTabBar release];
    /* +-------------------------- End of account subview ----------------------------+ */

    /* +----------------------------- The settings subview ---------------------------+ */
    MercurySettingsViewController *sTemp = [[MercurySettingsViewController alloc] init];
    settingsNavigationController = [[UINavigationController alloc] 
                                    initWithRootViewController:sTemp];
    sTemp.title = [mainboardUIContent objectAtIndex:MB_EN_SETTINGS];
    [sTemp release];
    settingsNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    // TODO: Chage a new tab image here.
    // Set settings tab bar item of settings view controller.
    UIImage *settingsTabBarItemImage = [UIImage imageNamed:MainboardTabbarView];
    NSString *settingsTabBarItemTitle = [mainboardUIContent objectAtIndex:MB_EN_SETTINGS];
    UITabBarItem *settingsTabBar = [[UITabBarItem alloc] initWithTitle:settingsTabBarItemTitle
                                                                 image:settingsTabBarItemImage 
                                                                   tag:2];
    settingsNavigationController.tabBarItem = settingsTabBar;
    [settingsTabBar release];
    /* +-------------------------- End of settings subview ---------------------------+ */
    
    /* +------------------------------- The help subview -----------------------------+ */
    MercuryHelpViewController *hTemp = [[MercuryHelpViewController alloc] init];
    helpNavigationController = [[UINavigationController alloc] 
                                     initWithRootViewController:hTemp];
    hTemp.title = [mainboardUIContent objectAtIndex:MB_EN_HELP];
    [hTemp release];
    helpNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    // TODO: Chage a new tab image here.
    // Set settings tab bar item of settings view controller.
    UIImage *helpTabBarItemImage = [UIImage imageNamed:MainboardTabbarView];
    NSString *helpTabBarItemTitle = 
    [mainboardUIContent objectAtIndex:MB_EN_HELP];
    UITabBarItem *helpTabBar = [[UITabBarItem alloc] initWithTitle:helpTabBarItemTitle
                                                                 image:helpTabBarItemImage 
                                                                   tag:3];
    helpNavigationController.tabBarItem = helpTabBar;
    [helpTabBar release];
    /* +---------------------------- End of help subview -----------------------------+ */
    
    /* +----------------------------- The root tab bar view --------------------------+ */
    mainboardTabBarController = [[UITabBarController alloc] init];
    
    mainboardTabBarController.delegate = self;
    
    // Add the Navigation Controllers to Tab Bar Controller
    NSArray *controllersArray = [[NSArray alloc] initWithObjects:
                                                                domainListNavigationController,
                                                                accountNavigationController,
                                                                settingsNavigationController,
                                                                helpNavigationController, nil];
    mainboardTabBarController.viewControllers = controllersArray;
    [controllersArray release];
    
    [self.view addSubview:mainboardTabBarController.view];
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
