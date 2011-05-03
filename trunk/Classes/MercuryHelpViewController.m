//
//  MercuryHelpViewController.m
//  Mercury
//
//  Created by Jeffrey on 02/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MercuryHelpViewController.h"


@implementation MercuryHelpViewController


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
    // Add the navigation title.
    self.title = @"Help";
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
