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
    self.monitorData = array;
    [array release];
    
    
    CPGraphHostingView *plotHostingViewTemp = [[CPGraphHostingView alloc] initWithFrame:rect];
    self.plotHostingView = plotHostingViewTemp;
    [plotHostingView release];
}

- (void)drawBarPlot {
    CPXYGraph *graphTemp = [[CPXYGraph alloc] initWithFrame:CGRectZero];
    graph = graphTemp;
    [graphTemp release];
    
    CPTheme *theme = [CPTheme themeNamed:kCPDarkGradientTheme];
    [graph applyTheme:theme];
    
    self.plotHostingView.hostedGraph = graph;
    
    // Define the sapce for the bars. (12 bars with a maximum height of 150)
    CPXYPlotSpace *plotSpace = (CPXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.yRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(0.0f) 
                                                   length:CPDecimalFromFloat(30.0f)];
    
    plotSpace.xRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(0.0f) 
                                                   length:CPDecimalFromFloat(12.0f)];
    
    // Bar plot
    CPBarPlot *barPlot = [CPBarPlot tubularBarPlotWithColor:[CPColor yellowColor] 
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
