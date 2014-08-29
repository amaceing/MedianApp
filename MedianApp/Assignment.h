//
//  Assignment.h
//  ModelClasses
//
//  Created by Anthony Mace on 6/2/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Assignment : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic) double gradeEarned;
@property (nonatomic) double pointsEarned;
@property (nonatomic) double pointsPossible;

//Designated initalizer
- (instancetype)initWithName:(NSString *)name gradeEarned:(double)grade;
+ (Assignment *)createAssign;

@end
