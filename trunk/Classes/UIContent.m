//
//  UIContent.m
//  Mercury
//
//  Created by Jeffrey on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UIContent.h"
// The UI file information.
#define UI_FILE_NAME        @"UI"
#define UI_FILE_TYPE        @"plist"
// The first level titles of UI.plist.
#define LOGIN               @"Login"
#define MAINBOARD           @"Mainboard"
#define SETTINGS            @"Settings"
#define ACCOUNT_LIST        @"Account List"
#define ACCOUNT_SETTINGS    @"Account Settings"
#define DOMAIN_LIST         @"Domain List"
#define SITE_LIST           @"Site List"
#define SITE                @"Site"
#define SITE_SETTINGS       @"Site Settings"


@implementation UIContent
@synthesize uiDictionary;
@synthesize uiLoginKeys;
@synthesize uiMainboardKeys;
@synthesize uiSettingsKeys;
@synthesize uiAccountListKeys;
@synthesize uiAccountSettingsKeys;
@synthesize uiDomainListKeys;
@synthesize uiSiteListKeys;
@synthesize uiSiteKeys;
@synthesize uiSiteSettingsKeys;

- (void)dealloc {
    [uiDictionary release];
	[uiLoginKeys release];
    [uiMainboardKeys release];
    [uiSettingsKeys release];
    [uiAccountListKeys release];
    [uiAccountSettingsKeys release];
    [uiDomainListKeys release];
    [uiSiteListKeys release];
    [uiSiteKeys release];
    [uiSiteSettingsKeys release];
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
    self.uiAccountListKeys = [uiDictionary objectForKey:ACCOUNT_LIST];
    self.uiAccountSettingsKeys = [uiDictionary objectForKey:ACCOUNT_SETTINGS];
    self.uiDomainListKeys = [uiDictionary objectForKey:DOMAIN_LIST];
    self.uiSiteListKeys = [uiDictionary objectForKey:SITE_LIST];
    self.uiSiteSettingsKeys = [uiDictionary objectForKey:SITE_SETTINGS];
    self.uiSiteKeys = [uiDictionary objectForKey:SITE];
}


@end
