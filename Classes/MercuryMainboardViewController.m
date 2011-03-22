//
//  MercuryMainboardViewController.m
//  Mercury
//
//  Created by puretears on 3/13/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import "MercuryMainboardViewController.h"

@implementation MercuryMainboardViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)dealloc {
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
    // Create the root UIView object
	CGRect viewRect = [[UIScreen mainScreen] bounds];
    
    //viewRect.origin.y += viewRect.size.height;
    //viewRect.size.height += (viewRect.size.height);
    
	UIView *viewTemp = [[UIView alloc] initWithFrame:viewRect];
	self.view = viewTemp;
    [viewTemp release];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *viewTemp1 = [[[UIView alloc] initWithFrame:viewRect] autorelease];
    viewTemp1.backgroundColor = [UIColor redColor];
    viewTemp1.alpha = 0.3;
    [self.view addSubview:viewTemp1];
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
