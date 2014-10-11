//
//  UIColor+AMMDetermineColorsShown.m
//  MedianApp
//
//  Created by Anthony Mace on 10/11/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "UIColor+AMMDetermineColorsShown.h"

@implementation UIColor (AMMDetermineColorsShown)

+ (UIColor *)amm_determineColorShown:(double)percentage;
{
    UIColor *color;
    if (percentage >= 85) {
        color = [UIColor colorWithRed:124/255.0 green:209/255.0 blue:30/255.0 alpha:1];
    } else if (percentage >= 70) {
        color = [UIColor colorWithRed:243/255.0 green:172/255.0 blue:54/255.0 alpha:1];
    } else {
        color = [UIColor colorWithRed:233/255.0 green:69/255.0 blue:89/255.0 alpha:1];
    }
    return color;
}

@end
