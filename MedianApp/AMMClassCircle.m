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
    //UIBezierPath *innerDashColored = [UIBezierPath bezierPath];
    UIBezierPath *outerSolidGrayed = [UIBezierPath bezierPath];
    UIBezierPath *innerDashGrayed = [UIBezierPath bezierPath];
    UIBezierPath *outerSolidColored = [UIBezierPath bezierPath];
    
    //Percentages
    double percentage = self.grade;
    //double decimal = self.grade - floor(self.grade);
    
    //Points and radii
    CGPoint outerPoint = CGPointMake(0, 28);
    CGPoint point = CGPointMake(0, 28);
    CGFloat radius = 21.5;
    CGFloat outerRadius = 26.5;
    CGFloat line = 20.0;
    point.x += line;
    point.x += radius;
    outerPoint.x += line - 5;
    outerPoint.x += outerRadius;
    
    //Line width
    innerDashGrayed.lineWidth = 1;
    outerSolidGrayed.lineWidth = 3.25;
    
    //Dash patterns
    //double dashPattern[] = {8, 7};
    //[innerDashGrayed setLineDash:dashPattern count:2 phase:0];
    
    //Outer arcs
    //[innerDashGrayed addArcWithCenter:point radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [outerSolidGrayed addArcWithCenter:outerPoint radius:outerRadius startAngle:270 endAngle:540 clockwise:YES];
    [[UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1] setStroke];
    
    //Stroke
    [innerDashGrayed stroke];
    [outerSolidGrayed stroke];
    
    //Colored circles
    if (percentage != 0) {
        //innerDashColored.lineWidth = 1;
        outerSolidColored.lineWidth = 3.25;
        //[innerDashColored setLineDash:dashPattern count:2 phase:-3.9];
        //[innerDashColored addArcWithCenter:point radius:radius startAngle:DEGREES_TO_RADIANS(270)
                      //endAngle:DEGREES_TO_RADIANS(360 * decimal + 270)
                     //clockwise:YES];
        [outerSolidColored addArcWithCenter:outerPoint radius:outerRadius startAngle:DEGREES_TO_RADIANS(270) endAngle:DEGREES_TO_RADIANS(360 * (percentage / 100) + 270) clockwise:YES];
        if (percentage >= 85) {
            [[UIColor colorWithRed:124/255.0 green:209/255.0 blue:30/255.0 alpha:1] setStroke];
        } else if (percentage >= 70) {
            [[UIColor colorWithRed:243/255.0 green:172/255.0 blue:54/255.0 alpha:1] setStroke];
        } else {
            [[UIColor colorWithRed:233/255.0 green:69/255.0 blue:89/255.0 alpha:1] setStroke];
        }
        //[innerDashColored stroke];
        [outerSolidColored stroke];
    }
}

@end
