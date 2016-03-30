

## Create a UIViewController object manually ##

```
mainView = [[MercuryViewController alloc] init];
```

## Create a UIView object manually ##

```
UIView *vc = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
```

## Add subview ##

```
[mainView.view addSubview:tf];
```

or

```
[mainView.view insertSubview:tf atIndex:0];
```

## Create a UIImageView manually ##

```
UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NebulaBackground.png"]];
```

## Create a UITextField manually ##

```
UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)];
	tf.center = CGPointMake(160.0f, 320.0f);
	tf.borderStyle = UITextBorderStyleRoundedRect;
	tf.autocorrectionType = UITextAutocorrectionTypeNo;
	tf.placeholder = @"Name";
	tf.returnKeyType = UIReturnKeyDone;
	tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.delegate = self;
```

## Create a UITabBarController programmatically ##

### Create a Tab Bar Interface ###
```
tabBarController = [[UITabBarController alloc] init];
```

  * add views to Tab Bar Controller
```
NSArray* controllers = [NSArray arrayWithObjects:vc1, vc2, nil];
tabBarController.viewControllers = controllers;
```

### Create a Tab Bar Item ###

  * use system item
```
- (id)initWithTabBarSystemItem:(UITabBarSystemItem)systemItem tag:(NSInteger)tag
```
    * _UITabBarSystemItem_
```
   UITabBarSystemItemMore,
   UITabBarSystemItemFavorites,
   UITabBarSystemItemFeatured,
   UITabBarSystemItemTopRated,
   UITabBarSystemItemRecents,
   UITabBarSystemItemContacts,
   UITabBarSystemItemHistory,
   UITabBarSystemItemBookmarks,
   UITabBarSystemItemSearch,
   UITabBarSystemItemDownloads,
   UITabBarSystemItemMostRecent,
   UITabBarSystemItemMostViewed.
```

  * use your own image
```
- (id)initWithTitle:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag
```
> > _**tips: the image in  setItems:animated: method is used as a mask**_

### about UITabBarControllerDelegate ###

_tips from Apple: you would not use your tab bar controller delegate to change the appearance of the status bar to match the style of the currently selected view. Visual changes of that nature are best handled by your custom view controllers._

  * when a tab bar item is been tapped, whether the specified view controller should be made active
```
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
```

  * Tells the delegate that the user selected an item in the tab bar
```
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
```
> > _tips:_
    * In iOS v3.0 and later:
      * the tab bar controller calls this method regardless of whether the selected view controller changed
      * it is called only in response to user taps in the tab bar
      * it is not called when your code changes the tab bar contents programmatically
    * In versions of iOS prior to version 3.0:
      * this method is called only when the selected view controller actually changes
      * it is not called when the same view controller is selected
      * the method was called for both programmatic and user-initiated changes to the selected view controller

### change a Tab’s Badge ###

property: badgeValue

## Make your textField to be a pasword field ##

```
[passwordField setSecureTextEntry:YES];
```
## Move a subview manually ##

```
[UIView animateWithDuration:1.0 animations:^{
	mainView.view.frame = 
	CGRectMake(0, -200, mainView.view.frame.size.width, mainView.view.frame.size.height);
}];
```

## add events to a controller manually ##

```
[the controller addTarget:self 
                   action:@selector(actionMethod:) 
         forControlEvents:UIControlEventTouchDown];
```

## about naming ##

  * Temporary object naming: **objectNameTemp**


> eg:

```
UILabel *labelTemp = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 78, 20)];
self.loginLabel = labelTemp;
[labelTemp release];
```

## about UIColor ##

A UIColor object represents **color** and sometimes **opacity** (alpha value).

Can: store color data

| Preset Component Values | RGB value | grayscale value | alpha value | explanation |
|:------------------------|:----------|:----------------|:------------|:------------|
| blackColor              |           | 0.0             | 1.0         |
| clearColor              |           |  0.0            | 0.0         |
| whiteColor              |           | 1.0             | 1.0         |
| blueColor               | 0.0, 0.0, 1.0 |                 | 1.0         |
| brownColor              | 0.6, 0.4, 0.2 |                 | 1.0         |
| darkTextColor           |           |                 |             | Returns the system color used for displaying text on a light background. |
| groupTableViewBackgroundColor |           |                 |             | Returns the system color used for the background of a grouped table. |

colorWithRed:green:blue:alpha:
```
+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
```
> _red, green, blue, alpha: value from 0.0 to 1.0._

## about returnKeyType ##

  * UIReturnKeyDefault (Default value)
  * UIReturnKeyGo,
  * UIReturnKeyGoogle,
  * UIReturnKeyJoin,
  * UIReturnKeyNext (used when there are more than one textfield need to be filled, and not the last one),
  * UIReturnKeyRoute,
  * UIReturnKeySearch,
  * UIReturnKeySend,
  * UIReturnKeyYahoo,
  * UIReturnKeyDone,
  * UIReturnKeyEmergencyCall

## UITableVIewCell ##

### Cell Selection Style ###
  * UITableViewCellSelectionStyleNone (used when the cell can be edit, such as login text field)
  * UITableViewCellSelectionStyleBlue
  * UITableViewCellSelectionStyleGray

### Customize our cell ###
Design aspects and performance constraints:
  * **Draw appropriate.** Draw the entire cell only when appropriate.
  * **Avoid transparency.** It will impacts the scrolling performance. Always use opaque subviews.
  * **Needing display.** Mark the cell as needing display when viewable properties change. Send a setNeedsDisplay message to the cell if the value of the property changes.

## UIButton ##

### Control Events ###
```
enum {
   UIControlEventTouchDown           = 1 <<  0,
   UIControlEventTouchDownRepeat     = 1 <<  1,
   UIControlEventTouchDragInside     = 1 <<  2,
   UIControlEventTouchDragOutside    = 1 <<  3,
   UIControlEventTouchDragEnter      = 1 <<  4,
   UIControlEventTouchDragExit       = 1 <<  5,
   UIControlEventTouchUpInside       = 1 <<  6,
   UIControlEventTouchUpOutside      = 1 <<  7,
   UIControlEventTouchCancel         = 1 <<  8,
   
   UIControlEventValueChanged        = 1 << 12,
   
   UIControlEventEditingDidBegin     = 1 << 16,
   UIControlEventEditingChanged      = 1 << 17,
   UIControlEventEditingDidEnd       = 1 << 18,
   UIControlEventEditingDidEndOnExit = 1 << 19,
   
   UIControlEventAllTouchEvents      = 0x00000FFF,
   UIControlEventAllEditingEvents    = 0x000F0000,
   UIControlEventApplicationReserved = 0x0F000000,
   UIControlEventSystemReserved      = 0xF0000000,
   UIControlEventAllEvents           = 0xFFFFFFFF
};
```

## UIActionSheet ##

purpose
  * to present the user with a set of alternatives for how to proceed with a given task
  * to prompt the user to confirm a potentially dangerous action



## plist ##

### read a plist ###

```
NSString *key = @"plistKeyName";
NSArray *plistArray = [uiDictionary objectForKey:key];
[plistArray objectAtIndex:4]
```

## about  NSArray ##

### NSMutableArray ###

  * inherited from NSArray
  * manage a modifiable array of objects: maintain a mutable, ordered collection of objects
http://developer.apple.com/library/ios/#documentation/Cocoa/Reference/Foundation/Classes/NSMutableArray_Class/Reference/Reference.html

## UIPageControl ##

### summary ###

  * page control is a succession of dots centered in the control
  * each dot corresponds to a page in the application’s document (or other data-model entity)
  * a limit of about 20 page indicators on the screen before they are clipped (Because of the screen size)
  * advances only one page in either direction
  * When tapped, the control sends the _**UIControlEventValueChanged**_ event for handling by the delegate
  * The delegate can evaluate the _**currentPage**_ property to determine the page to display

### properties ###

  * currentPage
    * @property(nonatomic) NSInteger currentPage
    * begin: 0 (default show)

  * numberOfPages
    * @property(nonatomic) NSInteger numberOfPages
    * default value: 0

  * hidesForSinglePage
    * @property(nonatomic) BOOL hidesForSinglePage
    * controls whether the page indicator is hidden when there is only one page

  * defersCurrentPageDisplay

> ### methods ###

  * - (CGSize)sizeForNumberOfPages:(NSInteger)pageCount
    * for customize: resize the page control when the page count changes

## about UIImage ##

  * Image objects are immutable, so their properties can not be changed after creation
  * about Memory Management
    * In low-memory situations, image data may be purged from a UIImage object ( affects only the image data stored internally by the UIImage object and not the object itself )
    * avoid creating UIImage objects that are greater than 1024 x 1024 in size (This size restriction does not apply if you are performing code-based manipulations )

## about NSNull ##

  * The NSNull class defines a singleton object used to represent null values in collection objects (which don’t allow nil values).
  * class method: + (NSNull **)null**

## about UIScrollView ##

**_In Apple's reference, there is also NSScrollView Class Reference with UIScrollView Class Reference._**

## Tips on Insertion, Deletion, and Reloading of rows and sections ##

  * STEP\_1: prepare the array (or arrays) that are the source of data for the sections and rows.
    * After rows and sections are deleted and inserted, the resulting rows and sections are populated from this data store.
  * STEP\_2: call the beginUpdates method, followed by invocations of:
```
insertRowsAtIndexPaths:withRowAnimation:
deleteRowsAtIndexPaths:withRowAnimation:
insertSections:withRowAnimation:
deleteSections:withRowAnimation:
```
  * STEP\_3: Conclude the animation block by calling endUpdates.

## Create NSIndexPath for table view ##
```
NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow:myRow inSection:mySection];
```

## Table view cell highlighting cancellation ##
**ideas**: Deselect the row which was selected jest now, and use animation to delay the highlighting cancellation.- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
```