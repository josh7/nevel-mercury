//
//  AppConfig.m
//  Mercury
//
//  Created by puretears on 11-3-25.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AppConfig.h"

#define kNotification	0
#define kWifiOnly		1
#define kSoundAlert		2
#define kVibratorAlert	3
#define kNumberSwitches	4

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
    const char *test = [fullFilePath cStringUsingEncoding:NSASCIIStringEncoding];
    fullFilePath_CF = CFStringCreateWithCString(kCFAllocatorDefault, test, NSASCIIStringEncoding);
}

- (void) createConfigDictionary {
	// Create a dictionary that will hold all configuration data.
	configDic = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, 
										  &kCFTypeDictionaryKeyCallBacks, 
										  &kCFTypeDictionaryValueCallBacks);
	// Put various items into the dictionary.
	// The login method.
	int loginSelectionDefault = 0;
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
    int defaultPickerVal = 0;
	CFNumberRef mainPickerSettingsDefault[kNumberPickers];
	mainPickerSettingsDefault[kSendCrashReport] = 
        CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &defaultPickerVal);
	mainPickerSettingsDefault[kTheme] = 
        CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &defaultPickerVal); 
	CFArrayRef mainPickerSettings = CFArrayCreate(kCFAllocatorDefault,
									(const void **)mainPickerSettingsDefault,
									kNumberPickers,
									&kCFTypeArrayCallBacks);
	CFDictionarySetValue(configDic, CFSTR("mainPickerSettings"), mainPickerSettings);
	CFRelease(mainPickerSettings);
}

- (void)writeConfigToFile {
    configFileURL = 
        CFURLCreateWithFileSystemPath(nil, fullFilePath_CF,  kCFURLPOSIXPathStyle, false);
	// Convert the property list to xml data.
    CFPropertyListRef propertyList = configDic;
	CFDataRef xmlData = 
        CFPropertyListCreateData(kCFAllocatorDefault, 
                                 propertyList, 
                                 kCFPropertyListXMLFormat_v1_0, 0, NULL);
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
    
	if (![[NSFileManager defaultManager] fileExistsAtPath:(NSString *)fullFilePath_CF]) {
		// Create and initialize the config file.
		[self createConfigDictionary];	
		[self writeConfigToFile];
	}
}


- (void)dealloc {
	CFRelease(configDic);
	CFRelease(configFileURL);
    [super dealloc];
}


@end
