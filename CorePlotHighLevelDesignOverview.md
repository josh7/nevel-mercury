# Core Plot设计综述 #

本部分描述构成Core Plot的主要类以及它们之间的关系。

## 设计考量 ##

在深入了解构成Core Plot的类之前，有必要先来了解下这套框架的设计目标。由于Core Plot需要能够在MacOSX和iOS上运行，在技术的使用上就受到了一定的制约。不可以使用[AppKit](http://developer.apple.com/library/mac/#documentation/Cocoa/Reference/ApplicationKit/ObjC_classic/_index.html)来画图（iOS上没有），视图类NSView和UIView只能作为view的宿主存在。实际的绘图工作是使用底层的Quartz 2D API完成的，Core Animation层用来构建图表其他的方面。

当然，这并不完全是坏消息。Core Animation为我们提供了很多“养眼”的特性。图表可以支持动画、旋转和3D特效。Core Plot的目标是不仅能够提供企业级的静态图表，还能够为图表提供“非比寻常”的图像效果和互动性。

Core Plot的另一个设计考量是：从程序员的角度上来看，Core Plot应该和一个Mac家族内置的框架一样。因此，你能在Core Plot上找到MVC, Data Source, Delegation和Binding等你耳熟能详的事物。

## 庖丁解“表” ##

下面这个图展示了一个有两组数据集的标准Bar图表和构成该图表的各个组件的分解结构。在Core Plot里，用图中标示的名字表示这些组件。

![http://core-plot.googlecode.com/files/GraphAnatomy.png](http://core-plot.googlecode.com/files/GraphAnatomy.png)

### 类关系图 ###

下面这个标准UML类关系图表现了Core Plot框架中主要类的关系。类的基数关系通过1和`*`表示，1表示to-one，`*`表示to-many。

![http://core-plot.googlecode.com/files/ClassDiagram.png](http://core-plot.googlecode.com/files/ClassDiagram.png)

### 报表中的对象和层 ###

下面这张图展示了运行时对象之间的关系和Core Animation的Layer tree。左边层的颜色和右边类的颜色是一一对应的。

![http://core-plot.googlecode.com/files/ObjectAndLayerDiagram.png](http://core-plot.googlecode.com/files/ObjectAndLayerDiagram.png)

### 层（Layer） ###

Core Animation的CALayer类并不适合生成矢量图，因此也并不适合企业应用的需求，并且CALayer不提供事件响应的功能。因此，Core Plot使用的层叫做CPLayer，它是CALayer的一个子类。CPLayer提供了生成高质量矢量图片和事件处理机制的支持。

在CPLayer上绘图的方法包括：

```
- (void)renderAsVectorInContext:(CGContextRef)context;
- (void)recursivelyRenderInContext:(CGContextRef)context;
- (NSData *)dataForPDFRepresentationOfLayer;
```

当编写CPLayer的子类的时候，不仅要重写drawInContext:方法，还应该重写renderAsVectorInContext:。这样，这个层便能够正确生成矢量图，并把它绘制到屏幕上。

### 图（Graph） ###

CPGraph是Core Plot的核心类。在Core Plot里，"Graph"意味着包括坐标、Label、title和一个或多个Plot(s)构成的整个报表。CPGraph是一个抽象类，所有具体的图表类都继承自CPGraph。

一个Graph类可以被认为是一个graph factory。它负责创建构成图表的各种不同的对象并设置它们之间的关系。CPGraph包含指向其他高级类的引用，例如：CPAxisSet, CPPlotArea和CPPlotSpace。CPGraph还用来跟踪用于显示在Graph上的Plot(CPPlot对象)。

```
@interface CPGraph : CPLayer {
@protected
    CPAxisSet *axisSet;
    CPPlotArea *plotArea;
    NSMutableArray *plots;
    NSMutableArray *plotSpaces;
    CPFill *fill;
}

@property (nonatomic, readwrite, retain) CPAxisSet *axisSet;
@property (nonatomic, readwrite, retain) CPPlotArea *plotArea;
@property (nonatomic, readonly, retain) CPPlotSpace *defaultPlotSpace;
@property (nonatomic, readwrite, retain) CPFill *fill;

// Retrieving plots
-(NSArray *)allPlots;
-(CPPlot *)plotAtIndex:(NSUInteger)index;
-(CPPlot *)plotWithIdentifier:(id <NSCopying>)identifier;

// Organizing plots
-(void)addPlot:(CPPlot *)plot; 
-(void)addPlot:(CPPlot *)plot toPlotSpace:(CPPlotSpace *)space;
-(void)removePlot:(CPPlot *)plot;
-(void)insertPlot:(CPPlot*)plot atIndex:(NSUInteger)index;
-(void)insertPlot:(CPPlot*)plot atIndex:(NSUInteger)index intoPlotSpace:(CPPlotSpace *)space;

// Retrieving plot spaces
-(NSArray *)allPlotSpaces;
-(CPPlotSpace *)plotSpaceAtIndex:(NSUInteger)index;
-(CPPlotSpace *)plotSpaceWithIdentifier:(id <NSCopying>)identifier;

// Adding and removing plot spaces
-(void)addPlotSpace:(CPPlotSpace *)space; 
-(void)removePlotSpace:(CPPlotSpace *)plotSpace;

@end

@interface CPGraph (AbstractFactoryMethods)

-(CPPlotSpace *)createPlotSpace;
-(CPAxisSet *)createAxisSet;

@end
```

CPGraph是一个抽象类，它的子类例如CPXYGraph负责图表各个组件实际的创建和组织工作。CPGraph的每一个子类都关联着构成和该子类对应的图表的各个层的子类。例如，CPXYGraph创建了一个CPXYAxisSet和CPXYPlotSpace对象。这是设计模式中工厂模式的一种典型应用。

### Plot Area ###

Plot Area是报表的一部分，数据被绘制在Plot Area上。通常用坐标轴来定义plot area的范围。Grid lines也被绘制在plot area上。对于每一个报表，只有一个Plot Area。Core plot framework用CPPlotArea对象来表示一个Plot area。

### Plot Spaces ###

Plot space定义了数据集的坐标空间和plot area的绘画空间之间的映射。

例如：如果你需要画一个列车时间和时速的关系图，数据集的坐标空间是X轴表示时间、Y轴表示列车的速度。假设时间范围是`[0, 180]`min，速度范围是`[0, 150]`KM/h。而绘画空间，用plot area的边界表示。一个plot area对象，通常是一个CPPlotSpace子类对象，定义了数据集坐标和绘画空间之间的映射，即特定时间对应的速度和屏幕上表示该数据的位置之间的映射。

使用Core plot内置的仿射变换（Affine transformation）来处理两种空间的映射是一个不错的主意，但是通常这样有一定的局限性，因为并不是所有的映射都是线性关系。例如，很多数学应用软件在数据空间都使用对数刻度（logarithmic scale）。

为了能够让数据空间支持尽可能多的数据类型，数据空间内部的数据都使用NSDecimalNumber对象保存。但是在绘画空间里，是不能使用NSDecimalNumber的，Cocoa中的绘画坐标系使用CGFloat类型，NSDecimalNumber提供的额外精度会被忽略。

一个继承自CPPlotSpace的类必须要实现两个方法，一个用来把绘画空间转换到数据集坐标空间，另一个做相反的转换。

```
- (CGPoint)viewPointForPlotPoint:(NSArray *)decimalNumber;
- (NSArray *)plotPointForViewPoint:(CGPoint)point;
```

注：新版本的core plot已经更新为：

```
- (CGPoing)plotAreaViewPointForPlotPoint:(NSDecimal)plotPoint;
- (CPPlotRnage *)plotRangeForCoordinate:(CPCoordinate)coordinate;
```

但含义是类似的。

数据空间的坐标，用plot point表示，用一个NSDecimalNumber的数组作为参数传入。绘画空间的坐标，用view point表示，用一个CGPoint对象表示。

无论一个对象需要把数据空间转换成绘图空间，或者反过来，都要以其对应的plot space为基础进行查询。例如，一个CPPlot的实例和一个特定的plot space是对应的，使用这个对应的plot space，core plot来决定把这个plot画在正确的位置上。

一个报表可能包含多个plot，这些plot可能会依据不同的刻度来进行绘画（例如线性或者对数）。为了使Core Plot支持这个特性，一个CPGraph对象可以包含多个CPPlotSpace对象。大部分的时候，尽管我们只需要一个Plot space对象就够了，但是Core plot framework自身为一份报表包含多个plot spaces提供了支持。

### Plots ###

在图表上，数据的一种特定的表现被称作一个“Plot”。例如：数据有可能被表现为散点图（每一个点上有相关数据的描述），也可以是一个柱状图。

一个图表上，可以有多个plot。每一个plot可以来自不同的数据集，彼此互不相关，也可以共享一个数据集。

从本质上来说，一个plot和一个table view是类似的，尽管从直觉上并不容易把它们关联到一起。例如：我们用一个line plot来表示前面提到过的列车的速度-时间分布图。我们需要每一个需要表现的时间对应的列车的速度。而这个数据就可以用一个两列的table view来表示，进而也可以再转换成一个散点图。所以，plot和table view是同一份数据集的两种不同表示。

因此，我们用在table view上的设计模式同样可以用来生成plot，绑定或者Data source都可以。为了使用data source模式向一个plot提供数据，你需要设置CPPlot对象的dataSource成员，然后实现下面的data source方法：

```
@protocol CPPlotDataSource<NSObject>

- (NSUInteger)numberOfRecords;

@optional
- (NSArray *)numbersForPlot:(CPPlot *)plot field:(NSUInteger)fieldEnum recordIndexRange:(NSRange)indexRange
- (NSNumber *)numberForPlot:(CPPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index;

- (NSRange)recordIndexRangeForPlot:(CPPlot *)plot plotRange:(CPPlotRange *)plotRect;
@end
```

你可以把fieldEnum想成是我们上面对比的table view的列，而record index是table view中的行。每一类plot都有固定数量的fields。例如：一个散点图需要两个fields，分别表示XY轴的数据。Core plot定义了一个枚举类型表示field：

```
@typedef enum _CPScatterPlotField {
    CPScatterPlotFieldX,
    CPScatterPlotFieldY
} CPScatterPlotField;
```

Plot类不仅仅支持Data source设计模式，还支持通过Cocoa绑定的方式提供数据源。这也和Table view中用到的方法类似：

```
CPGraph *graph = ...;
CPScatterPlot *boundLinePlot = [[[CPScatterPlot alloc] initWithFrame:CGRectZero] autorelease];
boundLinePlot.identifier = @"Bindings Plot";
boundLinePlot.dataLineStyle.lineWidth = 2.f;
[graph addPlot:boundLinePlot];
[boundLinePlot bind:CPScatterPlotBindingXValues toObject:self withKeyPath:@"arrangedObjects.x" options:nil];
[boundLinePlot bind:CPScatterPlotBindingYValues toObject:self withKeyPath:@"arrangedObjects.y" options:nil];
```

所有类型的报表都是CPPlot的派生类，CPPlot是一个抽象基类。例如：CPScatterPlot用来绘制散点图而CPBarPlot用来绘制柱状图。

一个plot对象和前面我们提到的CPPlotSpace对象是紧密相关的。为了能够绘制自己，plot类需要把它自己的数据源数据转换成绘画坐标中对应的值，这是通过和plot对象对应的plot space对象完成的。

### Axes ###

坐标轴描述了plot space上的刻度。一个基本的报表通常只有两个坐标轴，X轴和Y轴。但是在Core plot上，并没有对坐标轴的数量进行限制，你可以添加任意多个坐标轴。坐标轴可以显示在plot area的底部和侧面，也可以显示在plot area的顶部。坐标轴可以有不同的刻度，可以区分主/从刻度，也可以有Label和Title。

报表上的每一个坐标轴都用一个CPAxis的派生类表示。CPAxis负责绘制坐标轴自身以及tile / leabel等附属组件。为了完成绘制工作，CPAxis需要知道数据集坐标和绘画坐标之间的对应关系，因此一个CPAxis对象都和一个CPPlotSpace对象关联。

一个报表可以有多个坐标轴，但是所有的坐标轴都被组织到一个CPAxisSet对象里。CPAxisSet对象是一个容器，包含了报表上需要的所有坐标轴和类工厂（class factory），factory用于创建axis set。

坐标轴上的label通常都是文本，但是Core plot也支持客制化的label。通过把任何Core Animation Layer包装成一个CPAxisLayer对象都可以作为axis label。

### Animations ###

Core plot提供了动画功能的支持，这使得通过core plot开发的报表可以支持动态效果和用户交互。Core Animation Framework提供了在运行时移动和改变图层位置的功能，但是我们需要通过更高层的类把这些图层的位置组织起来，使得这些相关联部分的移动像是整个报表在移动，同时，这个高层的类还用来组织动画之间的过渡（这很像你通过Keynote来构建一个动画序列的过程）。

Core plot主要通过CPAnimation类来支持动画。这个类从根本上说是一个状态机：它存储一个报表所有可能的状态（注意是状态，不是报表），即关键帧，并且允许报表在这些状态之间切换。

![http://core-plot.googlecode.com/files/AnimationGraph.png](http://core-plot.googlecode.com/files/AnimationGraph.png)

Core plot允许用户设定转换的起始和结束状态以及转换发生的时间。这种组合带来了很大的灵活性，使得core plot可以支持没有交互的动态报表到全交互式的动态报表设计。

```
@interface CPAnimation : NSObject {
    CPGraph *graph;
    NSMutableSet *mutableKeyFrames;
    NSMutableSet *mutableTransitions;
    CPAnimationKeyFrame *currentKeyFrame;
}

@property (nonatomic, readonly, retain) CPGraph *graph;
@property (nonatomic, readonly, retain) NSSet *animationKeyFrames;
@property (nonatomic, readonly, retain) NSSet *animationTransitions;
@property (nonatomic, readonly, retain) CPAnimationKeyFrame *currentKeyFrame;

-(id)initWithGraph:(CPGraph *)graph;

// Key frames
-(void)addAnimationKeyFrame:(CPAnimationKeyFrame *)newKeyFrame;
-(CPAnimationKeyFrame *)animationKeyFrameWithIdentifier:(id <NSCopying>)identifier;

// Transitions
-(void)addAnimationTransition:(CPAnimationTransition *)newTransition fromKeyFrame:(CPAnimationKeyFrame *)startFrame toKeyFrame:(CPAnimationKeyFrame *)endFrame;
-(CPAnimationTransition *)animationTransitionWithIdentifier:(id <NSCopying>)identifier;

-(void)animationTransitionDidFinish:(CPAnimationTransition *)transition;

// Animating
-(void)performTransition:(CPAnimationTransition *)transition;
-(void)performTransitionToKeyFrame:(CPAnimationKeyFrame *)keyFrame;

@end
```

CPAnimationKeyFrame类定义了报表动画的关键帧，这个类最重要的成员，就是状态的标识：

```
@interface CPAnimationKeyFrame : NSObject {
    id <NSCopying> identifier;
    BOOL isInitialFrame;
    NSTimeInterval duration;
}

@property (nonatomic, readwrite, copy) id <NSCopying> identifier;
@property (nonatomic, readwrite, assign) NSTimeInterval duration;

-(id)initAsInitialFrame:(BOOL)isFirst;

@end
```

最后一个类，CPAnimationTransition表示了一个动画中的原子部件（atomic part）。例如：对于渐入渐出的动画效果，一个完整的CPAnimation对象需要包含多个渐入和渐出的效果和其他的转换效果。

CPAnimationTransition是一个抽象类，派生类在performTransition方法中通过标准Core Animation技术实现CPGraph中各个组件的动画效果。一个CPAnimationTransition派生类对象包含一个转换的时间段，并且，转换是可逆的。通过设置reversible为YES，可以让报表支持动画的可逆转换。

```
@interface CPAnimationTransition : NSObject {
    id <NSCopying> identifier;
    CPAnimationKeyFrame *startKeyFrame;
    CPAnimationKeyFrame *endKeyFrame;
    CPAnimationTransition *continuingTransition;
    NSTimeInterval duration;
    CPAnimation *animation;
}

@property (nonatomic, readwrite, assign) NSTimeInterval duration;
@property (nonatomic, readwrite, copy) id <NSCopying> identifier;
@property (nonatomic, readwrite, assign) CPAnimation *animation;
@property (nonatomic, readwrite, retain) CPAnimationKeyFrame *startKeyFrame;
@property (nonatomic, readwrite, retain) CPAnimationKeyFrame *endKeyFrame;
@property (nonatomic, readwrite, retain) CPAnimationTransition *continuingTransition;
@property (nonatomic, readonly, assign) BOOL reversible;

@end

@interface CPAnimationTransition (AbstractMethods)

-(void)performTransition;

@end    
```