# Introduction #

用于记录和[KissXML](http://code.google.com/p/kissxml/)相关的XML规范和概念。

## Atomic Value ##

XML规范中定义的“简单类型”的值。它们包括: string / decimal / integer / float / double / Boolean / date / URI / array和binary data。

## Attribute ##

一个Element的attribute可以被理解成一个"名称-值"pair。Attribute被用来对Element的数据进行编码或者提供和Element相关的metadata。例如：

```
<plist version="1.0">
```

在上面这个例子中，plist是element，version是attribute的name，"1.0"是attribute的value。

## Attribute list declaration ##

在DTD中，定义一个Element的name，value和default value的方法。例如：

```
<!ATTLIST phone location (home | office | mobile) "home">
```

在上面这个例子中，phone是Element，它有一个attribute name是location，location可以包含三个value：home / office / mobile，并且home是默认值。

## DTD ##

全名叫做 Document Type Definition，是一种用来描述XML element和其他XML文档构成要素的方法。

## Element ##

Element是一对标记，用来表示这对标记中包含的内容的属性，element可以有name，可以包含textual data，child element, processing instructions，comments和CDATA blocks。除了root以外，一个Element有一个单独的parent element。一个element还可以包含attributes和namespace prefixes。Element还可以为空（没有content），开发人员可以用来当成标志使用。

```
<para ref="12345678">
    The following C++ code gives an example of how
    <code>cout</code> is used:
    <![CDATA[std::cout << "Hello, World!\n";>
</para>
```

在上面这个例子中，para标记对就是Element，"The following C++..."和"is used"都是para的textual data，`<code>`是sub element。

## Namespace ##

一个用于定位Element或Attribute名称的URI，用于解决当一个文档中包含不同来源的XML时造成的命名冲突问题。你需要在一个标记的开始声明一个namespace，在xmlns属性上关联上namespace的前缀，之后用一个URI关联到这个namespace上。

```
<h:table xmlns:h="http://www.nevel.co">
```

之后，你只需要使用前缀h和element（两者通过冒号分隔）来唯一定位资源。属于该名字空间的child element，都通过前缀关联到同一个namespace。