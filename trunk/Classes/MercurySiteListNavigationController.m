//
//  MercurySiteListViewController.m
//  Mercury
//
//  Created by Jeffrey on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MercurySiteListNavigationController.h"


@implementation MercurySiteListNavigationController
@synthesize siteListViewController;
@synthesize siteListBgImageView;
@synthesize siteListTabBarItem;
@synthesize siteListNavRootViewController;

- (void)dealloc
{
    [siteListTabBarItem release];
    [siteListViewController release];
    [siteListBgImageView release];
    [siteListNavRootViewController release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView{
    // create the background view to display a image before data loading completely
    UIImage *imageTemp = [UIImage imageNamed:@"Default.png"];
	UIImageView *ivTemp = [[UIImageView alloc] initWithImage:imageTemp];
	self.siteListBgImageView = ivTemp;  // self.siteListBgImageView is null. Why?
    self.siteListNavRootViewController.view = ivTemp; // also, this is null. Why?
	[ivTemp release];
	[self initWithRootViewController:siteListNavRootViewController];
    
    // init the tab bar item
    UIImage *itemImageTemp = [UIImage imageNamed:@"nevel_icon.png"];
    UITabBarItem *tabBarItemTemp = [[UITabBarItem alloc]
                                    initWithTitle:@"Site List" 
                                    image:itemImageTemp
                                    tag:0];
    self.siteListTabBarItem = tabBarItemTemp;
    [tabBarItemTemp release];
    
    // create navigation's first view controller
    UIViewController *testVC = [[[UIViewController alloc] init]  autorelease];
    testVC.view.backgroundColor = [UIColor redColor];
    [self pushViewController:testVC animated:YES];
//    MercurySiteListViewController *siteListVCTemp = [[MercurySiteListViewController alloc] init];
//    self.siteListViewController = siteListVCTemp;
//    [siteListVCTemp release];
//    [self pushViewController:self.siteListViewController animated:YES];
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
