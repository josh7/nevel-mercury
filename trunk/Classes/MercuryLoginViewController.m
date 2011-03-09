//
//  MercuryLoginViewController.m
//  Mercury
//
//  Created by puretears on 3/6/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import "MercuryLoginViewController.h"
#import "LoginTableCell.h"


@implementation MercuryLoginViewController

@synthesize bgImageView;
@synthesize loginControlLayer;
@synthesize loginField;
@synthesize loginLabel;
@synthesize passwordField;
@synthesize passwordLabel;
@synthesize loginTableView;
@synthesize uiDictionary;
@synthesize uiKeys;


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
	scrollup = 0;
	
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
	[self.view addSubview:self.bgImageView];
	
	// Create an additional layer to hold login controls.
	UIView *loginControlLayerTemp = [[UIView alloc] initWithFrame:viewRect];
	self.loginControlLayer = loginControlLayerTemp;
	self.loginControlLayer.backgroundColor = [UIColor colorWithRed:0.000 
															 green:0.000 
															  blue:0.000 
															 alpha:0.300];
	
	[loginControlLayerTemp release];
	[self.view addSubview:self.loginControlLayer];
	
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
	
	// The login button.
	UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	loginButton.frame = CGRectMake(205, 380, 105, 37);
	loginButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	loginButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	[loginButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
	[loginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
	[loginButton setTitle:@"Login" forState:UIControlStateNormal];
	loginButton.titleLabel.font	= [UIFont boldSystemFontOfSize:16.0f];
	loginButton.alpha = 0;
	[loginButton addTarget:self 
					action:@selector(loginPressed:) 
		  forControlEvents:UIControlEventTouchUpInside];
	[self.loginControlLayer addSubview:loginButton];
	
	[UIView animateWithDuration:1.0 animations:^{
		self.loginTableView.alpha = 1.0;
		loginButton.alpha = 1.0;
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
	[loginField	release];
	[loginLabel release];
	[passwordField release];
	[passwordLabel release];
	
    [super dealloc];
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
		// Set the delegate to make the tableview scroll up & down when the textfields are tapped.
		[cell.loginTextField setDelegate:self];
		[cell.loginTextField addTarget:self
								action:@selector(textFieldDone:) 
					  forControlEvents:UIControlEventEditingDidEndOnExit];
		
		NSString *key = @"Login";
		NSArray *loginSection = [uiDictionary objectForKey:key];
		cell.loginLabel.text = [loginSection objectAtIndex:row];
		
		// Set the password textField attribute.
		if (row == 1) {
			[cell.loginTextField setSecureTextEntry:YES];
			
		}
		
	}

	return cell;
}

#pragma mark -
#pragma mark UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
	if (scrollup == 0) {
		CGPoint newPosition = self.loginControlLayer.center;
		newPosition.y -= 180;
	
		[UIView animateWithDuration:0.25 animations:^ {
			self.loginControlLayer.center = newPosition;
		}];
		scrollup = 1;
	}
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	CGPoint newPosition = self.loginControlLayer.center;
	newPosition.y += 180;
	
	[UIView animateWithDuration:0.25 animations:^ {
		self.loginControlLayer.center = newPosition;
	}];
	scrollup = 0;
	[textField resignFirstResponder];
	return YES;
}

#pragma mark -
#pragma mark UIButton method
- (void)loginPressed:(id)sender {
	
}

@end
