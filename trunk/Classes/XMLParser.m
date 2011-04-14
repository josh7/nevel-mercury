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

- (void)initWithFile:(NSString *)fileName {
    xmlFilePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] 
                                  stringByAppendingPathComponent:fileName];
    NSData *data = [[NSData alloc] initWithContentsOfFile:xmlFilePath];
    xmlDocument = [[DDXMLDocument alloc] initWithData:data options:0 error:0];
}

- (void)parseXML {
    //NSArray *items = [xmlDocument nodesForXPath:kXML error:nil];
    NSError *err = nil;
    NSArray *ddArray1 = [xmlDocument nodesForXPath:@"SiteMeta/sitelist/name" error:&err];
    NSLog(@"%d sites.", [ddArray1 count]);
    
    for (int i = 0; i < [ddArray1 count]; i++) {
        NSLog(@"SiteName: %@", [[ddArray1 objectAtIndex:i] stringValue]);
    }
}
@end
