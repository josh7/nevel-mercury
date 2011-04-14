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
}

- (void)initWithFile:(NSString *)fileName;
- (void)parseXML;

@end
