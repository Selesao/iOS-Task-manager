//
//  NAATaskStore.h
//  Task manager
//
//  Created by Admin on 11.10.14.
//  Copyright (c) 2014 PlaceHolder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NAATask.h"

@interface NAATaskStore : NSObject


@property (nonatomic, strong) NSArray* daysOfWeek;
@property (nonatomic, strong) NSManagedObjectContext* context;
@property (nonatomic, strong) NSManagedObjectModel* model;
@property (nonatomic, readonly) NSArray* allTasks;


+ (instancetype)sharedStore;
- (NAATask *)createTask;
- (void)removeTask:(NAATask *)taskToRemove;
- (BOOL)saveChanges;
- (NSArray *)tasksInWeekday:(int)weekdayNum;

@end
