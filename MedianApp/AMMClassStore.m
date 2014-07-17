//
//  AMMClassStore.m
//  Curva
//
//  Created by Anthony Mace on 6/23/14.
//  Copyright (c) 2014 Amaceing Studios. All rights reserved.
//

#import "AMMClassStore.h"

@interface AMMClassStore ()

@property (nonatomic) NSMutableArray *classList;

@end

@implementation AMMClassStore

+ (instancetype)classStore
{
    static AMMClassStore *classStore = nil;
    if (!classStore) {
        classStore = [[self alloc] initPrivate];
    }
    return classStore;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        NSString *path = [self classArchivePath];
        _classList = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if (!_classList) {
            _classList = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[AMMClassStore classStore]" userInfo:nil];
    return nil;
}

- (NSString *)classArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:@"classes.archive"];
}

- (BOOL)saveChanges
{
    NSString *path = [self classArchivePath];
    return [NSKeyedArchiver archiveRootObject:self.classList toFile:path];
}

- (NSArray *)allClasses
{
    return self.classList;
}

- (void)addClass:(SchoolClass *)classToAdd
{
    if ([classToAdd isKindOfClass:[SchoolClass class]]) {
        [self.classList addObject:classToAdd];
    }
}

- (SchoolClass *)getClassWithName:(NSString *)name
{
    for (SchoolClass *sc in self.classList) {
        if ([sc.name isEqualToString:name]) {
            return sc;
        }
    }
    return nil;
}

- (void)removeClass:(SchoolClass *)classToRemove
{
    if ([classToRemove isKindOfClass:[SchoolClass class]]) {
        [self.classList removeObjectIdenticalTo:classToRemove];
    }
}

@end
