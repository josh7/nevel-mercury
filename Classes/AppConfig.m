//
//  AppConfig.m
//  Mercury
//
//  Created by Jeffrey on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UIContent.h"

#define kNotification	0
#define kWifiOnly		1
#define kSoundAlert		2
#define kVibratorAlert	3
#define kNumberSwithes	4

#define kSendCrashReport	0
#define kTheme				1
#define kNumberPickers		2

enum {
	ASK_TO_SEND = 0,
	ALWAYS_TO_SEND = 1,
	NEVER = 2
};

@implementation AppConfig

- (void)configFilePath {
	// Set file path to application sandbox Documents directory.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
														 NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *fullFilePath = 
		[documentsDirectory stringByAppendingPathComponent:kConfigFileName];
	configFileURL = CFURLCreateWithString(kCFAllocatorDefault, 
										 (CFStringRef)fullFilePath, NULL);
}

- (void) createConfigDictionary {
	// Create a dictionary that will hold all configuration data.
	configDic = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, 
										  &kCFTypeDictionaryKeyCallBacks, 
										  &kCFTypeDictionaryValueCallBacks);
	// Put various items into the dictionary.
	// The login method.
	int loginSelectionDefault = 0
	CFNumberRef loginSelection = CFNumberCreate(kCFAllocatorDefault, 
												kCFNumberIntType, 
												&loginSelectionDefault);
	CFDictionarySetValue(configDic, CFSTR("loginMethod"), loginSelection);
	CFRelease(loginSelection);

	// The main swith settings collection.
	CFBooleanRef mainSwitchSettingsDefault[kNumberSwitches];
	mainSwitchSettingsDefault[kNotification] = kCFBooleanTrue;
	mainSwitchSettingsDefault[kWifiOnly] = kCFBooleanFalse;
	mainSwitchSettingsDefault[kSoundAlert] = kCFBooleanTrue;
	mainSwitchSettingsDefault[kVibratorAlert] = kCFBooleanFalse;

	CFArrayRef mainSwitchSettings = CFArrayCreate(kCFAllocatorDefault,
									(const void **)mainSwitchSettingsDefault,
									kNumberSwitches,
									&kCFTypeArrayCallBacks);
	CFDictionarySetValue(configDic, CFSTR("mainSwitchSettings"), mainSwitchSettings);
	CFRelease(mainSwitchSettings);

	// The main picker settings collection.
	unsigned int mainPickerSettingsDefault[kNumberPickers];
	mainPickerSettingsDefault[kSendCrashReport] = ASK_TO_SEND;
	mainPickerSettingsDefault[kTheme] = 0; 
	CFArrayRef mainPickerSettings = CFArrayCreate(kCFAllocatorDefault,
									(const void **)mainPickerSettingsDefault,
									kNumberPickers,
									&kCFTypeArrayCallBacks);
	CFDictionarySetValue(confiDic, CFSTR("mainPickerSettings"), mainPickerSettings);
	CFRelease(mainPickerSettings);
}

- (void)writeConfigToFile(CFPropertyListRef propertyList, CFURLRef fileURL) {
	// Convert the property list to xml data.
	CFDataRef xmlData = CFPropertyListCreateXMLData(kCFAllocatorDefault, propertyList);
	// Write the XML data to the file.
	SInt32 errorCode;
	Boolean status = 
		CFURLWriteDataAndPropertiesToResource(configFileURL, xmlData, NULL, &errorCode);
	CFRelease(xmlData);
}


- (void)initWithAppConfig{
	if (![[NSFileManager defaultManager] fileExistsAtPath:(NSString *)configFileURL]) {
		// Create and initialize the config file.
		createConfigDictionary();	
		configFilePath();
		writeConfigToFile(configDic, configFileURL);
	}
}


- (void)dealloc {
	CFRelease(configDic);
	CFRelease(configFileURL);
    [super dealloc];
}


@end
