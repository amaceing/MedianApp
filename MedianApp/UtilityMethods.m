//
//  UtilityMethods.m
//  MedianApp
//
//  Created by Anthony Mace on 7/18/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "UtilityMethods.h"

@implementation UtilityMethods

+ (UIFont *)latoLightFont:(CGFloat)size
{
    return [UIFont fontWithName:@"Lato-Light" size:size];
}

+ (UIFont *)latoBoldFont:(CGFloat)size
{
    return [UIFont fontWithName:@"Lato-Bold" size:size];
}

+ (UIFont *)latoRegFont:(CGFloat)size
{
    return [UIFont fontWithName:@"Lato-Regular" size:size];
}

+ (NSString *)determineSeasonAndYear
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger month = [components month];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    if (month >= 1 && month <= 5) {
        return [NSString stringWithFormat:@"Spring %@", yearString];
    } else if (month >= 6 && month <= 8) {
        return [NSString stringWithFormat:@"Summer %@", yearString];
    } else if (month >= 9 && month <= 12) {
        return [NSString stringWithFormat:@"Fall %@", yearString];
    }
    return @"";
}

+ (UIColor *)determineColorShown:(double)percentage;
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
