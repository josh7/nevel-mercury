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

// The Settings section English version text.
#define SECTION_NETWORKS      0
#define ST_EN_NOTIFICATIONS     0
#define ST_EN_WIFI_ONLY         1
#define ST_EN_SEND_REPORT       2

#define SECTION_EXTERNAL      1
#define ST_EN_SOUND_ALERT       0
#define ST_EN_VIBRATOR_ALERT    1
#define ST_EN_THEME             2

#define SECTION_ACCOUNT       2
#define ST_EN_CURRENT_ACCOUNT   0

#define SECTION_ABOUT           3
#define ST_EN_VERSION           0

#define SECTION_REPORT        4
#define ST_EN_ALWAYS            0
#define ST_EN_ASK               1
#define ST_EN_NEVER             2

#define SECTION_THEME         5
#define ST_EN_NEVEL_CLASSIC     0
#define ST_EN_BLACKHOLE         1

#define SECTION_COPYRIGHT     6
#define ST_EN_VERSION_NO        0
#define ST_EN_COPYRIGHT         1
#define ST_EN_FOR_FUN           2

// The Account section English version text.
#define AC_EN_ACCOUNT_LIST      0
#define AC_EN_MESSAGE           1
#define AC_EN_CANCEL            2
#define AC_EN_SURE              3
#define AC_EN_ACCOUNT_SETTINGS  4
#define AC_EN_ACCOUNT_NAME      5
#define AC_EN_SAVE_PASSWORD     6
#define AC_EN_AUTO_LOGIN        7
#define AC_EN_LOG_OUT           8


@interface UIContent : NSObject {
    // For UI Text (we use a plist here for International purpose).
    NSMutableDictionary *uiDictionary;
	NSArray *uiLoginKeys;
    NSArray *uiMainboardKeys;
    NSMutableArray *uiSettingsKeys;
    NSArray *uiAccountKeys;
}

@property (nonatomic, retain) NSMutableDictionary *uiDictionary;
@property (nonatomic, retain) NSArray *uiLoginKeys;
@property (nonatomic, retain) NSArray *uiMainboardKeys;
@property (nonatomic, retain) NSMutableArray *uiSettingsKeys;
@property (nonatomic, retain) NSArray *uiAccountKeys;

- (void)initWithUIContent;

@end
