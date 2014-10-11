//
//  UtilityMethods.m
//  MedianApp
//
//  Created by Anthony Mace on 7/18/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "UtilityMethods.h"

@implementation UtilityMethods

//Added as category to UIFont
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


//Added as category to NSString
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

//Added as category to UIColor
+ (UIColor *)determineColorShown:(double)percentage;
{
    UIColor *color;
    if (percentage >= 85) {
       color = [UIColor colorWithRed:126/255.0 green:211/255.0 blue:32/255.0 alpha:1];
    } else if (percentage >= 70) {
        color = [UIColor colorWithRed:243/255.0 green:172/255.0 blue:54/255.0 alpha:1];
    } else {
        color = [UIColor colorWithRed:233/255.0 green:68/255.0 blue:98/255.0 alpha:1];
    }
    return color;
}

+ (double)getGradeWholeNumber:(double)grade
{
    double wholeNum = grade;
    double dec = [self getGradeDecimal:grade];
    return wholeNum - dec;
}

+ (double)getGradeDecimal:(double)grade
{
    double dec = grade - floor(grade);
    if (dec >= 0.95) {
        //return 0.1 so .0 is displayed and it won't round up
        return 0.1;
    }
    return dec;
}


@end
