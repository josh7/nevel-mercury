//
//  LoginTableCell.m
//  Mercury
//
//  Created by puretears on 3/8/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import "LoginTableCell.h"


@implementation LoginTableCell  // bySu: @interface
@synthesize loginLabel;
@synthesize loginTextField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	self.selectionStyle = UITableViewCellSelectionStyleNone;    // bySu: the selected cell do not turn blue
    
    // bySu: Why use if here?
    if (self) { 
        // Initialization code.
		// Create & add the left text in the cell.
		UILabel *labelTemp = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 78, 20)];    // bySu: only can be numbers
		self.loginLabel = labelTemp;
		[labelTemp release];
		self.loginLabel.textAlignment = UITextAlignmentLeft;
		self.loginLabel.tag = kLabelTag;    // bySu: 0 why use a tag?
		self.loginLabel.font = [UIFont boldSystemFontOfSize:14];
		self.loginLabel.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:self.loginLabel];
		
		
		// Create & add the right text field control.
		UITextField *textFieldTemp = 
			[[UITextField alloc] initWithFrame:CGRectMake(97, 7, 217, 31)];
		self.loginTextField = textFieldTemp;
		[textFieldTemp release];
		self.loginTextField.clearsOnBeginEditing = NO;  // bySy: default is NO
		self.loginTextField.returnKeyType = UIReturnKeyDone;    // bySu: default is UIReturnKeyDefault
		[self.contentView addSubview:self.loginTextField];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [loginLabel release];   // bySu: I think the label should be released.
	[loginTextField release];
    [super dealloc];
}

@end
