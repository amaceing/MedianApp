//
//  AMMGradeBar.m
//  Median
//
//  Created by Anthony Mace on 7/10/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AMMGradeBar.h"

@implementation AMMGradeBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    //Drawing Code
    CGPoint start = CGPointMake(0, 0);
    
    //Color Line
    UIBezierPath *colorLine = [UIBezierPath bezierPath];
    double length = (rect.size.width / 100) * self.grade;
    CGPoint end = CGPointMake(length, 0);
    colorLine.lineWidth = 20;
    [colorLine moveToPoint:start];
    [colorLine addLineToPoint:end];
    if (self.grade >= 85) {
        [[UIColor colorWithRed:124/255.0 green:209/255.0 blue:30/255.0 alpha:1] setStroke];
    } else if (self.grade >= 70) {
        [[UIColor colorWithRed:243/255.0 green:172/255.0 blue:54/255.0 alpha:1] setStroke];
    } else {
        [[UIColor colorWithRed:233/255.0 green:69/255.0 blue:89/255.0 alpha:1] setStroke];
    }
    [colorLine stroke];
}

@end
