//
//  UtilityMethods.h
//  MedianApp
//
//  Created by Anthony Mace on 7/18/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilityMethods : NSObject

+ (UIFont *)latoLightFont:(CGFloat)size;
+ (UIFont *)latoBoldFont:(CGFloat)size;
+ (UIFont *)latoRegFont:(CGFloat)size;
+ (NSString *)determineSeasonAndYear;
+ (UIColor *)determineColorShown:(double)percentage;
+ (double)getGradeWholeNumber:(double)grade;
+ (double)getGradeDecimal:(double)grade;



@end
