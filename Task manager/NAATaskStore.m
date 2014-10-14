//
//  NAATaskStore.m
//  Task manager
//
//  Created by Admin on 11.10.14.
//  Copyright (c) 2014 PlaceHolder. All rights reserved.
//

#import "NAATaskStore.h"


@interface NAATaskStore()

@property (nonatomic, strong) NSMutableArray* privateTasks;

@end



@implementation NAATaskStore

#pragma mark -Singleton

+ (instancetype)sharedStore
{
    static NAATaskStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[NAATaskStore alloc] initPrivate];
    }
    return sharedStore;
    
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use + [NAATaskStore sharedStore]" userInfo:nil];
    return nil;
    
    
}

- (instancetype)initPrivate
{
    self = [super init];
    _privateTasks = [[NSMutableArray alloc] init];

    return self;
}

- (NSArray *)allTasks
{
    return [self.privateTasks copy];
}

- (NAATask *)createTask
{
    NAATask *newTask = [[NAATask alloc] init];
    [self.privateTasks addObject:newTask];
    return newTask;
}

- (void)removeTask:(NAATask *)taskToRemove
{
    [self.privateTasks removeObjectIdenticalTo:taskToRemove];
}



@end
