//
//  NSString+AMMSeasonAndYear.m
//  MedianApp
//
//  Created by Anthony Mace on 10/11/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "NSString+AMMSeasonAndYear.h"

@implementation NSString (AMMSeasonAndYear)

+ (NSString *)amm_determineSeasonAndYear
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

@end
