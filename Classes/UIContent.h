//
//  UIContent.h
//  Mercury
//
//  Created by Jeffrey on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// The Login section Englishi version text.
#define LI_EN_ID                0
#define LI_EN_PASSWORD          1
#define LI_EN_REGISTER          2
#define LI_EN_LOGIN             3
#define LI_EN_JUST_LOGIN        4
#define LI_EN_AUTO_LOGIN        5
#define LI_EN_SAVE_PASSWORD     6
#define LI_EN_ID_HODER          7
#define LI_EN_PASSWORD_HODER    8
#define LI_EN_ALERT_TITLE       9
#define LI_EN_ALERT_CONTENT     10
#define LI_EN_ALERT_BUTTON      11
#define LI_EN_LOADING_MESSAGE   12
#define LI_EN_UPDATING_MESSAGE  13

// The Mainboard section English version text.
#define MB_EN_SITESLIST         0
#define MB_EN_SETTING           1

@interface UIContent : NSObject {
    // For UI Text (we use a plist here for International purpose).
    NSDictionary *uiDictionary;
	NSArray *uiLoginKeys;
    NSArray *uiMainboardKeys;
}

@property (nonatomic, retain) NSDictionary *uiDictionary;
@property (nonatomic, retain) NSArray *uiLoginKeys;
@property (nonatomic, retain) NSArray *uiMainboardKeys;

- (void)initWithUIContent;

@end
