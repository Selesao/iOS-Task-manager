//
//  NAATask.m
//  Task manager
//
//  Created by Admin on 12.10.14.
//  Copyright (c) 2014 PlaceHolder. All rights reserved.
//

#import "NAATask.h"

@implementation NAATask

- (instancetype)init
{
    //Setting default task properties
    NSString *title = @"New Task";
    NSDate *fromDate = [NSDate date];
    NSDate *toDate = [NSDate date];
    
    self = [self initWithTitle:title fromDate:fromDate toDate:toDate];
    return self;
}

- (instancetype)initWithTitle:(NSString*)title fromDate:(NSDate*)fromDate toDate:(NSDate*)toDate
{
    self = [super init];
    if (self) {
        self.title = title;
        self.fromDate = fromDate;
        self.toDate = toDate;
    }
    return self;
}

@end
