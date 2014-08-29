//
//  Assignment.m
//  ModelClasses
//
//  Created by Anthony Mace on 6/2/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "Assignment.h"

@implementation Assignment

- (instancetype)init
{
    return [self initWithName:@"Assignment" gradeEarned:0.0];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _gradeEarned = [aDecoder decodeDoubleForKey:@"gradeEarned"];
        _pointsEarned = [aDecoder decodeDoubleForKey:@"pointsEarned"];
        _pointsPossible = [aDecoder decodeDoubleForKey:@"pointsPossible"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeDouble:self.gradeEarned forKey:@"gradeEarned"];
    [aCoder encodeDouble:self.pointsEarned forKey:@"pointsEarned"];
    [aCoder encodeDouble:self.pointsPossible forKey:@"pointsPossible"];
}

- (instancetype)initWithName:(NSString *)name gradeEarned:(double)gradeEarned
{
    self = [super init];
    if (self) {
        _name = name;
        _gradeEarned = gradeEarned;
    }
    return self;
}

+ (Assignment *)createAssign
{
    NSArray *names = @[@"Test #1", @"Test #2", @"Test #3", @"Test #4"];
    NSUInteger randIndex = arc4random_uniform([names count]);
    Assignment *random = [[Assignment alloc] initWithName:[names objectAtIndex:randIndex] gradeEarned:arc4random_uniform(100)];
    return random;
}

- (double)gradeEarned
{
    if (self.pointsPossible != 0) {
        return self.pointsEarned / self.pointsPossible * 100;
    } else {
        return 0;
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@: %.1f", self.name, self.gradeEarned];
}

@end
