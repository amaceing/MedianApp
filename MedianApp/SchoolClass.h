//
//  SchoolClass.h
//  ModelClasses
//
//  Created by Anthony Mace on 6/3/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AssignmentCategory.h"

@interface SchoolClass : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *daysOfWeek;
@property (nonatomic, copy) NSString *timeOfDay;
@property (nonatomic, copy) NSMutableArray *assignmentCategories;
@property (nonatomic, copy) NSMutableArray *toDoItems;
@property (nonatomic) int toDoItemsCount;
@property (nonatomic) double grade;

//Designated Initializer
- (instancetype)initWithName:(NSString *)name
                  daysOfWeek:(NSString *)days
                   timeOfDay:(NSString *)time;

- (void)addAssignmentCategory:(AssignmentCategory *)category;
- (void)removeAssignmentCategory:(AssignmentCategory *)category;
- (NSInteger)getAssignmentCategoryCount;
- (NSString *)assignmentCategoryNameAtIndex:(NSInteger)index;
- (AssignmentCategory *)assignmentCategoryAtIndex:(NSInteger)index;

@end
