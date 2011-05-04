//
//  MercuryLoginViewController.m
//  Mercury
//
//  Created by puretears on 3/6/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import "MercuryLoginViewController.h"
#import "LoginTableCell.h"
#import "MercuryAppDelegate.h"
#import "MercuryMainboardViewController.h"

#define SITELIST @"SiteList"


@implementation MercuryLoginViewController
@synthesize bgImageView;
@synthesize logoImageView;
@synthesize loginControlLayer;
@synthesize loginTableView;
@synthesize hud;
@synthesize loginUIContent;
@synthesize userConfigKeys;
@synthesize didRelogIn;
@synthesize xmlParser;
@synthesize keyboardAccessoryView;
@synthesize doneBarButtonItem;
@synthesize segmentBarButtonItem;

- (void)dealloc {
	[bgImageView release];
    [logoImageView release];
	[loginControlLayer release];
	[loginTableView release]; 
    [loginUIContent release];
    [userConfigKeys release];
    [xmlParser release];
    [mIO release];
    [keyboardAccessoryView release];
    [doneBarButtonItem release];
    [segmentBarButtonItem release];
    [super dealloc];
}


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];

    // Load the global UI helper object.
    MercuryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.loginUIContent = appDelegate.uiContent;
    
	scrollup = 0;
    self.didRelogIn = NO;
    NSMutableArray *arrayTmpt = [[NSMutableArray alloc] initWithObjects:@"", @"", nil];
    self.userConfigKeys = arrayTmpt;
    [arrayTmpt release];
	
	// Create the root UIView object.
	CGRect viewRect = [[UIScreen mainScreen] bounds];
	UIView *viewTemp = [[UIView alloc] initWithFrame:viewRect];
	self.view = viewTemp;
	[viewTemp release];
	
    /* +------------------------- The background images group -------------------------+ */
    // The background at the bottom.
	UIImage *imageTemp = [UIImage imageNamed:loginBg];
	UIImageView *ivTemp = [[UIImageView alloc] initWithImage:imageTemp];
	self.bgImageView = ivTemp;
	[ivTemp release];
	[self.view insertSubview:self.bgImageView atIndex:0];
    
    // The logo on the background.
    UIImage *logoImageTemp = [UIImage imageNamed:loginLogo];
    UIImageView *logoViewTemp = [[UIImageView alloc] initWithFrame:CGRectMake(85, 150, 150, 59)];
    self.logoImageView = logoViewTemp;
    [logoViewTemp release];
    self.logoImageView.image = logoImageTemp;
    [self.view insertSubview:self.logoImageView atIndex:1];
    /* +--------------------- End of the background images group ----------------------+ */
    
    /* +------------------------------- The input board -------------------------------+ */
	// Create an additional layer to hold login controls.
    UIControl *loginControlLayerTemp = [[UIControl alloc] initWithFrame:viewRect];
	self.loginControlLayer = loginControlLayerTemp;
	self.loginControlLayer.backgroundColor = [UIColor colorWithRed:0.000 
															 green:0.000 
															  blue:0.000 
															 alpha:0.000];
	[loginControlLayerTemp release];
    [self.view insertSubview:self.loginControlLayer atIndex:1];
 
	// Create the login table view.
	UITableView *tableViewTemp = [[UITableView alloc] initWithFrame:CGRectMake(0, 266, 320, 153) 
															  style:UITableViewStyleGrouped];
	self.loginTableView = tableViewTemp;
	[tableViewTemp release];
	self.loginTableView.backgroundColor = [UIColor clearColor];
	self.loginTableView.delegate = self;
	self.loginTableView.dataSource = self;
	self.loginTableView.alpha = 0;
	[self.loginControlLayer addSubview:self.loginTableView];
    
    // Now we do not need a register button.
#ifdef VERSION_2_REGISTER
    // The register button.
	UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	registerButton.frame = CGRectMake(10, 380, 105, 37);
	registerButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	registerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	[registerButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];    
	[registerButton setTitle:[loginUIContent.uiLoginKeys objectAtIndex:LI_EN_REGISTER] 
                    forState:UIControlStateNormal];
	registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
	registerButton.alpha = 0;
	[registerButton addTarget:self 
					   action:@selector(registerPressed:) 
		     forControlEvents:UIControlEventTouchUpInside];
	[self.loginControlLayer addSubview:registerButton];
#endif
    
    // The emergence animation.
	[UIView animateWithDuration:1.0 animations:^{
		self.loginTableView.alpha = 1.0;
//		loginButton.alpha = 1.0;
        
#ifdef VERSION_2
        registerButton.alpha = 1.0;
#endif
        
	}];
    /* +---------------------------- End of he input board ----------------------------+ */
    
    /* +---------------------- The keyboard input accessory view ----------------------+ */
    /*
     * +----------------------------------- UIToolbar -----------------------------------+
     * + | UISegmentedControl |  UIBarButtonSystemItemFlexibleSpace  | UIBarButtonItem | +
     * +---------------------------------------------------------------------------------+
     */
    // Our toolbar.
    UIToolbar *tbTemp = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 100, 320, 44)];
    tbTemp.barStyle = UIBarStyleBlackTranslucent;
    self.keyboardAccessoryView = tbTemp;
    [tbTemp release];
    
    // Our segmented conrol to hold "previous" and "Next".
    NSArray *segmentItems = [NSArray arrayWithObjects:
                             [self.loginUIContent.uiLoginKeys objectAtIndex:LI_EN_PREVIOUS],
                             [self.loginUIContent.uiLoginKeys objectAtIndex:LI_EN_NEXT], nil];
    UISegmentedControl *scTemp = [[UISegmentedControl alloc] initWithItems:segmentItems];
    scTemp.frame = CGRectMake(6, 8, 128, 30);
    scTemp.momentary = NO;
    scTemp.segmentedControlStyle = UISegmentedControlStyleBar;
    scTemp.tintColor = [UIColor blackColor];
    self.segmentBarButtonItem = scTemp;
    [scTemp release];
    [self.segmentBarButtonItem addTarget:self 
                                  action:@selector(segmentedControlPressed:) 
                        forControlEvents:UIControlEventValueChanged];
    
    // The space between two toolbar items.
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] 
                                 initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
                                 target:self 
                                 action:nil];
    
    // Our Login button.
    UIBarButtonItem *bbiTemp = [[UIBarButtonItem alloc] initWithTitle:
                                [self.loginUIContent.uiLoginKeys objectAtIndex:LI_EN_LOGIN]
                                                                style:UIBarButtonItemStyleDone 
                                                               target:self 
                                                               action:@selector(loginPressed:)];
    bbiTemp.width = 90;
    self.doneBarButtonItem = bbiTemp;
    [bbiTemp release];
        
    NSArray *toolbarItems = [NSArray arrayWithObjects:flexItem, self.doneBarButtonItem, nil];
    [self.keyboardAccessoryView setItems:toolbarItems animated:YES];
    [self.keyboardAccessoryView addSubview:self.segmentBarButtonItem];
    
    /* +------------------- End of the keyboard input accessory view ------------------+ */
    
}

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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#pragma mark - Table view data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
	return 2; 
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Use the cutomized table cell.
    static NSString *CustomerLoginCellIdentifier = @"CustomerLoginCellIdentifier";
	NSUInteger row = [indexPath row];
	UITableViewCellStyle style = UITableViewCellStyleDefault;
    LoginTableCell *cell = 
    (LoginTableCell *)[tableView dequeueReusableCellWithIdentifier:CustomerLoginCellIdentifier];
	
	if (cell == nil) {
		cell = [[[LoginTableCell alloc] initWithStyle:style 
									  reuseIdentifier:CustomerLoginCellIdentifier] autorelease];
		cell.loginLabel.text = [loginUIContent.uiLoginKeys objectAtIndex:row];
        
        // Add the inputAccessoryView to keyborard.
        cell.loginTextField.inputAccessoryView = self.keyboardAccessoryView; 
		
        // Specify the ID textfield.
        if (row == 0) {
            cell.loginTextField.keyboardType = UIKeyboardTypeEmailAddress;
            cell.loginTextField.clearsOnBeginEditing = NO;
            cell.loginTextField.placeholder = [self.loginUIContent.uiLoginKeys 
                                               objectAtIndex:LI_EN_ID_HOLDER];
            
            // Add actions to textfield.
            [cell.loginTextField setDelegate:self];
            [cell.loginTextField addTarget:self
                                    action:@selector(idTextFieldPressed:) 
                          forControlEvents:UIControlEventEditingChanged];
            [cell.loginTextField setDelegate:self];
            [cell.loginTextField addTarget:self
                                    action:@selector(idTextFieldPressedBeforeEditing:) 
                          forControlEvents:UIControlEventEditingDidBegin];
            [cell.loginTextField becomeFirstResponder];
        }
        
		// Specify the password textfield.
		if (row == 1) {
            cell.loginTextField.keyboardType = UIKeyboardTypeDefault;
			[cell.loginTextField setSecureTextEntry:YES];
            cell.loginTextField.placeholder = [self.loginUIContent.uiLoginKeys 
                                               objectAtIndex:LI_EN_PASSWORD_HOLDER];
            
            // Add actions to textfield.
            [cell.loginTextField setDelegate:self];
            [cell.loginTextField addTarget:self
                                    action:@selector(passwordTextFieldPressed:) 
                          forControlEvents:UIControlEventEditingChanged];
            [cell.loginTextField setDelegate:self];
            [cell.loginTextField addTarget:self
                                    action:@selector(passwordTextFieldPressedBeforeEditing:) 
                          forControlEvents:UIControlEventEditingDidBegin];
		}
	}
	return cell;
}


#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	if (scrollup == 0) {
		CGPoint newPosition = self.loginControlLayer.center;
		newPosition.y -= 215;
        CGPoint newLogoPosition = self.logoImageView.center;
        newLogoPosition.y -= 215;
	
		[UIView animateWithDuration:0.3 animations:^ {
			self.loginControlLayer.center = newPosition;
            self.logoImageView.center = newLogoPosition;
		}];
		scrollup = 1;
	}
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
        if (scrollup == 1) {
        CGPoint newPosition = self.loginControlLayer.center;
        newPosition.y += 215;
        CGPoint newLogoPosition = self.logoImageView.center;
        newLogoPosition.y += 215;
        
        [UIView animateWithDuration:0.3 animations:^ {
            self.loginControlLayer.center = newPosition;
            self.logoImageView.center = newLogoPosition;
        }];
        scrollup = 0;
    }
    [textField resignFirstResponder];
    return YES;	
}



#pragma mark - Text field pressed methods

- (void)idTextFieldPressed:(UITextField *)sender{
    NSString *idTemp = [[NSString alloc] initWithString:sender.text];
    [self.userConfigKeys replaceObjectAtIndex:0 withObject:idTemp];
    [idTemp release];
}


- (void)passwordTextFieldPressed:(UITextField *)sender{
    [self.segmentBarButtonItem setEnabled:NO forSegmentAtIndex:1];
    NSString *passwordTemp = [[NSString alloc] initWithString:sender.text];
    [self.userConfigKeys replaceObjectAtIndex:1 withObject:passwordTemp];
    [passwordTemp release];
}


- (void)idTextFieldPressedBeforeEditing:(UITextField *)sender{
    [self.segmentBarButtonItem setEnabled:NO forSegmentAtIndex:0];
    [self.segmentBarButtonItem setEnabled:YES forSegmentAtIndex:1];
    NSString *idTemp = [[NSString alloc] initWithString:sender.text];
    [self.userConfigKeys replaceObjectAtIndex:0 withObject:idTemp];
    [idTemp release];
}


- (void)passwordTextFieldPressedBeforeEditing:(UITextField *)sender{
    [self.segmentBarButtonItem setEnabled:NO forSegmentAtIndex:1];
    [self.segmentBarButtonItem setEnabled:YES forSegmentAtIndex:0];
    [self.userConfigKeys replaceObjectAtIndex:1 withObject:@""];
}


#pragma mark - Segmented control action
- (void)segmentedControlPressed:(id)sender {
    // When press the previous/next segment, we change the text field focus.
    NSUInteger selectSegmentIndex = self.segmentBarButtonItem.selectedSegmentIndex;
    
    // We get the textfield object here.
    LoginTableCell *cellTemp_1 = 
    (LoginTableCell *)[[self.loginTableView visibleCells] objectAtIndex:0];
    LoginTableCell *cellTemp_2 = 
    (LoginTableCell *)[[self.loginTableView visibleCells] objectAtIndex:1];
    if (selectSegmentIndex == 0) {
        // We change the textfield focus here.
        [cellTemp_2.loginTextField resignFirstResponder];
        [cellTemp_1.loginTextField becomeFirstResponder];
    }
    else if (selectSegmentIndex == 1) {
        // We change the textfield focus here.
        [cellTemp_1.loginTextField resignFirstResponder];
        [cellTemp_2.loginTextField becomeFirstResponder];
    }
}


#pragma mark - UIButton methods

- (void)loginPressed:(id)sender {
    #ifdef DEBUG
    NSLog(@"login pressed");
    #endif

    // First, we check the information inputed by user.
    // If the infromation was not complete, an alert will show.
    if ([[self.userConfigKeys objectAtIndex:0] length] == 0 || 
        [[self.userConfigKeys objectAtIndex:1] length] == 0 ) {
        UIAlertView *alertForcIncomplete = [[UIAlertView alloc]
                                     initWithTitle:[loginUIContent.uiLoginKeys 
                                                    objectAtIndex:LI_EN_ALERT_TITLE]
                                     message:[loginUIContent.uiLoginKeys 
                                              objectAtIndex:LI_EN_ALERT_CONTENT]
                                     delegate:self
                                     cancelButtonTitle:[loginUIContent.uiLoginKeys 
                                                        objectAtIndex:LI_EN_ALERT_BUTTON]
                                     otherButtonTitles:nil];
        [alertForcIncomplete show];
        [alertForcIncomplete release];
    }
    
    else {
    // Second, we wrap the account name and password with keychain and store them.
        NSString *accountName = [self.userConfigKeys objectAtIndex:0];
        NSString *password = [self.userConfigKeys objectAtIndex:1];
        NSString *serviceName = [self.loginUIContent.uiLoginKeys objectAtIndex:LI_EN_SERVICE_NAME];
        
        BOOL passwordDidStore = [SFHFKeychainUtils storeUsername:accountName
                                                         andPassword:password
                                                      forServiceName:serviceName
                                                      updateExisting:YES
                                                               error:nil];
        // If stored successfully, we sand the ID & password to sever.
        if (passwordDidStore == YES) {
#ifdef DEBUG
            NSLog(@"passwordDidStore == YES");
#endif
            // TODO: send to server.
        }
        // If failed to store, we make a record. I guess this will never happens.
        else {
#ifdef DEBUG
            NSLog(@"The ID and Password were failed to store into keychain.");
#endif
        }
        
        // If the sever returns matching.
        // JUST A TEST HERE.
        if (!nil) {
            // We begin to login.
            [self startLogin:self];
        }
        // If the sever returns not matching. we delete the correponding ID & password , 
        // and display an alert to inform user to try again.
        else {
            // First, we delete the correponding ID & password in the keychain.
            BOOL passwordDidDelete = [SFHFKeychainUtils deleteItemForUsername:accountName
                                                               andServiceName:serviceName
                                                                        error:nil];
                // If deleted successfully, we go back to login view to try again.
            if (passwordDidDelete != YES) {
                // Show an alert to inform user that relogin needed.
                UIAlertView *relogin = [[UIAlertView alloc] initWithTitle:
                                        @"Oops, we can not find this ID or password."
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Try again" 
                                                              otherButtonTitles:nil];
                [relogin show];
                [relogin release];
                
                // Sigh, relogin here.
                // TODO: the cell come in from right, and do not clear any thing.
            }
                // Or if failed to delete, we make a record. I guess this will never happens.
            else {
#ifdef DEBUG
                NSLog(@"The ID and Password were failed to delete from keychain.");
#endif
            }
        }
    }
}


#ifdef VERSION_2_REGISTER
- (void)registerPressed:(id)sender{
    #ifdef DEBUG
    NSLog(@"register pressed");
    #endif
    
    // In the future, we add the registration here.
}
#endif


#pragma mark - UIActionSheet delegate

// Start to login when press login button.
- (void)startLogin:(id)sender {
#ifdef DEBUG
    NSLog(@"startLogin");
#endif
    
    CGPoint newPosition = self.loginControlLayer.center;
	newPosition.x = -160;
    
	[UIView animateWithDuration:0.5 
					 animations:^ { 
                         self.loginControlLayer.center = newPosition; 
                     }
					 completion:^ (BOOL finished) { 
                         // Get rid of all login controls and show the sync hud.
						 [self.loginControlLayer removeFromSuperview]; 
						 [self showUsingBlocks:sender];
					 }];
}


#pragma mark - Execution code

- (void)showUsingBlocks:(id)sender {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
		// Show the HUD in the main thread.
		dispatch_async(dispatch_get_main_queue(), ^ {
			self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
			self.hud.labelText = [loginUIContent.uiLoginKeys objectAtIndex:12];
		});
		
		// Do the background loading here.
		[self loadingTask];
        
		dispatch_async(dispatch_get_main_queue(), ^{
            // Here we have synced all data. Swith to the new view.
            MercuryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            
            // Set the transfer animation.
            CATransition *animation = [CATransition animation];
            animation.duration = 0.3f;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.fillMode = kCAFillModeForwards;
            animation.removedOnCompletion = NO;
            animation.type = kCATransitionPush;
            animation.subtype = kCATransitionFromRight;
            
            // If this is our user frist login.
            if (self.didRelogIn == NO) {
                // Get rid of the login view controller and add the main one.
                [appDelegate.mercuryLoginViewController.view removeFromSuperview];
                [appDelegate.window addSubview:appDelegate.mercuryMainboardViewController.view];
                [appDelegate.mercuryMainboardViewController.view.layer addAnimation:animation 
                                                                             forKey:@"animation"];
            }
            // If this is our user relogin.
            else if (self.didRelogIn == YES) {
                // Get rid of the login view controller and add the main one.
                [self.view removeFromSuperview];
                // Here we make a new main board for reloginer.
                MercuryMainboardViewController *reloginMercuryMainboardViewController = 
                    [[MercuryMainboardViewController alloc] init];
                [appDelegate.window addSubview:reloginMercuryMainboardViewController.view];
                [reloginMercuryMainboardViewController.view.layer addAnimation:animation 
                                                                        forKey:@"animation"];                
            }
            
        });
	});
}


-(void)loadingTask {
	// Do the background loading here.
	// Just for demo now...
    // TODO: Load the domain list here.
	sleep(1);

    mIO = [[MercuryNetIO alloc] init];
    [mIO setURLFromPlist:@"SiteList" URLKey:@"SiteListURL"];
    [mIO syncFetch:@"SiteList.xml"];
    
    [mIO setURLFromPlist:@"SiteList" URLKey:@"SitePlotURL"];
    [mIO syncFetch:@"SitePlot.xml"];
    
    XMLParser *xmlSiteListParser = [XMLParser alloc];
    self.xmlParser = xmlSiteListParser;
    [xmlSiteListParser release];
    [self.xmlParser initWithFile:@"SiteList.xml"];
    [self.xmlParser parseSiteName];
    
	// Change the HUD mode.
//	self.hud.mode = MBProgressHUDModeDeterminate;
//	self.hud.labelText = [loginUIContent.uiLoginKeys objectAtIndex:13];
//	float progress = 0.0f;
//	while (progress < 1.0f) {
//		progress += 0.01f;
//		self.hud.progress = progress;
//		usleep(10000);
//	}
}


#pragma mark - ASIHTTPRequest delegate
- (void)metaDataFetchComplete:(ASIHTTPRequest *)request {
#ifdef DEBUG
    NSLog(@"Download successful.");
#endif
}

- (void)metaDataFetchFailed:(ASIHTTPRequest *)request {
#ifdef DEBUG
     NSLog(@"Download failed.");
#endif
}


#pragma mark - MBProgressHUD delegate

// The method will be called on finishing hud.
- (void)hudWasHidden:(MBProgressHUD *)hudPara {
	[hud removeFromSuperview];  
	[hud release];
}


@end