# Introduction #

[CorePlot](http://code.google.com/p/core-plot/)是一个在MacOSX和iOS平台上用于解决2D数据可视化问题的Framework。你可以从[这里](http://code.google.com/p/core-plot)访问[CorePlot](http://code.google.com/p/core-plot/)的google project。

本文用于描述[CorePlot](http://code.google.com/p/core-plot/)在iOS平台开发需要进行的设置工作。

首先，到Google网站上下载`CorePlot framework`压缩包，将解压之后的文件放到~/Library/下面备用。

## 新建一个XCODE项目 ##

为了简单起见，我们新建一个View-based Application，起名叫`CorePlotTest`：

![http://www.kerneldiy.com/images/createApp.png](http://www.kerneldiy.com/images/createApp.png)

把Source/framework目录下的`CorePlot-CocoaTouch.xcodeproj`拖动到`CorePlotTest`项目里。

![http://www.kerneldiy.com/images/dragCP.png](http://www.kerneldiy.com/images/dragCP.png)

在弹出的对话框中，不要选择Copy items into destination group's folder这个Checkbox。单击Add按钮。这时，你就可以在Groups & Files里看到[CorePlot](http://code.google.com/p/core-plot/)项目了。

![http://www.kerneldiy.com/images/leaveCopy.png](http://www.kerneldiy.com/images/leaveCopy.png)

![http://www.kerneldiy.com/images/cpAdded.png](http://www.kerneldiy.com/images/cpAdded.png)

## 把[CorePlot](http://code.google.com/p/core-plot/)静态库添加到项目 ##

iOS平台上的[CorePlot](http://code.google.com/p/core-plot/)是要以静态库的形式编译到程序中的，因此，我们要把`CorePlot_CocoaTouch`中的静态库添加进来。打开`CorePlot-CocoaTouch.xcodeproj`节点，把`libCorePlot_CocoaTouch.a`拖动到`Targets/CorePlotTest/Link Binary With Libraries`节点里：

![http://www.kerneldiy.com/images/addStaticLib.png](http://www.kerneldiy.com/images/addStaticLib.png)

之后，把[CorePlot](http://code.google.com/p/core-plot/)的代码路径告诉给XCode，相对或者绝对路径都可以，记得要选择recursive，因为其他的头文件都在这个目录的子目录里：

![http://www.kerneldiy.com/images/includeCP.png](http://www.kerneldiy.com/images/includeCP.png)

接下来，我们要在XCode里面设置项目依赖关系，选择Project->Edit Active Target "CorePlotTest"，在弹出窗口的General tab里，添加`CorePlot-CocoaTouch`：

![http://www.kerneldiy.com/images/addCPDep.png](http://www.kerneldiy.com/images/addCPDep.png)

在XCode里添加一个Linker option：-ObjC。我们需要这个选项是因为[CorePlot](http://code.google.com/p/core-plot/)对现有的Cocoa Framework中的类使用了Category，不加-ObjC选项的话，当[CorePlot](http://code.google.com/p/core-plot/)作为静态库编译的时候，那些Categories的部分不会被链接到生成的应用程序里。

<img src='http://www.kerneldiy.com/images/includeObjC.png'>

<h2>添加Quartz Core到项目</h2>
由于<a href='http://code.google.com/p/core-plot/'>CorePlot</a>建立在Core Animation Library上，我们要把Quartz Framework添加到项目中来。在<code>CorePlotTest</code>下的Framework节点上右键，选择Add->Existing Frameworks...，之后在弹出的窗口中，选择<code>QuartzCore.framework</code>。<br>
<br>
<img src='http://www.kerneldiy.com/images/quartzFrame.png'>

至此，所有的<a href='http://code.google.com/p/core-plot/'>CorePlot</a>开发前的准备和配置工作就结束了。