//
//  MercuryPlotDraw.h
//  Mercury
//
//  Created by puretears on 4/15/11.
//  Copyright 2011 Rising. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CorePlot-CocoaTouch.h"


@interface MercuryPlotDraw : NSObject<CPPlotDataSource> {
    CPGraphHostingView *plotHostingView;
    CPXYGraph *graph;
    NSArray *monitorData; // Just for Demo.
}

@property (nonatomic, retain) CPGraphHostingView *plotHostingView;
@property (nonatomic, retain) NSArray *monitorData;

- (void) initWithRect:(CGRect)rect;
- (void) drawBarPlot;
@end
