//
//  LoginTableCell.m
//  Mercury
//
//  Created by puretears on 3/8/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import "LoginTableCell.h"


@implementation LoginTableCell
@synthesize loginLabel;
@synthesize loginTextField;

- (void)dealloc {
    [loginLabel release];
	[loginTextField release];
    [super dealloc];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	self.selectionStyle = UITableViewCellSelectionStyleNone;

    if (self) { 
		// Create & add the left text in the cell.
		UILabel *labelTemp = [[UILabel alloc] initWithFrame:CGRectMake(8, 11, 80, 21)];
		self.loginLabel = labelTemp;
		[labelTemp release];
		self.loginLabel.textAlignment = UITextAlignmentRight;
		self.loginLabel.tag = kLabelTag;
		self.loginLabel.font = [UIFont boldSystemFontOfSize:14];
		self.loginLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:self.loginLabel];

		// Create & add the right text field control.
		UITextField *textFieldTemp = 
			[[UITextField alloc] initWithFrame:CGRectMake(96, 9, 202, 31)];
		self.loginTextField = textFieldTemp;
		[textFieldTemp release];
		self.loginTextField.clearsOnBeginEditing = YES; 
		self.loginTextField.returnKeyType = UIReturnKeyDone;
        self.loginTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.loginTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.loginTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.loginTextField.keyboardAppearance = UIKeyboardAppearanceAlert;
		[self.contentView addSubview:self.loginTextField];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


@end
