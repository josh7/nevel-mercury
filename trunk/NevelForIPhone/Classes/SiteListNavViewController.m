//
//  SiteListViewController.m
//  NevelForiPhone
//
//  Created by Jeffrey on 11-2-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SiteListNavViewController.h"


@implementation SiteListNavViewController

//@synthesize siteListNavController;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	UINavigationController *newSiteListNavController = [[UINavigationController alloc] initWithNibName:@"SiteListNavViewController" bundle:nil];
	self.siteListNavController = newSiteListNavController;
	[self.view insertSubview: newSiteListNavController.view atIndex:0];
	[newSiteListNavController release];
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
//	siteListNavController = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
//	[siteListNavController release];
    [super dealloc];
}


@end
