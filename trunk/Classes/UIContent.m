//
//  UIContent.m
//  Mercury
//
//  Created by Jeffrey on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UIContent.h"
// The UI file information.
#define UI_FILE_NAME    @"UI"
#define UI_FILE_TYPE    @"plist"
// The first level titles of UI.plist.
#define LOGIN           @"Login"
#define MAINBOARD       @"Mainboard"
#define SETTINGS        @"Settings"
#define ACCOUNT         @"Account"


@implementation UIContent
@synthesize uiDictionary;
@synthesize uiLoginKeys;
@synthesize uiMainboardKeys;
@synthesize uiSettingsKeys;
@synthesize uiAccountKeys;

- (void)dealloc {
    [uiDictionary release];
	[uiLoginKeys release];
    [uiMainboardKeys release];
    [uiSettingsKeys release];
    [uiAccountKeys release];
    [super dealloc];
}


- (void)initWithUIContent{
    // Read the UI.plist
	NSMutableDictionary *uiDictionaryTemp = [[NSMutableDictionary alloc] initWithContentsOfFile:
                                             [[NSBundle mainBundle] pathForResource:UI_FILE_NAME 
                                                                             ofType:UI_FILE_TYPE]];
	self.uiDictionary = uiDictionaryTemp;
	[uiDictionaryTemp release];
	
    self.uiLoginKeys = [uiDictionary objectForKey:LOGIN];
	self.uiMainboardKeys = [uiDictionary objectForKey:MAINBOARD];
    self.uiSettingsKeys = [uiDictionary objectForKey:SETTINGS];
    self.uiAccountKeys = [uiDictionary objectForKey:ACCOUNT];
}


@end
