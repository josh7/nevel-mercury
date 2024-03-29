//
//  UIContent.h
//  Mercury
//
//  Created by Jeffrey on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/* +------------------------------ Our UI.plist content --------------------------+ */
// The Login section Englishi version text.
#define LI_EN_ID                0
#define LI_EN_PASSWORD          1
#define LI_EN_REGISTER          2
#define LI_EN_LOGIN             3
#define LI_EN_PREVIOUS          4
#define LI_EN_NEXT              5
#define LI_EN_SERVICE_NAME      6
#define LI_EN_ID_HOLDER         7
#define LI_EN_PASSWORD_HOLDER   8
#define LI_EN_ALERT_TITLE       9
#define LI_EN_ALERT_CONTENT     10
#define LI_EN_ALERT_BUTTON      11
#define LI_EN_LOADING_MESSAGE   12
#define LI_EN_UPDATING_MESSAGE  13

// The Mainboard section English version text.
#define MB_EN_DOMAIN_LIST       0
#define MB_EN_ACCOUNT           1
#define MB_EN_SETTINGS          2
#define MB_EN_HELP              3

// The Domain List section English version text.
#define DL_EN_NEVEL_POWERED     0
#define DL_EN_SECURITY_LOGS     1
#define DL_EN_ALERTS            2

// The Site List English version text.
#define SL_EN_SETTINGS          0
#define SL_EN_DONE              1

// The Site section English version text.


// The Site Settings section English version text.
#define SECTION_ITEMS         0
#define SS_EN_ENABLE_NEVEL      0
#define SS_EN_HIGH_SECURITY     1
#define SS_EN_CACHE_DYNAMIC     2
#define SS_EN_WAF_SECURITY      3
#define SS_EN_EMAIL_OBFUSCATION 4
#define SS_EN_ALWAYS_ONLINE     5
#define SS_EN_HOTLINK           6   
#define SS_EN_PURGE_CACHE       7
#define SS_EN_DELETE            1
#define SS_EN_ALERT             2
#define SS_EN_DISABLE_NEVEL_MSG 3
#define SS_EN_PURGE_CACHE_MSG   4
#define SS_EN_DELETE_MSG        5  
#define SS_EN_YES               6
#define SS_EN_NO                7

// The Settings section English version text.
#define SECTION_NETWORKS      0
#define ST_EN_NOTIFICATIONS     0
#define ST_EN_WIFI_ONLY         1
#define ST_EN_SEND_REPORT       2

#define SECTION_EXTERNAL      1
#define ST_EN_SOUND_ALERT       0
#define ST_EN_VIBRATOR_ALERT    1
#define ST_EN_THEME             2

#define SECTION_ABOUT         2
#define ST_EN_VERSION           0

#define SECTION_REPORT        3
#define ST_EN_ALWAYS            0
#define ST_EN_ASK               1
#define ST_EN_NEVER             2

#define SECTION_THEME         4
#define ST_EN_NEVEL_CLASSIC     0
#define ST_EN_BLACKHOLE         1

#define SECTION_COPYRIGHT     5
#define ST_EN_VERSION_NO        0
#define ST_EN_COPYRIGHT         1
#define ST_EN_FOR_FUN           2

// The Account List section English version text.
#define AC_EN_ACCOUNT_LIST      0
#define AC_EN_MESSAGE           1
#define AC_EN_CANCEL            2
#define AC_EN_SURE              3
#define AC_EN_ACCOUNT_SETTINGS  4

// The Account Settings section English version text.
#define SECTION_ACCOUNT_NAME  0
#define AS_EN_ACCOUNT_NAME      0
#define SECTION_ACCOUNT_TYPE  1
#define AS_EN_ACCOUNT_TYPE      0
#define SECTION_HEADE         2
#define AS_EN_HEADER_NAME       0
#define AS_EN_HEADER_FREE_TYPE  1
#define AS_EN_LOG_OUT         3
#define AS_EN_ADVANCED        4
#define AS_EN_FOOTER_ADVANCED 5

/* +--------------------------- End of our UI.plist content ----------------------+ */

/* +------------------------------- The images we needs --------------------------+ */
#define arrowDown @"arrowDown.PNG"
#define iconAlert @"iconAlert.png"
#define iconSafe @"iconSafe.png"
#define cellBackground @"domainCell.PNG"
#define blueAccessory @"arrow.png"
#define MainboardTabbarView @"nevel_icon.png"
#define themeNevelClassic @"theme_NevelClassic.png"
#define unselectImage @"unselected.PNG"
#define selectImage @"selected.PNG"
#define loginBg @"Default.png"
#define loginLogo @"nevelLogoWhite.png"
/* +------------------------- End of the domain list subview ---------------------+ */

/* +----------------------------- The font & size we used ------------------------+ */
#define subFont         @"Verdana"
#define miniFontSize    12
#define smallFontSize   14
#define normalFontSize  17
#define largeFontSize   24
#define headerFontSize  12.0f
#define headerHeight    25.0f
/* +------------------------- End of the font & size we used ---------------------+ */

/* +--------------------------------- About cell size ----------------------------+ */
#define largeCellHeight 100
#define cellContentWidth 300
#define controllersInCell 196, 8, 94, 27
/* +----------------------------- End of about cell size -------------------------+ */

@interface UIContent : NSObject {
    // For UI Text (we use a plist here for International purpose).
    NSMutableDictionary *uiDictionary;
	NSArray *uiLoginKeys;
    NSArray *uiMainboardKeys;
    NSMutableArray *uiSettingsKeys;
    NSArray *uiAccountListKeys;
    NSArray *uiAccountSettingsKeys;
    NSArray *uiDomainListKeys;
    NSArray *uiSiteListKeys;
    NSArray *uiSiteKeys;
    NSArray *uiSiteSettingsKeys;
}

@property (nonatomic, retain) NSMutableDictionary *uiDictionary;
@property (nonatomic, retain) NSArray *uiLoginKeys;
@property (nonatomic, retain) NSArray *uiMainboardKeys;
@property (nonatomic, retain) NSMutableArray *uiSettingsKeys;
@property (nonatomic, retain) NSArray *uiAccountListKeys;
@property (nonatomic, retain) NSArray *uiAccountSettingsKeys;
@property (nonatomic, retain) NSArray *uiDomainListKeys;
@property (nonatomic, retain) NSArray *uiSiteListKeys;
@property (nonatomic, retain) NSArray *uiSiteKeys;
@property (nonatomic, retain) NSArray *uiSiteSettingsKeys;

- (void)initWithUIContent;

@end
