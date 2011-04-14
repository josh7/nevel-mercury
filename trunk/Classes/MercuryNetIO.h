//
//  MercuryNetIO.h
//  Mercury
//
//  Created by puretears on 4/11/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"

@interface MercuryNetIO : NSObject {
    ASINetworkQueue *siteMetadataQueue;
    NSURL *fetchURL;
    
    ASINetworkQueue *networkQueue;
    ASIHTTPRequest *request;
}

@property (retain, nonatomic) ASIHTTPRequest *request;
- (void) networkQueue;
- (void) setURLFromPlist:(NSString *)fileName URLKey:(NSString *)key;
- (BOOL) syncFetch:(NSString *)destinationFileName;
@end
