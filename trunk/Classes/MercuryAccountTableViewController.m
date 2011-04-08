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


@implementation MercuryAccountTableViewController
@synthesize accountList;
//@synthesize selectImage;

- (void)dealloc {
    [accountList release];
//    [selectImage release];
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
//    MercuryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
//    self.accountListUIContent = appDelegate.uiContent;
    
    self.title = @"Account List";
    self.view.backgroundColor = [UIColor blackColor];
    
    // TODO: read the accounts from UserConfig.plist.
    // The array here is only for testing.
    self.accountList = [NSMutableArray arrayWithObjects:
                        @"loveMercury",
                        @"helloWorld",
                        @"superLongSiteNameWhateverItIsJustSoLong", nil];
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
        cell.textLabel.text = [self.accountList objectAtIndex:rowIndex];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
        // Judeg the current account here.
        // This is only a test.
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
    UIAlertView *changeAccountAlert  = [[UIAlertView alloc] 
                                        initWithTitle:@"Are you sure to change account?" 
                                              message:nil 
                                             delegate:self 
                                    cancelButtonTitle:@"Cancle" 
                                    otherButtonTitles:@"Sure", nil];
    [changeAccountAlert show];
    [changeAccountAlert release];
}


- (void)tableView:(UITableView *)tableView 
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    MercuryAccountSettingsViewController *accountSettingsVC = 
        [[[MercuryAccountSettingsViewController alloc] init] autorelease];
    accountSettingsVC.title = @"Account Settings";
    accountSettingsVC.currentAccountNameString = [self.accountList objectAtIndex:indexPath.row];
    [[self navigationController] pushViewController:accountSettingsVC animated:YES];
}


#pragma mark - Table view delegate
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

@end
