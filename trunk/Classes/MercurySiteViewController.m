//
//  MercurySiteViewController.m
//  Mercury
//
//  Created by Jeffrey on 12/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MercurySiteViewController.h"
#import "AppConfig.h"
#import "MercuryAppDelegate.h"


@implementation MercurySiteViewController


- (void)dealloc
{
    [settingsBarButton release];
    [siteUIContent release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadView {
    // Load the global UI helper object.
    MercuryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    siteUIContent = appDelegate.uiContent.uiSiteKeys;
    
    // Add settings button to navigation controller.
    settingsBarButton = [[UIBarButtonItem alloc] 
                         initWithTitle:[siteUIContent objectAtIndex:SI_EN_SETTINGS]  
                                 style:UIBarButtonItemStyleDone 
                                target:self 
                                action:@selector(siteSettingsButtonPressed:)];
    [self navigationItem].rightBarButtonItem = settingsBarButton;
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


#pragma mark - Site Settings button action
- (void)siteSettingsButtonPressed:(id)sender {
    siteSettingsViewController = [[MercurySiteSettingsViewController alloc] init];
    [[self navigationController] pushViewController:siteSettingsViewController animated:YES];
}

@end
