//
//  MercuryAccountTableViewController.m
//  Mercury
//
//  Created by Jeffrey on 11-4-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MercuryAccountTableViewController.h"
#import "MercuryAppDelegate.h"
#import "UIContent.h"
#import "MercuryAccountSettingsViewController.h"
#define unselectImage @"unselected.PNG"
#define selectImage @"selected.PNG"
#define displayCharactersNumBefordAt 10
#define charactersMaxNum 22

@implementation MercuryAccountTableViewController
@synthesize accountListUIContent;
@synthesize accountList;

- (void)dealloc {
    [accountListUIContent release];
    [accountList release];
    [super dealloc];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];
    
    // Load the global UI helper object.
    MercuryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.accountListUIContent = appDelegate.uiContent.uiAccountListKeys;
    
    self.title = [self.accountListUIContent objectAtIndex:AC_EN_ACCOUNT_LIST];
    self.view.backgroundColor = [UIColor blackColor];
    
    // TODO: read the accounts from UserConfig.plist.
    // The array here is only for testing.
    self.accountList = [NSMutableArray arrayWithObjects:
                        @"loveMercury@gmail.com",
                        @"helloWorld@longlongmail.com",
                        @"superLongSiteNameWhateverItIsJustSoLong@gmail.com", nil];
}


#pragma mark - Table view datasource

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return [self.accountList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowIndex = indexPath.row;
    
    static NSString *cellIdentifier = @"SectionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
							 cellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:cellIdentifier] autorelease];
        
        // Configure the cell.
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
        /* +------------------ Shorten the acccount name if necessary --------------------+ */
        // Reform the account name if it is too long before the character of "@".
        NSString *origenalString = [[NSString alloc] 
                                    initWithString:[self.accountList objectAtIndex:rowIndex]];
        
        // Find the "@" and judge if the following characters are too many.
        NSCharacterSet *atSign = [NSCharacterSet characterSetWithCharactersInString:@"@"];
        NSRange atRange = [origenalString rangeOfCharacterFromSet:atSign];
        if ([origenalString length] > charactersMaxNum && 
            atRange.location > displayCharactersNumBefordAt) {
            // Invoke the shorten string method.
            cell.textLabel.text = [self shortenAccountName:origenalString withSeparator:atSign];
            [origenalString release];
        }
        else {
            cell.textLabel.text = origenalString;
            [origenalString release];
        }        
        /* +-------------- End of shorten the acccount name if necessary -----------------+ */

        // Judge the current account here.
        selectedAccountIndex = 0;
        if (rowIndex == selectedAccountIndex) {
            cell.imageView.image = [UIImage imageNamed:selectImage];
        }
        else {
            cell.imageView.image = [UIImage imageNamed:unselectImage];
        }
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    willSelectedAccountIndex = indexPath.row;
    if (willSelectedAccountIndex != selectedAccountIndex) {
        UIAlertView *changeAccountAlert  = [[UIAlertView alloc] 
                        initWithTitle:[self.accountListUIContent objectAtIndex:AC_EN_MESSAGE] 
                              message:nil 
                             delegate:self 
                    cancelButtonTitle:[self.accountListUIContent objectAtIndex:AC_EN_CANCEL] 
                    otherButtonTitles:[self.accountListUIContent objectAtIndex:AC_EN_SURE], nil];
        [changeAccountAlert show];
        [changeAccountAlert release];
    }
}


- (void)tableView:(UITableView *)tableView 
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    MercuryAccountSettingsViewController *accountSettingsVC = 
        [[[MercuryAccountSettingsViewController alloc] initWithStyle:UITableViewStyleGrouped] 
         autorelease];
    
    accountSettingsVC.title = [self.accountListUIContent objectAtIndex:AC_EN_ACCOUNT_SETTINGS];
    accountSettingsVC.currentAccountNameString = [self.accountList objectAtIndex:indexPath.row];
    [[self navigationController] pushViewController:accountSettingsVC animated:YES];
}


#pragma mark - Alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        deselectedAccountIndex = selectedAccountIndex;
        selectedAccountIndex = willSelectedAccountIndex;
        
        // We change the row image here.
        UITableViewCell *selectCell = [self.tableView cellForRowAtIndexPath:
                                       [NSIndexPath indexPathForRow:selectedAccountIndex 
                                                          inSection:0]];
        selectCell.imageView.image = [UIImage imageNamed:selectImage];
        UITableViewCell *deselectCell = [self.tableView cellForRowAtIndexPath:
                                         [NSIndexPath indexPathForRow:deselectedAccountIndex
                                                            inSection:0]];
        deselectCell.imageView.image = [UIImage imageNamed:unselectImage];
        
        // We load the new account info here.
    }
}


#pragma mark - Shorten string method

- (NSString *)shortenAccountName:(NSString *)accountName 
                   withSeparator:(NSCharacterSet *)separator {
    // Divide account into two parts: the first 20 characters brfore "@", and the string after "@".
    NSArray *separatedeStrings = [accountName componentsSeparatedByCharactersInSet:separator];
    NSString *shortName = [[separatedeStrings objectAtIndex:0] 
                                  substringToIndex:displayCharactersNumBefordAt];
    NSString *atString = [separatedeStrings objectAtIndex:1];
    
    // Combine three parts of account together.
    NSString *shortAccountName = [shortName stringByAppendingFormat:@"...@%@", atString];
    return shortAccountName;
}


@end
