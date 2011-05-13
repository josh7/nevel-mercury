//
//  AppConfig.m
//  Mercury
//
//  Created by puretears on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AppConfig.h"


@implementation AppConfig

- (void)dealloc {
    CFRelease(fullFilePath_CF);
	CFRelease(configDic);
	CFRelease(configFileURL);
    [super dealloc];
}


- (void)configFilePath {
	// Set file path to application sandbox Documents directory.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
														 NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *fullFilePath = 
    [documentsDirectory stringByAppendingPathComponent:kConfigFileName];
    const char *test = [fullFilePath cStringUsingEncoding:NSASCIIStringEncoding];
    fullFilePath_CF = CFStringCreateWithCString(kCFAllocatorDefault, 
                                                test, 
                                                NSASCIIStringEncoding);
}


- (void) createConfigDictionary {
	// Create a dictionary that will hold all configuration data.
	configDic = CFDictionaryCreateMutable(kCFAllocatorDefault, 
                                          0, 
										  &kCFTypeDictionaryKeyCallBacks, 
										  &kCFTypeDictionaryValueCallBacks);
    
    /* +----------------- Put various items into the dictionary --------------------+ */
        
	/* +---------- The main switch settings collection ----------+ */
    // Notification on/off.
    CFBooleanRef notificationDefault = kCFBooleanTrue;
    CFDictionarySetValue(configDic, CFSTR("mainSwitchNotification"), notificationDefault);
    
    // Wifi only on/off.
    CFBooleanRef wifiOnlyDefault = kCFBooleanFalse;
    CFDictionarySetValue(configDic, CFSTR("mainSwitchWifiOnly"), wifiOnlyDefault);
    
    // Sound alert on/off.
    CFBooleanRef soundAlertDefault = kCFBooleanTrue;
    CFDictionarySetValue(configDic, CFSTR("mainSwitchSoundAlert"), soundAlertDefault);
    
    // Vibrator alert on/off.
    CFBooleanRef vibratorAlertDefault = kCFBooleanFalse;
    CFDictionarySetValue(configDic, CFSTR("mainSwitchVibratorAlert"), vibratorAlertDefault);
    
    /* +------ End of the main switch settings collection -------+ */
    
    /* +---------- The main picker settings collection ----------+ */
	// Crash report sending type.
    int crashReportSendingTypeDefault = 0;
	CFNumberRef sendingType = CFNumberCreate(kCFAllocatorDefault, 
                                             kCFNumberIntType, 
                                             &crashReportSendingTypeDefault);
	CFDictionarySetValue(configDic, CFSTR("mainPickerSendCrashReport"), sendingType);
	CFRelease(sendingType);
    
    // Theme type.
    int themeTypeDefault = 0;
	CFNumberRef themeType = CFNumberCreate(kCFAllocatorDefault, 
                                           kCFNumberIntType, 
                                           &themeTypeDefault);
	CFDictionarySetValue(configDic, CFSTR("mainPickerTheme"), themeType);
	CFRelease(themeType);
    /* +------ End of the main picker settings collection -------+ */
    
    /* +-------------- End of put various items into the dictionary ----------------+ */
}


- (void)writeConfigToFile {
    configFileURL = 
    CFURLCreateWithFileSystemPath(nil, fullFilePath_CF,  kCFURLPOSIXPathStyle, false);
	// Convert the property list to xml data.
    CFPropertyListRef propertyList = configDic;
	CFDataRef xmlData = 
    CFPropertyListCreateData(kCFAllocatorDefault, 
                             propertyList, 
                             kCFPropertyListXMLFormat_v1_0, 
                             0, 
                             NULL);
	// Write the XML data to the file.
	SInt32 errorCode;
	Boolean status = 
    CFURLWriteDataAndPropertiesToResource(configFileURL, xmlData, NULL, &errorCode);
    
    if (status == false) {
#ifdef DEBUG
        NSLog(@"Save configuration failed.");
#endif
        return;
    }
	CFRelease(xmlData);
}


- (void)initWithAppConfig {
    [self configFilePath];
    
#ifdef DEBUG_CONFIGFILE        
    // This is debug mode. Each time the app runs, we remove the config file created last time.
    if ([[NSFileManager defaultManager] fileExistsAtPath:(NSString *)fullFilePath_CF]) {
        [[NSFileManager defaultManager] removeItemAtPath:(NSString *)fullFilePath_CF
                                                   error:NULL];
	}
#endif 
    
	if (![[NSFileManager defaultManager] fileExistsAtPath:(NSString *)fullFilePath_CF]) {       
		// Create and initialize the config file.
		[self createConfigDictionary];	
		[self writeConfigToFile];
	}
}


#pragma mark - app config methods
/* +------------- Setting the configurations with user's choices ---------------+ */

// Notification on/off.
- (void) setNotificationType:(BOOL)bNotification {
    CFBooleanRef cfConfigTemp;
    if (bNotification == YES) {
        cfConfigTemp = kCFBooleanTrue;
    }
    else {
        cfConfigTemp = kCFBooleanFalse;
    }
    CFDictionarySetValue(configDic, CFSTR("mainSwitchNotification"), cfConfigTemp);
}


// Wifi only on/off.
- (void) setWifiOnlyType:(BOOL)bWifiOnly {
    CFBooleanRef cfConfigTemp;
    if (bWifiOnly == YES) {
        cfConfigTemp = kCFBooleanTrue;
    }
    else {
        cfConfigTemp = kCFBooleanFalse;
    }
    CFDictionarySetValue(configDic, CFSTR("mainSwitchWifiOnly"), cfConfigTemp);
}


// Sound alert on/off.
- (void) setSoundAlertType:(BOOL)bSoundAlert {
    CFBooleanRef cfConfigTemp;
    if (bSoundAlert == YES) {
        cfConfigTemp = kCFBooleanTrue;
    }
    else {
        cfConfigTemp = kCFBooleanFalse;
    }
    CFDictionarySetValue(configDic, CFSTR("mainSwitchSoundAlert"), cfConfigTemp);
}


// Vibrator alert on/off.
- (void) setVibratorAlertType:(BOOL)bVibratorAlert {
    CFBooleanRef cfConfigTemp;
    if (bVibratorAlert == YES) {
        cfConfigTemp = kCFBooleanTrue;
    }
    else {
        cfConfigTemp = kCFBooleanFalse;
    }
    CFDictionarySetValue(configDic, CFSTR("mainSwitchVibratorAlert"), cfConfigTemp);
}


// Crash report sending type.
- (void) setCrashReportSendingType:(int)iCrashReportSengdingType {
    CFNumberRef cfConfigTemp = CFNumberCreate(kCFAllocatorDefault, 
                                              kCFNumberIntType, 
                                              &iCrashReportSengdingType);
	CFDictionaryReplaceValue(configDic, CFSTR("mainPickerSendCrashReport"), cfConfigTemp);
	CFRelease(cfConfigTemp);
}


// Theme type.
- (void) setTheme:(int)iThemeType {
    CFNumberRef cfConfigTemp = CFNumberCreate(kCFAllocatorDefault, 
                                              kCFNumberIntType, 
                                              &iThemeType);
	CFDictionaryReplaceValue(configDic, CFSTR("mainPickerTheme"), cfConfigTemp);
	CFRelease(cfConfigTemp);
}
/* +---------- End of setting the configurations with user's choices -----------+ */


@end