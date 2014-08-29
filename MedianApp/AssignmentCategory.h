//
//  AssignmentCategory.h
//  ModelClasses
//
//  Created by Anthony Mace on 6/2/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Assignment.h"

@interface AssignmentCategory : NSObject <NSCoding>

@property (nonatomic, copy) NSMutableArray *assignmentList;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) double average;
@property (nonatomic) double weight;

//Designated Initializer
- (instancetype)initWithName:(NSString *)name withWeight:(double)weight;

//Class Methods
- (void)addAssignment:(Assignment *)assignment;
- (void)addAssignment:(Assignment *)assignment atIndex:(NSInteger)index;
- (void)removeAssignment:(Assignment *)assignment;
- (double)calcClassWorth;
- (NSInteger)getIndex:(Assignment *)assignment;
- (NSInteger)getCount;
- (Assignment *)assignmentAtIndex:(NSInteger)index;
- (void)moveAssignmentAtIndex:(NSUInteger)from toIndex:(NSUInteger)to;
@end
