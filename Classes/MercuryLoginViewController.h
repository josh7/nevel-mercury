//
//  MercuryLoginViewController.h
//  Mercury
//
//  Created by puretears on 3/6/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import <UIKit/UIKit.h>

// We subclass from the UITableViewController so we can use the embeded UITableView object.
@interface MercuryLoginViewController : 
	UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
	// The UI controls.
	UIImageView *bgImageView;
	UIView *loginControlLayer;
	UITextField *loginField;
	UILabel *loginLabel;
	UITextField *passwordField;
	UILabel *passwordLabel;
	UITableView *loginTableView;
	
	// For UI Text (we use a plist here for International purpose.)
	NSDictionary *uiDictionary;
	NSArray *uiKeys;
		
	// The scroll up flag.	
	int scrollup;
}

@property (nonatomic, retain) UIImageView *bgImageView;
@property (nonatomic, retain) UIView *loginControlLayer;
@property (nonatomic, retain) UITextField *loginField;
@property (nonatomic, retain) UILabel *loginLabel;
@property (nonatomic, retain) UITextField *passwordField;
@property (nonatomic, retain) UILabel *passwordLabel;
@property (nonatomic, retain) UITableView *loginTableView;
@property (nonatomic, retain) NSDictionary *uiDictionary;
@property (nonatomic, retain) NSArray *uiKeys;


- (void)loginPressed:(id)sender;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
@end
