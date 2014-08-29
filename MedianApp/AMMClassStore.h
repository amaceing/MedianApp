//
//  AMMClassStore.h
//  Curva
//
//  Created by Anthony Mace on 6/23/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SchoolClass.h"

@interface AMMClassStore : NSObject

+ (instancetype)classStore;
- (void)addClass:(SchoolClass *)classToAdd;
- (void)addClass:(SchoolClass *)classToAdd atIndex:(NSInteger)index;
- (void)removeClass:(SchoolClass *)classToRemove;
- (SchoolClass *)getClassWithName:(NSString *)name;
- (NSArray *)allClasses;
- (NSString *)classArchivePath;
- (BOOL)saveChanges;

@end
