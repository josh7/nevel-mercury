//
//  UIContent.h
//  Mercury
//
//  Created by Jeffrey on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MB_EN_SITESLIST 0
#define MB_EN_SETTING   1

@interface UIContent : NSObject {
    // For UI Text (we use a plist here for International purpose.)
    NSDictionary *uiDictionary;
	NSArray *uiLoginKeys;
    NSArray *uiMainboardKeys;
}
@property (nonatomic, retain) NSDictionary *uiDictionary;
@property (nonatomic, retain) NSArray *uiLoginKeys;
@property (nonatomic, retain) NSArray *uiMainboardKeys;

- (void)initWithUIContent;

@end
