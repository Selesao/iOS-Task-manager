//
//  NAATaskStore.m
//  Task manager
//
//  Created by Admin on 11.10.14.
//  Copyright (c) 2014 PlaceHolder. All rights reserved.
//

#import "NAATaskStore.h"
#import "NAATask.h"

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

    return self;
}

- (NSArray *)allTasks
{
    NAATask *newTask = [[NAATask alloc] init];
    newTask.title = @"My name";
    newTask.fromDate = [NSDate date];
    newTask.toDate = [NSDate date];
    NSArray *newArray = @[newTask];
    return newArray;
//    return [self.privateTasks copy];
}



@end
