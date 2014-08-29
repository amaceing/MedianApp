//
//  AssignmentCategory.m
//  ModelClasses
//
//  Created by Anthony Mace on 6/2/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AssignmentCategory.h"

@implementation AssignmentCategory

- (instancetype)init
{
    return [self initWithName:@"Category" withWeight:0.0];
}

- (instancetype)initWithName:(NSString *)name withWeight:(double)weight
{
    self = [super init];
    if (self) {
        _name = name;
        _weight = weight / 100.0;
        _average = 0.0;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _assignmentList = [aDecoder decodeObjectForKey:@"assignmentList"];
        _name = [aDecoder decodeObjectForKey:@"name"];
        _average = [aDecoder decodeDoubleForKey:@"average"];
        _weight = [aDecoder decodeDoubleForKey:@"weight"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.assignmentList forKey:@"assignmentList"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeDouble:self.average forKey:@"average"];
    [aCoder encodeDouble:self.weight forKey:@"weight"];
}

- (NSMutableArray *)assignmentList
{
    if (!_assignmentList) {
        _assignmentList = [NSMutableArray array];
    }
    return _assignmentList;
}

- (void)setWeight:(double)weight
{
    _weight = weight / 100.0;
}

- (NSInteger)getIndex:(Assignment *)assignment
{
    return [self.assignmentList indexOfObject:assignment];
}

- (NSInteger)getCount
{
    return [self.assignmentList count];
}

- (Assignment *)assignmentAtIndex:(NSInteger)index
{
    return self.assignmentList[index];
}

- (double)average
{
    double sum = 0;
    double pointsEarnedSum = 0;
    double pointsPossibleSum = 0;
    for (Assignment *assignment in self.assignmentList) {
        sum += assignment.gradeEarned;
        pointsEarnedSum += assignment.pointsEarned;
        pointsPossibleSum += assignment.pointsPossible;
    }
    int count = [self.assignmentList count];
    if (count) {
        if (pointsPossibleSum != 0) {
            return pointsEarnedSum / pointsPossibleSum * 100;
        } else {
            return 0;
        }
    }
    return sum;
}

- (void)addAssignment:(Assignment *)assignment
{
    if ([assignment isKindOfClass:[Assignment class]]) {
        [self.assignmentList addObject:assignment];
    }
}

- (void)addAssignment:(Assignment *)assignment atIndex:(NSInteger)index
{
    if ([assignment isKindOfClass:[Assignment class]]) {
        [self.assignmentList insertObject:assignment atIndex:index];
    }
}

- (void)removeAssignment:(Assignment *)assignment
{
    [self.assignmentList removeObjectIdenticalTo:assignment];
}

- (void)moveAssignmentAtIndex:(NSUInteger)from toIndex:(NSUInteger)to
{
    if (from == to) {
        return;
    } else {
        Assignment *temp = self.assignmentList[from];
        [self.assignmentList removeObjectAtIndex:from];
        [self.assignmentList insertObject:temp atIndex:to];
    }
}

- (double)calcClassWorth
{
    return ((self.average / 100.0) * self.weight);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %15.2f%%", self.name, self.average];
}

@end
