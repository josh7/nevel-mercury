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

#define nevelIdTextField 0
#define passwordTextField 1


// We subclass from the UITableViewController so we can use the embeded UITableView object.
@interface MercuryLoginViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIActionSheetDelegate> {
	// The UI controls.
	UIImageView *bgImageView;
    UIImageView *logoImageView;
//	UIView *loginControlLayer;
   	UIControl *loginControlLayer;
	UITableView *loginTableView;
    
    MercuryMainboardViewController *mainboardViewController;
	
	// For UI Text (we use a plist here for International purpose.)
	NSDictionary *uiDictionary;
	NSArray *uiKeys;
    
    // for UserConfig.plist
    NSMutableArray *userConfigKeys;
	
	// The scroll up flag. 
	int scrollup;
	
	MBProgressHUD *hud;
}

@property (nonatomic, retain) UIImageView *bgImageView;
@property (nonatomic, retain) UIImageView *logoImageView;
//@property (nonatomic, retain) UIView *loginControlLayer;
@property (nonatomic, retain) UIControl *loginControlLayer;
@property (nonatomic, retain) UITableView *loginTableView;
@property (nonatomic, retain) MercuryMainboardViewController *mainboardViewController;
@property (nonatomic, retain) NSDictionary *uiDictionary;
@property (nonatomic, retain) NSArray *uiKeys;
@property (nonatomic, retain) NSMutableArray *userConfigKeys;
@property (nonatomic, retain) MBProgressHUD *hud;

- (void)loginPressed:(id)sender;
- (void)showUsingBlocks:(id)sender;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (void)loadingTask;
- (void)backgroundPressed:(id)sender;
- (void)startLogin:(id)sender;
- (void)idTextFieldPressed:(UITextField *)sender;
- (void)passwordTextFieldPressed:(UITextField *)sender;
- (void)idTextFieldPressedBeforeEditing:(UITextField *)sender;
- (void)passwordTextFieldPressedBeforeEditing:(UITextField *)sender;

@end