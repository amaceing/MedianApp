//
//  SchoolClass.m
//  ModelClasses
//
//  Created by Anthony Mace on 6/3/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "SchoolClass.h"

@implementation SchoolClass

- (instancetype)init
{
    return [self initWithName:@"Class" daysOfWeek:@"" timeOfDay:@""];
    
}

- (instancetype)initWithName:(NSString *)name daysOfWeek:(NSString *)days timeOfDay:(NSString *)time
{
    self = [super init];
    if (self) {
        _name = name;
        _daysOfWeek = days;
        _timeOfDay = time;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _daysOfWeek = [aDecoder decodeObjectForKey:@"daysOfWeek"];
        _timeOfDay = [aDecoder decodeObjectForKey:@"timeOfDay"];
        _assignmentCategories = [aDecoder decodeObjectForKey:@"assignmentCategories"];
        _toDoItems = [aDecoder decodeObjectForKey:@"toDoItems"];
        _toDoItemsCount = [aDecoder decodeIntegerForKey:@"toDoItemsCount"];
        _grade = [aDecoder decodeDoubleForKey:@"grade"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.daysOfWeek forKey:@"daysOfWeek"];
    [aCoder encodeObject:self.timeOfDay forKey:@"timeOfDay"];
    [aCoder encodeObject:self.assignmentCategories forKey:@"assignmentCategories"];
    [aCoder encodeObject:self.toDoItems forKey:@"toDoItems"];
    [aCoder encodeInteger:self.toDoItemsCount forKey:@"toDoItemsCount"];
    [aCoder encodeDouble:self.grade forKey:@"grade"];
}

- (NSMutableArray *)assignmentCategories
{
    if (!_assignmentCategories) {
        _assignmentCategories = [NSMutableArray array];
    }
    return _assignmentCategories;
}

- (NSMutableArray *)toDoItems
{
    if (!_toDoItems) {
        _toDoItems = [NSMutableArray array];
    }
    return _toDoItems;
}

- (NSString *)assignmentCategoryNameAtIndex:(NSInteger)index
{
    AssignmentCategory *cat = self.assignmentCategories[index];
    return cat.name;
}

- (double)grade
{
    double classWorths = 0;
    double assignCatWeights = 0;
    for (AssignmentCategory *category in self.assignmentCategories) {
        if ([category getCount]) {
            classWorths += [category calcClassWorth];
            assignCatWeights += category.weight;
        }
    }
    if (assignCatWeights) {
        return (classWorths / assignCatWeights) * 100.0;
    }
    return 0.0;
}

- (AssignmentCategory *)assignmentCategoryAtIndex:(NSInteger)index
{
    return self.assignmentCategories[index];
}

- (void)addAssignmentCategory:(AssignmentCategory *)category
{
    if ([category isKindOfClass:[AssignmentCategory class]]) {
        [self.assignmentCategories addObject:category];
    }
}

- (void)removeAssignmentCategory:(AssignmentCategory *)category
{
    if ([category isKindOfClass:[AssignmentCategory class]]) {
        [self.assignmentCategories removeObjectIdenticalTo:category];
    }
}

- (NSInteger)getAssignmentCategoryCount
{
    return [self.assignmentCategories count];
}

- (NSString *)description
{
    NSMutableString *categories = [NSMutableString stringWithFormat:@"Categories: \n"];
    for (AssignmentCategory *category in self.assignmentCategories) {
        [categories appendString:category.name];
        [categories appendString:[NSString stringWithFormat:@" %%%.2f", category.average]];
        [categories appendString:@"\n"];
    }
    return [NSString stringWithFormat:@"%@ Grade: %%%.2f Days: %@ Time: %@ \n%@", self.name, self.grade, self.daysOfWeek, self.timeOfDay, categories];
}

- (void)dealloc
{
    NSLog(@"Being deallocated");
}

@end
