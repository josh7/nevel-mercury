

## Block是什么？ ##

Block是C语言的一个语法特性，同时也是C语言的运行时特性，它很像C中的函数指针，因为你可以像使用函数指针一样的去使用block对象；它也很像C++中的函数对象，因为除了要执行的代码，block还可以携带和block绑定的状态信息。

因此，block是一个对象，这个对象里包含了要执行的代码片段以及一些状态信息。

MacOSX 10.6和iOS 4.0以上版本的Xcode开发包提供了对block的支持。

### Block的功能 ###

block是一片具有以下特性的内联代码片段集合:

  * 可以像函数一样有类型参数；
  * 可以声明或推算出一个返回类型；
  * 可以访问和block定义在同一个词法范围里的变量（即Status）；
  * 可以修改同一个词法范围里的变量；
  * 同一个词法范围的block之间可以共享变量和变量的修改结果；
  * 当栈被摧毁后，栈里的block依旧可以保持状态信息；

## Block的用法 ##

作为一个自包含的代码片段，由于以下特性，block很适合作为回调函数的替代方案：

  * 你可以在方法的下上文中，调用block的地方直接编写构成block的代码片段；
  * block可以访问局部变量；

## 如何声明和定义Block ##

你可以通过`^`操作符定义一个block类型的变量，用`{}`来圈定block的代码片段，如下图所示：

![http://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/Blocks/Art/blocks.jpg](http://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/Blocks/Art/blocks.jpg)

再次声明：block可以访问和block定义在同一个词法范围里的变量。

```
int multiplier = 7;
int (^myBlock)(int) = ^(int num) { return num * multipiler; }

printf("%d", myBlock(3)); // prints "21"
```

### 直接使用Block ###

在更多的时候，你并不需要定义自己的Block类型，而是在API中直接编写block代码片段，例如:qsort\_b。

```
char *myCharacter[3] = { "safari", "ie", "chrome" };
qsort_b(myCharacter, 3, sizeof(char *), ^(const void *l, const void *r) {
    char *left = *(char **)l;
    char *right = *(char **)r;
    return strncmp(left, right, 1);
});
```

### Block和Cocoa ###
Cocoa framework中很多方法使用了Block作为其参数（尽管也有对应的callback版本，但还是推荐使用
block版本）。在动画以及集合遍历方面，block很常见。

```
NSArray *stringsArray = [NSArray arrayWithObjects:
                                 @"string 1",
                                 @"String 21",
                                 @"string 12",
                                 @"String 11",
                                 @"String 02", nil];
static NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch | 
    NSNumericSearch |NSWidthInsensitiveSearch | NSForcedOrderingSearch;

NSLocale *currentLocale = [NSLocale currentLocale];
NSComparator finderSortBlock = ^(id string1, id string2) {
    NSRange string1Range = NSMakeRange(0, [string1 length]);
    return [string1 compare:string2 
                    options:comparisonOptions 
                      range:string1Range
                     locale:currentLocale];
};

NSArray *finderSortArray = [stringsArray 
    sortedArrayUsingComparator:finderSortBlock];

NSLog(@"finderSortArray: %@", finderSortArray);
```
## block和变量之间的关系 ##

这一部分涉及内存管理相关的内容，为了正确的使用block，理解并记住它们，很重要：

在一个block代码片段的内部，你可以使用三种不同类型的变量（就像你在函数里一样）：

  * 全局变量（包括static locals）；
  * 全局函数（尽管这并不是变量=。=）；
  * 在包含block的词法范围内的局部变量；

当在一个Block里使用变量时，应遵循以下规则：

  * 在包含block的词法范围里的栈局部变量，在block内部是常量，只能只读访问。这些局部变量的值即block执行时，局部变量的值。在多层内嵌的block中，
局部变量的值，取最内层词法范围里，局部变量的值；
  * 被声明为`__block`存储类型的局部变量通过引用传递给block，因此是mutable的；在`__block`类型的局部变量的有效范围内，对该局部变量的修改，会在该有效范围内的所有block范围内生效；
  * 定义在block内部的局部变量，和函数内部的局部变量法则相同；

正确的：

```
int x = 123;
void (^printXandY)(int) = ^(int y) {
    printf("%d %d\n", x, y);
};

printXandY(456);
```

错误的：

```
int x = 123;

void (^printXandY)(int) = ^(int y) {
    x = x + y; // ERROR HERE!!! x should be __block
    printf("%d %d\n", x, y);
};

printXandY(456);
```

### 关于`__block`的进一步讨论 ###

  1. `__block`是只针对局部变量生效的一种描述变量存储类型的关键字，因此`__block`类型的变量都是栈变量；
  1. `__block`类型的变量在其定义的语法范围里，和该范围内的所有block共享存储空间，当block在被复制到heap区域时，同区域内的`__block`变量占用的内存不会随着退栈而销毁；
  1. 出于优化的考虑，栈中的block对象最开始和一般的栈局部变量是相同的，当使用Block\_copy对block进行复制时，才被拷贝到heap区域；
  1. `__block`变量不能是一个可变长数组；

下面这个例子用于展示，各种类型的变量与`__block`之间的交互：

```
extern NSInteger CounterGlobal;
static NSInteger CounterStatic;
{
    NSInteger localCounter = 42;
    __block char localCharacter;
    void (^aBlock)(void) = ^(void) {
        ++CounterGlobal;
        ++CounterStatic;
        CounterGlobal = localCounter; // localCounter fixed at block creation
        localCharacter = 'a'; // sets localCharacter in enclosing scope
    };
    ++localCounter; // unseen by the block
    localCharacter = 'b';
    aBlock(); // execute the block
    // localCharacter now 'a'
}
```

### `__block`和Object C对象之间的关系 ###

如果，你在一个方法的实现里，使用了`__block`，则：

  * 通过引用的方式访问对象的，self被retain；
```
dispatch_async(queue, ^{
    // instanceVariable is used by reference, self is retained
    doSomethingWithObject(instanceVariable);
});
```

  * 通过值访问对象的，被访问的对象被retain；
```
id localVariable = instanceVariable;
dispatch_async(queue, ^{
    // localVariable is used by value, localVariable is retained (not self)
    doSomethingWithObject(localVariable);
});
```

### `__block`和C++对象之间的关系 ###

需要注意两点：

  * 把一个基于栈的C++对象变成一个`__block`类型的时候，要调用类的copy constructor；
  * 在block内部使用栈中的C++对象时，要调用栈的const copy constructor；id localVariable = instanceVariable;
dispatch_async(queue, ^{
    // localVariable is used by value, localVariable is retained (not self)
    doSomethingWithObject(localVariable);
});
}}}```