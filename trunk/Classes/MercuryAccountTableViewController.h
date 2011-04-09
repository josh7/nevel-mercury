//
//  MercuryAccountTableViewController.h
//  Mercury
//
//  Created by Jeffrey on 11-4-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIContent.h"


@interface MercuryAccountTableViewController : UITableViewController<UIAlertViewDelegate> {
    // Object for UI text.
    NSArray *accountListUIContent;
    
    // The array here is only for testing.
    NSMutableArray *accountList;
    
    // The selected account index.
    int selectedAccountIndex;
    int deselectedAccountIndex;
    int willSelectedAccountIndex;
}

@property (nonatomic, retain) NSMutableArray *accountList;
@property (nonatomic, retain) NSArray *accountListUIContent;

@end
