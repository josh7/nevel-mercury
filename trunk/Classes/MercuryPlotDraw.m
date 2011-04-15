//
//  MercuryPlotDraw.m
//  Mercury
//
//  Created by puretears on 4/15/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import "MercuryPlotDraw.h"


@implementation MercuryPlotDraw
@synthesize plotHostingView;
@synthesize monitorData;

- (void) initWithRect:(CGRect)rect {
    NSArray *array = [[NSArray alloc] initWithObjects:
                      [NSDecimalNumber numberWithInt:30],
                      [NSDecimalNumber numberWithInt:28],
                      [NSDecimalNumber numberWithInt:30],
                      [NSDecimalNumber numberWithInt:140],
                      [NSDecimalNumber numberWithInt:44],
                      [NSDecimalNumber numberWithInt:46],
                      [NSDecimalNumber numberWithInt:16],
                      [NSDecimalNumber numberWithInt:18],
                      [NSDecimalNumber numberWithInt:25],
                      [NSDecimalNumber numberWithInt:38],
                      [NSDecimalNumber numberWithInt:49],
                      [NSDecimalNumber numberWithInt:20],
                      nil];
    self.monitorData = array;
    [array release];
    
    
    CPGraphHostingView *plotHostingViewTemp = [[CPGraphHostingView alloc] initWithFrame:rect];
    self.plotHostingView = plotHostingViewTemp;
    [plotHostingView release];
}

- (void)drawBarPlot:(CPColor *)barColor {
    CPXYGraph *graphTemp = [[CPXYGraph alloc] initWithFrame:CGRectZero];
    graph = graphTemp;
    [graphTemp release];
    
    // Border
    graph.plotAreaFrame.borderLineStyle = nil;
    graph.plotAreaFrame.cornerRadius = 0.0f;
	
    // Paddings
    graph.paddingLeft = 0.0f;
    graph.paddingRight = 0.0f;
    graph.paddingTop = 0.0f;
    graph.paddingBottom = 0.0f;
    
    CPTheme *theme = [CPTheme themeNamed:kCPDarkGradientTheme];
    [graph applyTheme:theme];
    
    self.plotHostingView.hostedGraph = graph;
    
    // Define the sapce for the bars. (12 bars with a maximum height of 150)
    CPXYPlotSpace *plotSpace = (CPXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.yRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(0.0f) 
                                                   length:CPDecimalFromFloat(150.0f)];
    
    plotSpace.xRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(0.0f) 
                                                   length:CPDecimalFromFloat(12.0f)];
    
    // Bar plot
    CPBarPlot *barPlot = [CPBarPlot tubularBarPlotWithColor:barColor 
                                             horizontalBars:NO]; 
    barPlot.dataSource = self;
    barPlot.baseValue = CPDecimalFromString(@"0");
    barPlot.barOffset = 1.0f;
    barPlot.barWidth = 20.0f;
    barPlot.identifier = @"BlurBarPlot";
    
    [graph addPlot:barPlot toPlotSpace:plotSpace];  
}

#pragma mark - CorePlot Data Source Methods
// How many bars in our chart?
- (NSUInteger)numberOfRecordsForPlot:(CPPlot *)plot {
    return [monitorData count];
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
            return (NSDecimalNumber *)[monitorData objectAtIndex:index];
    }

    return nil;
}
@end
