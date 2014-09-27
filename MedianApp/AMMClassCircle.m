//
//  AMMClassCircle.m
//  Curva
//
//  Created by Anthony Mace on 6/18/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AMMClassCircle.h"

@interface AMMClassCircle ()

@end


#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)


@implementation AMMClassCircle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Nothing
        self.opaque = NO;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //Paths
    UIBezierPath *outerSolidGrayed = [UIBezierPath bezierPath];
    UIBezierPath *outerSolidColored = [UIBezierPath bezierPath];
    
    //Percentages
    double percentage = self.grade;
    
    //Points and radii
    CGPoint outerPoint = CGPointMake(0, 28);
    CGFloat outerRadius = 26.5;
    CGFloat line = 20.0;
    outerPoint.x += line - 5;
    outerPoint.x += outerRadius;
    
    //Line width
    outerSolidGrayed.lineWidth = 3.25;
    
    //Circle
    [outerSolidGrayed addArcWithCenter:outerPoint radius:outerRadius startAngle:270 endAngle:540 clockwise:YES];
    [[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1] setStroke];
    
    //Stroke
    [outerSolidGrayed stroke];
    
    //Colored circles
    if (percentage != 0) {
        outerSolidColored.lineWidth = 3.25;
        [outerSolidColored addArcWithCenter:outerPoint radius:outerRadius startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(360 * (percentage / 100) + 270) clockwise:YES];
        if (percentage >= 85) {
            [[UIColor colorWithRed:124/255.0 green:209/255.0 blue:30/255.0 alpha:1] setStroke];
        } else if (percentage >= 70) {
            [[UIColor colorWithRed:243/255.0 green:172/255.0 blue:54/255.0 alpha:1] setStroke];
        } else {
            [[UIColor colorWithRed:233/255.0 green:69/255.0 blue:89/255.0 alpha:1] setStroke];
        }
        [outerSolidColored stroke];
    }
}

@end
