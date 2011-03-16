//
//  MercuryLoginViewController.h
//  Mercury
//
//  Created by puretears on 3/6/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <unistd.h>  // For sleep function.
#import <QuartzCore/QuartzCore.h>   // For CATransition methods.
#import "MBProgressHUD.h"
#import "MercuryMainboardViewController.h"

// We subclass from the UITableViewController so we can use the embeded UITableView object.
@interface MercuryLoginViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
	// The UI controls.
	UIImageView *bgImageView;
	UIView *loginControlLayer;
	UITableView *loginTableView;
    
    MercuryMainboardViewController *mainboardViewController;
	
	// For UI Text (we use a plist here for International purpose.)
	NSDictionary *uiDictionary;
	NSArray *uiKeys;
		
	// The scroll up flag.  // bySu: what is it for?
	int scrollup;
	
	MBProgressHUD *hud;
}

@property (nonatomic, retain) UIImageView *bgImageView;
@property (nonatomic, retain) UIView *loginControlLayer;
@property (nonatomic, retain) UITableView *loginTableView;
@property (nonatomic, retain) MercuryMainboardViewController *mainboardViewController;
@property (nonatomic, retain) NSDictionary *uiDictionary;
@property (nonatomic, retain) NSArray *uiKeys;
@property (nonatomic, retain) MBProgressHUD *hud;


- (void)loginPressed:(id)sender;
- (void)showUsingBlocks:(id)sender;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (void)loadingTask;

@end
