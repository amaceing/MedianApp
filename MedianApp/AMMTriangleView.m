//
//  AMMTriangleView.m
//  MedianApp
//
//  Created by Anthony Mace on 9/29/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AMMTriangleView.h"

@implementation AMMTriangleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.backgroundColor = [UIColor clearColor];
    UIBezierPath *tri = [UIBezierPath bezierPath];
    tri.lineWidth = 1.0;
    CGPoint p1 = CGPointMake(25, 10);
    CGPoint p2 = CGPointMake(55, 10);
    CGPoint p3 = CGPointMake(40, 23);
    [tri moveToPoint:p1];
    [tri addLineToPoint:p3];
    [tri addLineToPoint:p2];
    [[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1] setFill];
    [tri fill];
    [[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1] setStroke];
    [tri stroke];
}

@end
