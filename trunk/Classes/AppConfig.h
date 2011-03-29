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

// Methods getting app configurations.
/*- (NSInteger) iLoginType;
- (BOOL) bNotification;
- (BOOL) bWifiOnly;
- (BOOL) bSoundAlert;
- (BOOL) bVibratorAlert;
- (NSInteger) iSendCrashReport;
- (NSInteger) iTheme;*/

// Private accessory method, used by AppConfig class only.
- (void) configFilePath;
- (void) createConfigDictionary;
- (void) writeConfigToFile;
@end
