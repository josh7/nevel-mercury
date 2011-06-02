//
//  DomainListCell.m
//  Mercury
//
//  Created by Jeffrey on 30/04/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DomainListCell.h"
#import "MercuryAppDelegate.h"

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
    [nevelPoweredLabel release];
    [securityLogsLabel release];
    [alertsLabel release];
    
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
    // Load the global UI helper object.
    MercuryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    domainListUIContent = appDelegate.uiContent.uiDomainListKeys;
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        
    if (self) {
        // Customize our accessory view.
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        UIImageView *blueAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:blueAccessory]];
        self.accessoryView = blueAccessoryView;
        [blueAccessoryView release];

        // Set the rect of cell.
        cellView = [[UIView alloc] initWithFrame:CGRectMake(frameOfCell)];
        
        // Add domain status icon to the cell.
        UIImageView *ivTemp = [[UIImageView alloc] initWithFrame:CGRectMake(frameOfIcon)];
        self.stateIconView = ivTemp;
        [ivTemp release];
        self.stateIconView.image = [UIImage imageNamed:iconSafe];
        [cellView addSubview:self.stateIconView];
        
        // Add domain name label to the cell.
        UILabel *dnTemp = [[UILabel alloc] initWithFrame:CGRectMake(frameOfDomainName)];
        self.domainNameLabel = dnTemp;
        [dnTemp release];
        self.domainNameLabel.textAlignment = UITextAlignmentLeft;
        self.domainNameLabel.textColor = [UIColor whiteColor];
        self.domainNameLabel.backgroundColor = [UIColor clearColor];
        self.domainNameLabel.font = [UIFont boldSystemFontOfSize:normalFontSize];
        [cellView addSubview:self.domainNameLabel];
        
        // Add the static label: nevel powered / security logs / alerts in the cell.
        nevelPoweredLabel = [[UILabel alloc] initWithFrame:CGRectMake(frameOfNevelPowered)];
        nevelPoweredLabel.text = [domainListUIContent objectAtIndex:DL_EN_NEVEL_POWERED];
        nevelPoweredLabel.textAlignment = UITextAlignmentLeft;
        nevelPoweredLabel.textColor = [UIColor lightGrayColor];
        nevelPoweredLabel.backgroundColor = [UIColor clearColor];
        nevelPoweredLabel.font = [UIFont systemFontOfSize:smallFontSize];
        [cellView addSubview:nevelPoweredLabel];
        
        securityLogsLabel = [[UILabel alloc] initWithFrame:CGRectMake(frameOfSecurityLogs)];
        securityLogsLabel.text = [domainListUIContent objectAtIndex:DL_EN_SECURITY_LOGS];
        securityLogsLabel.textAlignment = UITextAlignmentLeft;
        securityLogsLabel.textColor = [UIColor lightGrayColor];
        securityLogsLabel.backgroundColor = [UIColor clearColor];
        securityLogsLabel.font = [UIFont systemFontOfSize:smallFontSize];
        [cellView addSubview:securityLogsLabel];
        
        alertsLabel = [[UILabel alloc] initWithFrame:CGRectMake(frameOFAlerts)];
        alertsLabel.text = [domainListUIContent objectAtIndex:DL_EN_ALERTS];;
        alertsLabel.textAlignment = UITextAlignmentLeft;
        alertsLabel.textColor = [UIColor lightGrayColor];
        alertsLabel.backgroundColor = [UIColor clearColor];
        alertsLabel.font = [UIFont systemFontOfSize:smallFontSize];
        [cellView addSubview:alertsLabel];
        
        // Add the variable label: nevel powered ON/OFF / logs num. / alerts num. in the cell.
        UILabel *npvTemp = [[UILabel alloc] initWithFrame:CGRectMake(frameOFPoweredValue)];
        self.nevelPoweredValue = npvTemp;
        [npvTemp release];
        self.nevelPoweredValue.textAlignment = UITextAlignmentLeft;
        self.nevelPoweredValue.textColor = [UIColor greenColor];
        self.nevelPoweredValue.backgroundColor = [UIColor clearColor];
        self.nevelPoweredValue.font = [UIFont boldSystemFontOfSize:smallFontSize];
        [cellView addSubview:self.nevelPoweredValue];

        UILabel *slvTemp = [[UILabel alloc] initWithFrame:CGRectMake(frameOfLogsValue)];
        self.securityLogsValue = slvTemp;
        [slvTemp release];
        self.securityLogsValue.textAlignment = UITextAlignmentLeft;
        self.securityLogsValue.textColor = [UIColor greenColor];
        self.securityLogsValue.backgroundColor = [UIColor clearColor];
        self.securityLogsValue.font = [UIFont boldSystemFontOfSize:smallFontSize];
        [cellView addSubview:self.securityLogsValue];

        UILabel *avTemp = [[UILabel alloc] initWithFrame:CGRectMake(frameOfAlertsValue)];
        self.alertsValue = avTemp;
        [avTemp release];
        self.alertsValue.textAlignment = UITextAlignmentLeft;
        self.alertsValue.textColor = [UIColor orangeColor];
        self.alertsValue.backgroundColor = [UIColor clearColor];
        self.alertsValue.font = [UIFont boldSystemFontOfSize:largeFontSize];
        [cellView addSubview:self.alertsValue];
        
        // Add our customized view to the cell content view and add our super background view.
        [self.contentView addSubview:cellView];
        UIImageView *cellBackgroundView = [[UIImageView alloc] 
                                           initWithFrame:CGRectMake(frameOfCell)];
        cellBackgroundView.image = [UIImage imageNamed:cellBackground];
        self.backgroundView = cellBackgroundView;
        [cellBackgroundView release];
        
        // Managing cell selection and highlighting.
        
    }
    return self;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
