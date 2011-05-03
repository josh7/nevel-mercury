//
//  XMLParser.m
//  Mercury
//
//  Created by puretears on 4/11/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import "XMLParser.h"
#define kXML @"//sitelist"

@implementation XMLParser
@synthesize siteNames;


- (void)initWithFile:(NSString *)fileName {
    xmlFilePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] 
                                  stringByAppendingPathComponent:fileName];
    NSData *data = [[NSData alloc] initWithContentsOfFile:xmlFilePath];
    xmlDocument = [[DDXMLDocument alloc] initWithData:data options:0 error:0];
}

- (void)parseSiteName {
    //NSArray *items = [xmlDocument nodesForXPath:kXML error:nil];
    NSError *err = nil;
    NSArray *ddArray1 = [xmlDocument nodesForXPath:@"sitelist/site/name" error:&err];
#ifdef DEBUG
    NSLog(@"%d sites.", [ddArray1 count]);
    
    for (int i = 0; i < [ddArray1 count]; i++) {
        NSLog(@"SiteName: %@", [[ddArray1 objectAtIndex:i] stringValue]);
    }
#endif
    self.siteNames = ddArray1;
}


- (void)parseMonitoring:(NSString *)siteName {
    NSError *err = nil;
    NSArray *ddArray = [xmlDocument nodesForXPath:@"xml/site" error:&err];
}


@end
