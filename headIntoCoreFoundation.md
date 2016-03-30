**Super summary by nacci520:**
```
1. 集合（类型1，类型2，类型3），对应的是dictionary, array都是property list的子类
2. 类型 （整数、浮点数、字符串），对应的就是他们都是CFType的子类
3. 用对象拥有权的方式管理内存，谁创建、拷贝，谁负责清理
```

# Introduction #

Core Foundation:
  * is a library
  * defines opaque types
  * enables sharing of code and data among various frameworks and libraries
  * makes some degree of operating-system independence possible
  * supports internationalization with Unicode strings
  * provides common API and other useful capabilities, including a plug-in architecture, XML property lists, and preferences

# Details #

## Opaque Types ##

> An opaque type
![http://developer.apple.com/library/ios/documentation/CoreFoundation/Conceptual/CFDesignConcepts/Art/opaquetypes.gif](http://developer.apple.com/library/ios/documentation/CoreFoundation/Conceptual/CFDesignConcepts/Art/opaquetypes.gif)

_A number of Core Foundation and Cocoa instances can simply be type-cast to each other, such as CFString and NSString objects._

## Polymorphic Functions ##

Polymorphic Functions can:
  * take any Core Foundation object as a parameter
  * return any Core Foundation object

Use polymorphic functions for:
  * reference counting
  * comparing objects
  * hashing objects
  * inspecting objects

## Three Basic Varieties ##

  * immutable and fixed size
  * mutable and fixed size
  * mutable and variable size

_Note:_ CFString and CFArray, can create all three flavors of objects.

## Memory Management ##

_For using Core Foundation in a reference counted environment._

Summery: "release" values **if and only if** having “copy” or “create” in their name.

These four are equivalent:

```
NSString *str = [[NSString alloc] initWithCharacters: ...];
...
[str release];
```

```
CFStringRef str = CFStringCreateWithCharacters(...);
 ...
CFRelease(str);
```

```
NSString *str = (NSString *)CFStringCreateWithCharacters(...);
 ...
[str release];
```

```
NSString *str = (NSString *)CFStringCreateWithCharacters(...);
 ...
[str autorelease];
```

# Note #

  * about CFNumber: In order to improve performance, some commonly-used numbers (such as 0 and 1) are uniqued. You should not expect that allocating multiple CFNumber instances will necessarily result in distinct objects.