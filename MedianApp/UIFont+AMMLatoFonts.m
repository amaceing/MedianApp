//
//  UIFont+AMMLatoFonts.m
//  MedianApp
//
//  Created by Anthony Mace on 10/11/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "UIFont+AMMLatoFonts.h"

@implementation UIFont (AMMLatoFonts)

+ (UIFont *)amm_latoLightFont:(CGFloat)size
{
    return [UIFont fontWithName:@"Lato-Light" size:size];
}

+ (UIFont *)amm_latoBoldFont:(CGFloat)size
{
    return [UIFont fontWithName:@"Lato-Bold" size:size];
}

+ (UIFont *)amm_latoRegFont:(CGFloat)size
{
    return [UIFont fontWithName:@"Lato-Regular" size:size];
}

@end
