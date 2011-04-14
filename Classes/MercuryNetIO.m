//
//  MercuryNetIO.m
//  Mercury
//
//  Created by puretears on 4/11/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import "MercuryNetIO.h"

#define SITELISTXML @"SiteList.xml"

@implementation MercuryNetIO
@synthesize request;

- (void)dealloc {
    [request cancel];
    [request release];
    [super dealloc];
}

- (void)networkQueue {
    if (siteMetadataQueue == nil) {
        siteMetadataQueue = [[ASINetworkQueue alloc] init];
    }
    
    // Initialize the Download queue.
    [siteMetadataQueue reset];
    // TODO: Add a progress indicator here.
    [siteMetadataQueue setRequestDidFinishSelector:@selector(metaDataFetchComplete:)];
    [siteMetadataQueue setRequestDidFailSelector:@selector(metaDataFetchFailed:)];
    [siteMetadataQueue setDelegate:self];
    
    // Get the xml URL of site list.
    NSString *siteListXMLFetchURL = [[NSBundle mainBundle] pathForResource:@"SiteList" 
                                                                    ofType:@"plist"];
    NSMutableDictionary *siteListXMLTemp = 
    [[NSMutableDictionary alloc] initWithContentsOfFile:siteListXMLFetchURL];
    NSString *siteListXMLPath = [siteListXMLTemp objectForKey:@"SiteListURL"];
	NSURL *siteListXMLURL = [NSURL URLWithString:siteListXMLPath];
    
    request  = [ASIHTTPRequest requestWithURL:siteListXMLURL];
    NSString *fetchDestination = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] 
                                  stringByAppendingPathComponent:SITELISTXML];
    [request setDownloadDestinationPath:fetchDestination];
    [siteMetadataQueue addOperation:request];
    
    // Fetch the SiteList.xml
    [siteMetadataQueue go];

}

- (void)setURLFromPlist:(NSString *)fileName URLKey:(NSString *)key {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSMutableDictionary *urlDictionary = 
        [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    NSString *urlString = [urlDictionary objectForKey:key];
    fetchURL = [NSURL URLWithString:urlString];
}

- (BOOL)syncFetch:(NSString *)destinationFileName {
    request = [ASIHTTPRequest requestWithURL:fetchURL];
    NSString *fetchDestination = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] 
                                  stringByAppendingPathComponent:destinationFileName];
    [request setDownloadDestinationPath:fetchDestination];
    [request startSynchronous];
    
    NSError *downLoadError = [request error];
    if (downLoadError) {
#ifdef DEBUG
        NSLog(@"Download %@ failed due to: %@", destinationFileName,[request responseString]);
#endif
        return NO;
    }
#ifdef DEBUG
    NSLog(@"Download %@ successful.", destinationFileName);
#endif
    return YES;
}


@end
