//
//  AppConfig.h
//  Mercury
//
//  Created by puretears on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>

#define kConfigFileName @"UserConfig.plist"
// Login type values.
#define AUTO                0
#define REMEMBER_ACCOUNT    1
#define JUST_LOGIN          2
// Crash report sending type values.
#define ASK                 0
#define ALWAYS              1
#define NEVER               2
// Theme type values.
#define NEVEL_CLASSIC       0

/* XML sample of mercury configuration file.
 *	<plist version="1.0">
 *		<configDic>
 *			<key>loginMethod</key>
 *			<!--Login type selection: auto / remember account / just login -->
 *			<integer>0</integer>
 *			<key>
 *
 *			<key>mainSwithSettings<key>
 *			<array>
 *				<!-- Notification -->
 *				<Boolean>YES</Boolean>
 *				<!-- Wifi Only -->
 *				<Boolean>NO</Boolean>
 *				<!-- Sound Alert -->
 *				<Boolean>YES</Boolean>
 *				<!-- Vibrator Alert -->
 *				<Boolean>NO</Boolean>
 *			</array>
 *
 *			<key>mainPickerSettings</key>
 *			<array>
 *				<!-- Send crash report: Ask / Always / Never-->
 *				<integer>0</integer>
 *				<!-- Theme: Nevel Classic -->
 *				<integer>0</integer>
 *			</array>
 *		</configDic>
 *	</plist>	
 * */

@interface AppConfig : NSObject {
	CFMutableDictionaryRef configDic;
    CFStringRef fullFilePath_CF;
	CFURLRef configFileURL;
}

// Initialization method.
- (void)initWithAppConfig;

// Getting app configurations ethods.
- (void) setLoginType:(int)iloginType;
- (void) setNotificationType:(BOOL)bNotification;
- (void) setWifiOnlyType:(BOOL)bWifiOnly;
- (void) setSoundAlertType:(BOOL)bSoundAlert;
- (void) setVibratorAlertType:(BOOL)bVibratorAlert;
- (void) setCrashReportSendingType:(int)iCrashReportSengdingType;
- (void) setTheme:(int)iThemeType;

// Private accessory method, used by AppConfig class only.
- (void) configFilePath;
- (void) createConfigDictionary;
- (void) writeConfigToFile;

@end
