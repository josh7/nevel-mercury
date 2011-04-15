//
//  XMLParser.h
//  Mercury
//
//  Created by puretears on 4/11/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDXML.h"
#import "DDXMLElementAdditions.h"

@interface XMLParser : NSObject {
    NSString *xmlFilePath;
    DDXMLDocument *xmlDocument;
    NSArray *siteNames;
}

@property (nonatomic, retain) NSArray *siteNames;

- (void)initWithFile:(NSString *)fileName;
- (void)parseSiteName;
- (void)parseMonitoring:(NSString *)siteName;

@end
