//
//  UIContent.m
//  Mercury
//
//  Created by Jeffrey on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UIContent.h"


@implementation UIContent
@synthesize uiDictionary;
@synthesize uiLoginKeys;
@synthesize uiMainboardKeys;
@synthesize uiSettingsKeys;

- (void)dealloc {
    [uiDictionary release];
	[uiLoginKeys release];
    [uiMainboardKeys release];
    [uiSettingsKeys release];
    [super dealloc];
}


- (void)initWithUIContent{
    // Read the UI.plist
	NSMutableDictionary *uiDictionaryTemp = [[NSMutableDictionary alloc] initWithContentsOfFile:
                                             [[NSBundle mainBundle] pathForResource:@"UI" 
                                                                             ofType:@"plist"]];
	self.uiDictionary = uiDictionaryTemp;
	[uiDictionaryTemp release];
	
    self.uiLoginKeys = [uiDictionary objectForKey:@"Login"];
	self.uiMainboardKeys = [uiDictionary objectForKey:@"Mainboard"];
    self.uiSettingsKeys = [uiDictionary objectForKey:@"Settings"];
}


@end
