//
//  MercuryDomainListViewController.h
//  Mercury
//
//  Created by Jeffrey on 29/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MercuryDomainListViewController : UITableViewController {
    // The arrays to keep domain info from XML.
    NSArray *domainName;
    NSArray *nevelPowered;
    NSArray *securityLogs;
    NSArray *alerts;
}

@end
