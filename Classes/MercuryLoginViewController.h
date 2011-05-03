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
#import "UIContent.h"
#import "AppConfig.h"
#import "XMLParser.h"
#import "MercuryNetIO.h"
#import "SFHFKeychainUtils.h"


// We subclass from the UITableViewController so we can use the embeded UITableView object.
@interface MercuryLoginViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIActionSheetDelegate> {
	// The UI controls.
	UIImageView *bgImageView;
    UIImageView *logoImageView;
   	UIControl *loginControlLayer;   // In order to make the background touchable.
	UITableView *loginTableView;
    UIToolbar *keyboardAccessoryView;  // To hold buttons of "previous/next/login/".
    UIBarButtonItem *doneBarButtonItem;
    UISegmentedControl *segmentBarButtonItem;
    
    // Flag for judging whether the user log out to this login view.
    BOOL didRelogIn;
    
    // For storing user's configuration and writting into UserConfig.plist.
    NSMutableArray *userConfigKeys;
	
	// The scroll up flag. 
	int scrollup;
	
	MBProgressHUD *hud;
    
    // Object for UI text.
    UIContent *loginUIContent;
    
    XMLParser *xmlParser;
    
    MercuryNetIO *mIO; // "miao~~~" :-)
    
    // Our dearest SFHFKeychainUtils object dealing with account name and password.
    SFHFKeychainUtils *keyChainWrapper;
}

@property (nonatomic, retain) UIImageView *bgImageView;
@property (nonatomic, retain) UIImageView *logoImageView;
@property (nonatomic, retain) UIToolbar *keyboardAccessoryView;
@property (nonatomic, retain) UIBarButtonItem *doneBarButtonItem;
@property (nonatomic, retain) UISegmentedControl *segmentBarButtonItem;
@property (nonatomic, retain) UIControl *loginControlLayer;
@property (nonatomic, retain) UITableView *loginTableView;
@property (nonatomic, retain) NSMutableArray *userConfigKeys;
@property (nonatomic, retain) MBProgressHUD *hud;
@property (nonatomic, retain) UIContent *loginUIContent;
@property (nonatomic, retain) XMLParser *xmlParser;
@property BOOL didRelogIn;

// Button pressed.
- (void)loginPressed:(id)sender;

- (void)showUsingBlocks:(id)sender;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (void)loadingTask;
- (void)startLogin:(id)sender;

// Textfield pressed.
- (void)idTextFieldPressed:(UITextField *)sender;
- (void)passwordTextFieldPressed:(UITextField *)sender;
- (void)idTextFieldPressedBeforeEditing:(UITextField *)sender;
- (void)passwordTextFieldPressedBeforeEditing:(UITextField *)sender;

// Segmented control action.
- (void)segmentedControlPressed:(id)sender;

- (void)metaDataFetchComplete:(ASIHTTPRequest *)request;
- (void)metaDataFetchFailed:(ASIHTTPRequest *)request;

@end