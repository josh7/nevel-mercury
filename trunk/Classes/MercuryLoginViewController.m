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

@implementation MercuryLoginViewController
@synthesize bgImageView;
@synthesize logoImageView;
@synthesize loginControlLayer;
@synthesize loginTableView;
@synthesize mainboardViewController;
@synthesize uiDictionary;
@synthesize uiKeys;
@synthesize hud;
@synthesize userConfigKeys;


// The designated initializer.  Override if you create the controller 
// programmatically and want to perform customization that is not appropriate for viewDidLoad.

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    // init some class property 
	scrollup = 0;
    NSMutableArray *arrayTmpt = [[NSMutableArray alloc] initWithObjects:@"0", @"0", @"0", nil];
    self.userConfigKeys = arrayTmpt;
    [arrayTmpt release];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"UI" ofType:@"plist"];
	NSDictionary *uiDictionaryTemp = [[NSDictionary alloc] initWithContentsOfFile:path];
	self.uiDictionary = uiDictionaryTemp;
	[uiDictionaryTemp release];
	
	NSArray *array = [uiDictionary allKeys];
	self.uiKeys = array;
	
	// Create the root UIView object
	CGRect viewRect = [[UIScreen mainScreen] bounds];
	UIView *viewTemp = [[UIView alloc] initWithFrame:viewRect];
	self.view = viewTemp;
	[viewTemp release];
	
	UIImage *imageTemp = [UIImage imageNamed:@"Default.png"];
	UIImageView *ivTemp = [[UIImageView alloc] initWithImage:imageTemp];
	self.bgImageView = ivTemp;
	[ivTemp release];
	
	// "Paste the background onto the view"
	[self.view insertSubview:self.bgImageView atIndex:0];
    
    // paste the logo onto the view
    UIImage *logoImageTemp = [UIImage imageNamed:@"nevelLogoWhite.png"];
    UIImageView *logoViewTemp = [[UIImageView alloc] initWithFrame:CGRectMake(85, 150, 150, 59)];
    self.logoImageView = logoViewTemp;
    [logoViewTemp release];
    self.logoImageView.image = logoImageTemp;
    [self.view insertSubview:self.logoImageView atIndex:1];
    
	// Create an additional layer to hold login controls
    UIControl *loginControlLayerTemp = [[UIControl alloc] initWithFrame:viewRect];
	self.loginControlLayer = loginControlLayerTemp;
	self.loginControlLayer.backgroundColor = [UIColor colorWithRed:0.000 
															 green:0.000 
															  blue:0.000 
															 alpha:0.000];
    [self.loginControlLayer addTarget:self 
                               action:@selector(backgroundPressed:) 
                     forControlEvents:UIControlEventTouchDown];
	[loginControlLayerTemp release];
    [self.view insertSubview:self.loginControlLayer atIndex:1];
 
	// Create the login table control.
	UITableView *tableViewTemp = [[UITableView alloc] initWithFrame:CGRectMake(0, 266, 320, 153) 
															  style:UITableViewStyleGrouped];
	self.loginTableView = tableViewTemp;
	[tableViewTemp release];
    
	self.loginTableView.backgroundColor = [UIColor clearColor];
	self.loginTableView.delegate = self;
	self.loginTableView.dataSource = self;
	self.loginTableView.alpha = 0;
	[self.loginControlLayer addSubview:self.loginTableView];
	
    NSString *key = @"Login";
    NSArray *loginSection = [uiDictionary objectForKey:key];
    
	// The login button.
	UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	loginButton.frame = CGRectMake(205, 380, 105, 37);
	loginButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	loginButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	[loginButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
	[loginButton setTitle:[loginSection objectAtIndex:3] forState:UIControlStateNormal];
	loginButton.titleLabel.font	= [UIFont boldSystemFontOfSize:16.0f];
	loginButton.alpha = 0;
	[loginButton addTarget:self 
					action:@selector(loginPressed:) 
		  forControlEvents:UIControlEventTouchUpInside];
	[self.loginControlLayer addSubview:loginButton];
    
    // The register button.
	UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	registerButton.frame = CGRectMake(10, 380, 105, 37);
	registerButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	registerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	[registerButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];    
	[registerButton setTitle:[loginSection objectAtIndex:2] forState:UIControlStateNormal];
	registerButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
	registerButton.alpha = 0;
	[registerButton addTarget:self 
					   action:@selector(registerPressed:) 
		     forControlEvents:UIControlEventTouchUpInside];
	[self.loginControlLayer addSubview:registerButton];
	
	[UIView animateWithDuration:1.0 animations:^{
		self.loginTableView.alpha = 1.0;
		loginButton.alpha = 1.0;
        registerButton.alpha = 1.0;
	}];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[bgImageView release];
	[loginControlLayer release];
	[loginTableView release];
	[uiDictionary release];
	[uiKeys release];   // why hud does not need to be released here? Answer is at the bottom.
    [userConfigKeys release];
    [super dealloc];
}


- (void)showUsingBlocks:(id)sender {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
		// Show the HUD in the main thread
		dispatch_async(dispatch_get_main_queue(), ^ {
			self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
			self.hud.labelText = @"Login...";
		});
		
		// Do the background loading here
		[self loadingTask];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			[MBProgressHUD hideHUDForView:self.view animated:YES];
            
            // Here we have synced all data. Swith to the new view.
            MercuryMainboardViewController *boardTemp = 
            [[MercuryMainboardViewController alloc] init];
            self.mainboardViewController = boardTemp;
            [boardTemp release];
            
            MercuryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
           
            // Get rid of the login view controller and add the main one.
            [appDelegate.mercuryLoginViewController.view removeFromSuperview];
            [appDelegate.baseView addSubview:mainboardViewController.view];

            CATransition *animation = [CATransition animation];
            //animation.delegate = self;
            animation.duration = 0.3f;
            animation.timingFunction = UIViewAnimationCurveEaseInOut;
            animation.fillMode = kCAFillModeForwards;
            animation.removedOnCompletion = NO;
                                 
            animation.type = kCATransitionPush;
            animation.subtype = kCATransitionFromRight;
            [appDelegate.baseView.layer addAnimation:animation forKey:@"animation"];
        });
	});
}

#pragma mark -
#pragma mark Execution code

-(void)loadingTask {
	// Do the background loading here.
	// Just for demo now...
	sleep(3);
	
	// Change the HUD mode
	self.hud.mode = MBProgressHUDModeDeterminate;
	self.hud.labelText = @"Updating data...";
	float progress = 0.0f;
	
	while (progress < 1.0f) {
		progress += 0.01f;
		self.hud.progress = progress;
		usleep(50000);
	}
}

#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
	return 2; 
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
	UITableViewCellStyle style = UITableViewCellStyleDefault;
	static NSString *CustomerLoginCellIdentifier = @"CustomerLoginCellIdentifier";
	LoginTableCell *cell = 
		(LoginTableCell *)[tableView dequeueReusableCellWithIdentifier:CustomerLoginCellIdentifier];
	
	if (cell == nil) {
		cell = [[[LoginTableCell alloc] initWithStyle:style 
									  reuseIdentifier:CustomerLoginCellIdentifier] autorelease];

		NSString *key = @"Login";
		NSArray *loginSection = [uiDictionary objectForKey:key];
		cell.loginLabel.text = [loginSection objectAtIndex:row];
		
        // Set the account textfield attribute
        if (row == 0) {
            cell.loginTextField.keyboardType = UIKeyboardTypeEmailAddress;
            cell.loginTextField.placeholder = [loginSection objectAtIndex:7];
            cell.loginTextField.returnKeyType = UIReturnKeyNext;
            
            [cell.loginTextField setDelegate:self];
            [cell.loginTextField addTarget:self
                                    action:@selector(idTextFieldPressed:) 
                          forControlEvents:UIControlEventEditingChanged];
            [cell.loginTextField setDelegate:self];
            [cell.loginTextField addTarget:self
                                    action:@selector(idTextFieldPressedBeforeEditing:) 
                          forControlEvents:UIControlEventEditingDidBegin];
        }
        
		// Set the password textField attribute.
		if (row == 1) {
			[cell.loginTextField setSecureTextEntry:YES];
            cell.loginTextField.placeholder = [loginSection objectAtIndex:8];
            
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

#pragma mark -
#pragma mark UITextField Delegate

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


- (void)backgroundPressed:(id)sender{
    #ifdef DEBUG
    NSLog(@"backgroundPressed");
    #endif
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
        
        // make the editing textField resignFirstResponder
        LoginTableCell *cellTemp_1 = (LoginTableCell *)[[self.loginTableView visibleCells] objectAtIndex:0];
        [cellTemp_1.loginTextField resignFirstResponder];
        LoginTableCell *cellTemp_2 = (LoginTableCell *)[[self.loginTableView visibleCells] objectAtIndex:1];
        [cellTemp_2.loginTextField resignFirstResponder];
        }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    #ifdef DEBUG
    NSLog(@"textFieldShouldReturn");
    #endif
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


- (void)idTextFieldPressed:(UITextField *)sender{    
        NSString *idTemp = [[NSString alloc] initWithString:sender.text];
        [self.userConfigKeys replaceObjectAtIndex:0 withObject:idTemp];
        [idTemp release];
}


- (void)passwordTextFieldPressed:(UITextField *)sender{
        NSString *passwordTemp = [[NSString alloc] initWithString:sender.text];
        [self.userConfigKeys replaceObjectAtIndex:1 withObject:passwordTemp];
        [passwordTemp release];
}


- (void)idTextFieldPressedBeforeEditing:(UITextField *)sender{
    [self.userConfigKeys replaceObjectAtIndex:0 withObject:@"0"];
}


- (void)passwordTextFieldPressedBeforeEditing:(UITextField *)sender{
    [self.userConfigKeys replaceObjectAtIndex:1 withObject:@"0"];
}

#pragma mark -
#pragma mark UIButton method

- (void)loginPressed:(id)sender {
    #ifdef DEBUG
    NSLog(@"login pressed");
    #endif
    NSString *key = @"Login";
    NSArray *loginOptions = [uiDictionary objectForKey:key];
    if ([self.userConfigKeys objectAtIndex:0] != @"0" && 
        [self.userConfigKeys objectAtIndex:1] != @"0") {
        UIActionSheet *loginActionSheet = [[UIActionSheet alloc]
                                           initWithTitle:nil
                                           delegate:self
                                           cancelButtonTitle:[loginOptions objectAtIndex:4]
                                           destructiveButtonTitle:[loginOptions objectAtIndex:5]
                                           otherButtonTitles:[loginOptions objectAtIndex:6], nil];
        [loginActionSheet showInView:self.view];
        [loginActionSheet release];
    }
    else {
        UIAlertView *alertForTest = [[UIAlertView alloc]
                                     initWithTitle:[loginOptions objectAtIndex:9]
                                     message:[loginOptions objectAtIndex:10]
                                     delegate:self
                                     cancelButtonTitle:[loginOptions objectAtIndex:11]
                                     otherButtonTitles:nil];
        [alertForTest show];
        [alertForTest release];
    }
}

// when press "register" button
- (void)registerPressed:(id)sender{
    #ifdef DEBUG
    NSLog(@"register pressed");
    #endif
    // only for test. Please replace the content here
    UIAlertView *alertForTest = [[UIAlertView alloc]
                                 initWithTitle:@"want to register?"
                                 message:@"Comming soooooon!"
                                 delegate:self
                                 cancelButtonTitle:@"Fine"
                                 otherButtonTitles:nil];
    [alertForTest show];
    [alertForTest release];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    // choose "just login" button
    if (buttonIndex == [actionSheet cancelButtonIndex])
    {
        NSString *loginType = [[NSString alloc] initWithFormat:@"justLogin"];
        [self startLogin:self loginType:loginType];
        [loginType release];
    }
    // choose "aoto login" button
    else if(buttonIndex == [actionSheet destructiveButtonIndex])
    {
        NSString *loginType = [[NSString alloc] initWithFormat:@"autoLogin"];
        [self startLogin:self loginType:loginType];
        [loginType release];
    }
    // choose "remember password" button
    else{
        NSString *loginType = [[NSString alloc] initWithFormat:@"justLogin"];
        [self startLogin:self loginType:loginType];
        [loginType release];
    }
}

// start to login when press related button
- (void)startLogin:(id)sender loginType:(NSString *)loginType{
    #ifdef DEBUG
    NSLog(@"startLogin");
    #endif
    
    [self.userConfigKeys replaceObjectAtIndex:2 withObject: loginType];
    
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
    // write user's info & config to UserConfig.plist
    NSString *path = @"/UserConfig.plist";  // location: system/
    [self.userConfigKeys writeToFile:path atomically:YES];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hudPara {
	[hud removeFromSuperview];  
/*
 是HUD在自己的绘制工作结束的时候，会去调用一个Delegate，在那个时候，清除hud对象就已经是安全的了
反正也显示完了，没必要等程序结束的时候再释放
*/
	[hud release];
}
@end
