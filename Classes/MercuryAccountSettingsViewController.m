//
//  MercutyAccountSettingsViewController.m
//  Mercury
//
//  Created by Jeffrey on 11-4-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MercuryAccountSettingsViewController.h"
#import "MercuryAppDelegate.h"


@implementation MercuryAccountSettingsViewController
@synthesize loginTypeSegmentedControl;
@synthesize currentAccountNameString;
@synthesize accountSettingsUIContent;
@synthesize accountSettingsConfig;

- (void)dealloc
{
    [loginTypeSegmentedControl release];
    [currentAccountNameString release];
    [accountSettingsUIContent release];
    [accountSettingsConfig release];
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
    self.accountSettingsUIContent = appDelegate.uiContent;
    
    // Set the app configuration object.
    AppConfig *appConfigTemp = [[AppConfig alloc] init];
    self.accountSettingsConfig = appConfigTemp;
    [appConfigTemp release];
    [self.accountSettingsConfig initWithAppConfig];
    
    // Create the root UIView object.
	CGRect viewRect = [[UIScreen mainScreen] bounds];
	UIView *viewTemp = [[UIView alloc] initWithFrame:viewRect];
	self.view = viewTemp;
	[viewTemp release];
    
    // Add lables to the view.
    UILabel *accountName = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 150, 44)];
    accountName.text = @"Account Name:";
    accountName.textAlignment = UITextAlignmentLeft;
    accountName.textColor = [UIColor colorWithRed:0 green:0.5 blue:1 alpha:1];
    accountName.backgroundColor = [UIColor clearColor];
    [self.view addSubview:accountName];
    [accountName release];
    
    UILabel *currentAccountName = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 310, 44)];
    currentAccountName.textAlignment = UITextAlignmentLeft;
    currentAccountName.textColor = [UIColor whiteColor];
    currentAccountName.backgroundColor = [UIColor clearColor];
    currentAccountName.text = self.currentAccountNameString;
    [self.view addSubview:currentAccountName];
    [currentAccountName release];
    
    // Add our segmented control.
    NSArray *scArray = [NSArray arrayWithObjects:@"Save Password", @"Auto Login", nil];
    UISegmentedControl *scTemp = [[UISegmentedControl alloc] initWithItems:scArray];
    scTemp.frame = CGRectMake(10, 160, 300, 44);
    // We use settings info in appConfig.
    // TODO: load the settings from appConfig.
//    scTemp.selectedSegmentIndex = 
    self.loginTypeSegmentedControl = scTemp;
    [scTemp release];
    [self.loginTypeSegmentedControl addTarget:self 
                                       action:@selector(segmentedControlPressed:) 
                             forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.loginTypeSegmentedControl];
    
    // Add our log out button.
    logOutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    logOutButton.frame = CGRectMake(10, 240, 300, 44);
    logOutButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	logOutButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	[logOutButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
	[logOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [logOutButton setTitle:@"Log Out" forState:UIControlStateNormal];
    logOutButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    [logOutButton addTarget:self 
                     action:@selector(buttonPressed:) 
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logOutButton];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Segmented control action
- (void)segmentedControlPressed:(id)sender {
    // Pass the login type to app configuration.
    NSInteger selectSegmentIndex = self.loginTypeSegmentedControl.selectedSegmentIndex;
    // TODO: create method in appConfig.
//    [self.accountSettingsConfig methodHere];
}


#pragma mark - Button action
- (void)buttonPressed:(id)sender {
    // Go to Mercury login view.
}


@end
