//
//  MercurySiteListViewController.m
//  Mercury
//
//  Created by Jeffrey on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MercurySiteListNavigationController.h"


@implementation MercurySitesListNavigationController
//@synthesize siteListNavRootViewController;
@synthesize siteListBgImageView;


- (void)dealloc
{
    [siteListBgImageView release];
    //[siteListNavRootViewController release];
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
    // The register button.
	UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	registerButton.frame = CGRectMake(10, 380, 105, 37);
	registerButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	registerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	[registerButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];    
	[registerButton setTitle:@"Test" forState:UIControlStateNormal];
	registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
	registerButton.alpha = 0;
	[registerButton addTarget:self 
					   action:@selector(registerPressed:) 
		     forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:registerButton];

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
