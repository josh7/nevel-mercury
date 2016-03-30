# Introduction #

本文档描述用[CorePlot](http://code.google.com/p/core-plot/)开发柱状图的基本流程和方法。


### 创建项目 ###

打开XCode，新建一个View-based Application，并给项目命名：`CorePlotTest`

之后，按照[CorePlotUpAndRun](http://code.google.com/p/nevel-mercury/wiki/CorePlotUpAndRun)中的说明，把Core plot集成到我们的项目中来。

在`CorePlotTestViewController.h`里，添加对Core plot头文件的引用：

```
#import "CorePlot-CocoaTouch.h"
```

由于我们这个例子中，报表的数据是通过我们的view controller提供的，因此，`CorePlotTestViewController`要实现`<CPPlotDataSource>` protocol。

```
@interface CorePlotTestViewController : UIViewController<CPPlotDataSource> {
	CPXYGraph *graph; // The graph with bars.
	NSArray *data;
}

@property (nonatomic, retain) NSArray *data;
```

CPXYGraph是一个CPGraph的派生类对象，代表我们的柱状图，而柱状图需要的数据，则由数组data提供。

在我们进一步深入之前，我们先到`CorePlotTestViewController`.m里，在`CorePlotTestViewController`的dealloc方法里，向data发送release消息。

```
- (void)dealloc {
	[data release];
	[super dealloc];
}
```

### 实现core plot的数据源方法 ###

我们在[CorePlotHighLevelDesignOverview](http://code.google.com/p/nevel-mercury/wiki/CorePlotHighLevelDesignOverview)中已经介绍过了，Core plot的数据源方法一共有三个：

```
#pragma mark -
#pragma mark CorePlot Data Source Methods
- (NSUInteger)numberOfRecordsForPlot:(CPPlot *)plot {
	 return [self.data count];
}

- (CPFill *)barFillForBarPlot:(CPBarPlot *)barPlot 
			recordIndex:(NSNumber *)index {
	return nil;
}

- (NSNumber *)numberForPlot:(CPPlot *)plot 
			 field:(NSUInteger)fieldEnum 
			recordIndex:(NSUInteger)index {
	
	switch (fieldEnum) {
		case CPBarPlotFieldBarLocation:
			return (NSDecimalNumber *)[NSDecimalNumber numberWithUnsignedInteger:index];
			break;
		case CPBarPlotFieldBarLength:
			return (NSDecimalNumber *)[self.data objectAtIndex:index];
			break;
	}
	return nil;
}
```

`- (NSUInteger)numberOfRecordsForPlot:(CPPlot *)plot`用于返回plot代表的图上元素数量（例如柱状图的柱数，饼图的份数等），很显然，它应该返回data数组元素的个数；

`- (CPFill *)barFillForBarPlot:(CPBarPlot *)barPlot recordIndex:(NSNumber *)index`我们暂时先不使用，因此让它返回nil；

`- (NSNumber *)numberForPlot:(CPPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index`这是core plot进行绘图时，参考的数据方法（根据这个方法的返回值来绘制）；

回顾下我们在[CorePlotHighLevelDesignOverview](http://code.google.com/p/nevel-mercury/wiki/CorePlotHighLevelDesignOverview)里曾经提到过的和Tableview进行对比的例子，在`- (NSNumber *)numberForPlot:(CPPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index`方法里：fieldEnum就好比是Tableview的列，Tableview的两列分别用了CPBarPlotFieldBarLocation / CPBarPlotFieldBarLength来区分。CPBarPlotFieldBarLocation表示的横轴的数据，我们进行类型转换后，返回调用该方法时传递进来的index，代表的是图柱的索引；而CPBarPlotFieldBarLength则表示index位置的图柱的高度，返回data数组中和index对应的数组中的值即可。

我相信，到此，柱状图的相关实现要比你曾经想象的容易的多，接下来，我们要做的事情，就是对data进行初始化，完成CPXYGraph的构建工作并把它显示在屏幕上。

### 初始化数据 ###

为了简单起见，我们直接在`CorePlotTestViewController`的viewDidLoad方法里， 显式初始化data数组。

```
NSArray *array = [[NSArray alloc] initWithObjects:
				[NSDecimalNumber numberWithInt:100],
				[NSDecimalNumber numberWithInt:130],
				[NSDecimalNumber numberWithInt:30],
				[NSDecimalNumber numberWithInt:40],
				[NSDecimalNumber numberWithInt:60],
				[NSDecimalNumber numberWithInt:80],
				[NSDecimalNumber numberWithInt:100],
				[NSDecimalNumber numberWithInt:120],
				[NSDecimalNumber numberWithInt:10],
				[NSDecimalNumber numberWithInt:15],
				[NSDecimalNumber numberWithInt:20],
				[NSDecimalNumber numberWithInt:100],
				nil];
	self.data = array;
	[array release];
```

### 构建CPGraph对象以及相关的基础构件 ###

接下来，我们第一个需要创建的，是CPXYGraph对象，你可以把这个对象看成是我们报表各个部分的容器。

```
// Create graph from theme
graph = [[CPXYGraph alloc] initWithFrame:CGRectZero];
CPTheme *theme = [CPTheme themeNamed:kCPDarkGradientTheme];
[graph applyTheme:theme];
CPGraphHostingView *hostingView = (CPGraphHostingView *)self.view;
hostingView.hostedGraph = graph;
```

CPTheme是报表背景的样式，core plot默认内置了四种主题：

```
NSString * const kCPDarkGradientTheme = @"Dark Gradients";      ///< Dark gradient theme.
NSString * const kCPPlainWhiteTheme = @"Plain White";           ///< Plain white theme.
NSString * const kCPPlainBlackTheme = @"Plain Black";           ///< Plain black theme.
NSString * const kCPStocksTheme = @"Stocks";                            ///< Stocks theme
```

而CPGraphHostingView则是CPGraph的“容器”，在之前我们也说过了，Core plot报表并不直接画在UIView上，而是画在
core plot自己的view上，这个view就是一个CPGrahHostingView对象，这里，我们只是把当前view controller的view对象强制转换成了一个CPGraphHostingView对象。

关于CPGraphHostingView对象的创建方法：

> _在interface builder里创建_

除了上面演示的方法，我们也可以在View controller类里声明一个`CPGraphHostingVIew *`的IBOutlet，而后在Interface builder里添加一个UIView，在class identity里指定成CPGraphHostingView。

或者：

> _通过代码手工创建_

```
graphHostingView = [[CPLayerHostingView alloc] initWithFrame:CGRectZero] autorelease];
[view addSubView:graphHostingView];
```

在分别创建了CPGraphHostingView和CPXYGraph对象后，我们通过下面的赋值把它们关联到一起：

```
hostingView.hostedGraph = graph;
```


### 创建Plot space ###

在[CorePlotHighLevelDesignOverview](http://code.google.com/p/nevel-mercury/wiki/CorePlotHighLevelDesignOverview)里我们提到过，我们需要一个数据空间到绘图控件的映射，这个工作，是由CPPlotSpace派生类对象完成的。

我们首先指定数据源空间：

```
// Define the sapce for the bars. (12 bars with a maximum height of 150)
CPXYPlotSpace *plotSpace = (CPXYPlotSpace *)graph.defaultPlotSpace;
plotSpace.yRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(0.0f) 
	   length:CPDecimalFromFloat(150.0f)];
	
plotSpace.xRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(0.0f) 
	   length:CPDecimalFromFloat(12.0f)];
```

由于我们的数据源有12个元素，最大值是130。因此我们把xRange的length设定成`[0, 12]`，而yRange设置成`[0, 150]`（留一点儿富裕嘛～）。

对于绘图空间，我们直接使用CPXYGraph提供的默认的仿射变换就可以了，因此，我们每必要再去重写坐标的转换算法。

### 绘制Bar plot ###

确定bar plot的属性，为绘制做准备：

```
// Bar plot
CPBarPlot *barPlot = [CPBarPlot tubularBarPlotWithColor:[CPColor yellowColor] 
	 horizontalBars:NO]; 
barPlot.dataSource = self;
barPlot.baseValue = CPDecimalFromString(@"0");
barPlot.barOffset = 1.0f;
barPlot.barWidth = 20.0f;
barPlot.identifier = @"BlurBarPlot";
```

要说明的是，barOffset要从1开始，否则最左侧的图柱会无法显示，barWidth用来设定每一个图柱的宽度，用像素为单位。baseValue，用于设定坐标轴最左边的起始值。

最后，我们通过下面的语句把bar plot“放置”到刚才创建的plot space上。

```
[graph addPlot:barPlot toPlotSpace:plotSpace];	
```

其实到这里，如果你build / debug就应该已经能看到一个bar plot了，但是等等，我们还有一件事情，绘制坐标轴。

### 绘制坐标轴CPAxis ###

之前我们说过，core plot的坐标轴用CPAxis表示，所有的坐标轴会被集成到一个CPAxisSet对象里。对于一个二维报表来说，当然要遵循规则：

一个CPXYGraph的坐标轴用一个CPXYAxis对象表示，XY轴最后被集成到一个CPXYAxisSet对象里。下面是一个非常简单的添加坐标轴的代码：

```
CPXYAxisSet *axisSet = (CPXYAxisSet *)graph.axisSet;
	
CPXYAxis *x = axisSet.xAxis;
x.majorIntervalLength = CPDecimalFromFloat(10.0f);
x.minorTicksPerInterval = 2;
		
CPXYAxis *y = axisSet.yAxis;
y.majorIntervalLength = CPDecimalFromFloat(10.0f);
y.minorTicksPerInterval = 2;

```

其实，我们还可以设置坐标轴的title，label和style，这些在core plot提供的实例代码里有非常详细的教程，这里就不多说了，show yourself the code。

### Build and Run ###

OK，到此，一个bar plot的原型就开发完了，你需要做的事情就是Build and Run。Congratulations!

![http://www.kerneldiy.com/images/_simpleBar.png](http://www.kerneldiy.com/images/_simpleBar.png)

尽管你可能觉得它并不如你想象的漂亮，但是画都画出来了，漂亮还是问题么？