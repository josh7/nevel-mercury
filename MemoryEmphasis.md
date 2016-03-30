

## Introduction ##

Allocate and release memory correctly and effectively.

## Handle memory management manually ##

The iOS provide a semi-automatic garbage collection memory management style.

  * Users allocate memory by _alloc_ method and get access to it by a pointer like this:

```
ClassObj *p = [ClassObj alloc];
```

  * The allocated object cannot be deleted automatically by the iOS, users should send _dealloc_ message to the pointer like this:

```
[p dealloc];
```

If you dealloc the same memory block twice by two different pointers, the result is undefined:

```
ClassObj *p1 = [ClassObj alloc];
ClassObj *p2 = p1;
[p1 dealloc];
[p2 dealloc]; // Error: Bow!!
```

  * To solve the above problem, iOS provide a reference count mechanism to manage the lifetime of an object. After an object is allocated, its default reference count is 1. You can retain the counter by sending a _retain_ message to the object or decrease the counter by sending a _release_ message. Actually, we do not send _dealloc_ message to the object directly, just _release_ it. When the reference count equals to 0, the object will be deleted automatically.

When assigning a pointer, the reference count WON'T be increased automatically. Just remember to retain it manually.

```
ClassObj *p1 = [ClassObj alloc]; // Reference count = 1
ClassObj *p2 = p1; // Reference count still equals to 1
[p2 retain]; // Retain it! counter = 2

/*Do something here.*/

[p2 release]; // counter = 1
[p1 release]; // counter = 0 Be deleted automatically.
```

## Handle memory management automatically ##

The iOS also provide a memory pool mechanism to manage objects automatically ( U still need to manage the pool automatically :-P ). All variables marked with autorelease tag will be put into memory pool.

```
ClassObj *p = [[[ClassObj alloc] init] autorelease]; // Retain count = 1
```

When the pool was deleted, it will traverse each element it contains and send _release_ message to it. If the counter equals to 0, the element will be deleted else memory leaks.

  * Each app has a default memory pool:

```
int main (int argc, const char *argv[])
{
    NSAutoreleasePool *pool;
    pool = [[NSAutoreleasePool alloc] init];
 
    // do something
 
    [pool release];
    return (0);
} // main
```

  * You can create a memory pool by yourself:

```
NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
```

**Why a DIYed memory pool?**

> If u have a mass of local variables, put them into a temporary memory pool to avoid the default pool long time occupied.

## About retain properties ##

When u need to exposure data members of a class object, declare a _nonatomic, retain_ property.

```
@property (nonatomic, retain) type data_member;
@synthesize data_member;
```

**How about retain?**

When assigning to a retain-type property, If the retain-type property isn't nil, it will send release message to the original object and send retain message to the new one (Compare to pointers assignment).

## Applied Code Snippets ##

**Assignment to data members**

```
Data_type *pObj = [[Data_type alloc] init];
self.data = pObj;
[pObj release];
```

or

`self.data = [[[Data_type alloc] init] autorelease];`

**Assignment to another pointer**

```
ClassObj *p2 = p1;
[p2 retain];

/*Do something yourself.*/

[p2 release];
p2 = nil;
```

**Return object by functions**

You'd better make the return value _autorelease_.

```
ClassObj *function() {
    ClassObj *retVal = [[[ClassObj alloc] init] autorelease];
    return retVal;
}
```

**About dealloc method**

Call parent's dealloc method in derived class dealloc method.

```
- (void) dealloc {
    /* Do it yourself. */
    [super dealloc];
}
```

**About NSDictionary**

The value for key - The object receives a retain message before being added to the dictionary. This value must not be nil.

The key - The key is copied (using copyWithZone:; keys must conform to the NSCopying protocol). The key must not be nil.

That means:

  1. The key will be managed by the dictionary itself. Just balance the retain/release pair outside the dictionary.
  1. The value will be retained by the dictionary, so release the outside pointer after adding to a dictionary.

```
NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
ClassObj *pObj = [[ClassObj alloc] init];
ClassKey *pKey = [[ClassKey alloc] init];
[mutableDic setObject:pObj forKey:pKey];
[pObj release];
```