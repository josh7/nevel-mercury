//
//  MercuryMainboardViewController.m
//  Mercury
//
//  Created by puretears on 3/13/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import "MercuryMainboardViewController.h"

@implementation MercuryMainboardViewController
@synthesize mainboardTabBarController;
@synthesize stieListNavigationController;
@synthesize nevelSettingsNavigationController;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//

- (void)dealloc {
    [mainboardTabBarController release];
    [stieListNavigationController release];
    [nevelSettingsNavigationController release];
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
//    mainboardUIContent = [[UIContent alloc] init];
//    [mainboardUIContent initWithUiContent];
    
    // create Site List Navigation Controller
    MercurySiteListNavigationController *siteListNavTemp = [[MercurySiteListNavigationController alloc] init];
    self.stieListNavigationController = siteListNavTemp;
    [siteListNavTemp release];
//        // a nav root view for testing
//    UIViewController *vcTemp1 = [[[UIViewController alloc] init] autorelease];
//    vcTemp1.title = @"vctemp1";
//    vcTemp1.view.backgroundColor = [UIColor redColor];
//    [self.stieListNavigationController pushViewController:vcTemp1 animated:YES];
//        // create the Tab Bar Item
//    UIImage *siteListItemImage = [UIImage imageNamed:@"nevel_icon.png"];
//    UITabBarItem *tbTemp1 = [[UITabBarItem alloc] 
//                             initWithTitle:[mainboardUIContent.uiMainboardKeys objectAtIndex:0] 
//                                     image:siteListItemImage 
//                                       tag:0];
//    self.stieListNavigationController.tabBarItem = tbTemp1;
//    [tbTemp1 release];
    
    // create Nevel Settings Navigation Controller
    UINavigationController *nevelSteeingsTemp = [[UINavigationController alloc] init];
    self.nevelSettingsNavigationController = nevelSteeingsTemp;
    [nevelSteeingsTemp release];
        // a nav root view for testing
    UIViewController *vcTemp2 = [[[UIViewController alloc] init] autorelease];
    vcTemp2.title = @"vctemp2";
    vcTemp2.view.backgroundColor = [UIColor blueColor];
    [self.nevelSettingsNavigationController pushViewController:vcTemp2 animated:YES];
        // create the Tab Bar Item
    UIImage *nevelSettingsItemImage = [UIImage imageNamed:@"nevel_icon.png"];
    UITabBarItem *tbTemp2 = [[UITabBarItem alloc] 
                             initWithTitle:[mainboardUIContent.uiMainboardKeys objectAtIndex:1] 
                             image:nevelSettingsItemImage 
                             tag:1];
    self.nevelSettingsNavigationController.tabBarItem = tbTemp2;
    [tbTemp2 release];
    
    // creat Nevel Mainboard Tab Bar Controller
    UITabBarController *tabBarTemp = [[UITabBarController alloc] init];
    self.mainboardTabBarController = tabBarTemp;
    [tabBarTemp release];
    
    // add the Navigation Controllers to Tab Bar Controller
    NSArray *controllersArray = [[NSArray alloc] initWithObjects:
                                 self.stieListNavigationController, 
                                 self.nevelSettingsNavigationController, nil];
    self.mainboardTabBarController.viewControllers = controllersArray;
    [controllersArray release];
    self.view = self.mainboardTabBarController.view;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController 
shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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
