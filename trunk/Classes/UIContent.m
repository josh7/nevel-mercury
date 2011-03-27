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

- (void)initWithUIContent{
    // read the UI.plist
	NSDictionary *uiDictionaryTemp = [[NSDictionary alloc] initWithContentsOfFile:
                                      [[NSBundle mainBundle] pathForResource:@"UI" 
                                                                      ofType:@"plist"]];
	self.uiDictionary = uiDictionaryTemp;
	[uiDictionaryTemp release];
	
    self.uiLoginKeys = [uiDictionary objectForKey:@"Login"];
	self.uiMainboardKeys = [uiDictionary objectForKey:@"Mainboard"];
}

- (void)dealloc {
    [uiDictionary release];
	[uiLoginKeys release];
    [uiMainboardKeys release];
    [super dealloc];
}
@end
