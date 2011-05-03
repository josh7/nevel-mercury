//
//  DomainListCell.m
//  Mercury
//
//  Created by Jeffrey on 30/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DomainListCell.h"
#import "UIContent.h"

// The frame of each view and lable in cell.
#define frameOfCell           0,   0, 300, 100
#define frameOfIcon          12,  10,  30,  30
#define frameOfDomainName    54,  14, 226,  21
#define frameOfNevelPowered  10,  46, 100,  21
#define frameOfSecurityLogs 126,  46,  90,  21
#define frameOFAlerts       228,  46,  50,  21
#define frameOFPoweredValue  52,  71,  42,  21
#define frameOfLogsValue    161,  71,  42,  21
#define frameOfAlertsValue  233,  71,  42,  21


@implementation DomainListCell
@synthesize stateIconView;
@synthesize domainNameLabel;
@synthesize nevelPoweredValue;
@synthesize securityLogsValue;
@synthesize alertsValue;


- (void)dealloc {
    [stateIconView release];
    [domainNameLabel release];
    [nevelPoweredValue release];
    [securityLogsValue release];
    [alertsValue release];
    
    [cellView release];
    [cellBackgroundView release];
    [nevelPoweredLabel release];
    [securityLogsLabel release];
    [alertsLabel release];
    [blueAccessoryView release];
    
    [super dealloc];
}


#pragma mark - View lifecycle

// Our super domain list cell.
/*
 * +--|------|--------------------------------------------------------+
 * |  | icon |     domainName.com                                     |
 * +--|------|-------------------------------------------------+   \  |
 * |               Nevel Powered  |  Security Logs  |  Alerts  |   /  |
 * |                     ON       |        00       |    00    |      |
 * +------------------------------------------------------------------+
*/


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        
    if (self) {
        // Customize our accessory view.
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        blueAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:blueAccessory]];
        self.accessoryView = blueAccessoryView;

        // Set the rect of cell.
        cellView = [[UIView alloc] initWithFrame:CGRectMake(frameOfCell)];
        
        // Add domain status icon to the cell.
        UIImageView *ivTemp = [[UIImageView alloc] initWithFrame:CGRectMake(frameOfIcon)];
        self.stateIconView = ivTemp;
        [ivTemp release];
        self.stateIconView.image = [UIImage imageNamed:iconSafe];
        [cellView addSubview:self.stateIconView];
        
        // Add domain name label to the cell.
        domainNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(frameOfDomainName)];
        domainNameLabel.textAlignment = UITextAlignmentLeft;
        domainNameLabel.textColor = [UIColor whiteColor];
        domainNameLabel.backgroundColor = [UIColor clearColor];
        domainNameLabel.font = [UIFont boldSystemFontOfSize:normalFontSize];
        [cellView addSubview:domainNameLabel];
        
        // Add the static label: nevel powered / security logs / alerts in the cell.
        nevelPoweredLabel = [[UILabel alloc] initWithFrame:CGRectMake(frameOfNevelPowered)];
        nevelPoweredLabel.text = @"Nevel Powered";
        nevelPoweredLabel.textAlignment = UITextAlignmentLeft;
        nevelPoweredLabel.textColor = [UIColor lightGrayColor];
        nevelPoweredLabel.backgroundColor = [UIColor clearColor];
        nevelPoweredLabel.font = [UIFont systemFontOfSize:smallFontSize];
        [cellView addSubview:nevelPoweredLabel];
        
        securityLogsLabel = [[UILabel alloc] initWithFrame:CGRectMake(frameOfSecurityLogs)];
        securityLogsLabel.text = @"Security Logs";
        securityLogsLabel.textAlignment = UITextAlignmentLeft;
        securityLogsLabel.textColor = [UIColor lightGrayColor];
        securityLogsLabel.backgroundColor = [UIColor clearColor];
        securityLogsLabel.font = [UIFont systemFontOfSize:smallFontSize];
        [cellView addSubview:securityLogsLabel];
        
        alertsLabel = [[UILabel alloc] initWithFrame:CGRectMake(frameOFAlerts)];
        alertsLabel.text = @"Alerts";
        alertsLabel.textAlignment = UITextAlignmentLeft;
        alertsLabel.textColor = [UIColor lightGrayColor];
        alertsLabel.backgroundColor = [UIColor clearColor];
        alertsLabel.font = [UIFont systemFontOfSize:smallFontSize];
        [cellView addSubview:alertsLabel];
        
        // Add the variable label: nevel powered ON/OFF / logs num. / alerts num. in the cell.
        nevelPoweredValue = [[UILabel alloc] initWithFrame:CGRectMake(frameOFPoweredValue)];
        nevelPoweredValue.textAlignment = UITextAlignmentLeft;
        nevelPoweredValue.textColor = [UIColor greenColor];
        nevelPoweredValue.backgroundColor = [UIColor clearColor];
        nevelPoweredValue.font = [UIFont boldSystemFontOfSize:smallFontSize];
        [cellView addSubview:nevelPoweredValue];

        securityLogsValue = [[UILabel alloc] initWithFrame:CGRectMake(frameOfLogsValue)];
        securityLogsValue.textAlignment = UITextAlignmentLeft;
        securityLogsValue.textColor = [UIColor greenColor];
        securityLogsValue.backgroundColor = [UIColor clearColor];
        securityLogsValue.font = [UIFont boldSystemFontOfSize:smallFontSize];
        [cellView addSubview:securityLogsValue];

        alertsValue = [[UILabel alloc] initWithFrame:CGRectMake(frameOfAlertsValue)];
        alertsValue.textAlignment = UITextAlignmentLeft;
        alertsValue.textColor = [UIColor orangeColor];
        alertsValue.backgroundColor = [UIColor clearColor];
        alertsValue.font = [UIFont boldSystemFontOfSize:largeFontSize];
        [cellView addSubview:alertsValue];
        
        // Add our customized view to the cell content view and add our super background view.
        [self.contentView addSubview:cellView];
        
        cellBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(frameOfCell)];
        cellBackgroundView.image = [UIImage imageNamed:cellBackground];
        self.backgroundView = cellBackgroundView;
    }
    return self;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
