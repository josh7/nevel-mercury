//
//  LoginTableCell.h
//  Mercury
//
//  Created by puretears on 3/8/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kLabelTag 0 // bySu: why tag it?
#define kTextFieldTag 1

// bySu: to creat a UITableViewCell
@interface LoginTableCell : UITableViewCell {
	UILabel *loginLabel;
	UITextField *loginTextField;
}

@property (nonatomic, retain) UITextField *loginTextField;
@property (nonatomic, retain) UILabel *loginLabel;

@end