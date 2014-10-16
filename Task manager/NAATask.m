//
//  NAATask.m
//  Task manager
//
//  Created by Admin on 12.10.14.
//  Copyright (c) 2014 PlaceHolder. All rights reserved.
//

#import "NAATask.h"

@interface NAATask ()<NSCoding>

@end

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
#pragma mark -NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"taskTitle"];
    [aCoder encodeObject:self.fromDate forKey:@"fromDate"];
    [aCoder encodeObject:self.toDate forKey:@"toDate"];
    [aCoder encodeObject:self.notification forKey:@"notification"];
    [aCoder encodeBool:self.remind forKey:@"remind"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _title = [aDecoder decodeObjectForKey:@"taskTitle"];
        _fromDate = [aDecoder decodeObjectForKey:@"fromDate"];
        _toDate = [aDecoder decodeObjectForKey:@"toDate"];
        _notification = [aDecoder decodeObjectForKey:@"notification"];
        _remind = [aDecoder decodeBoolForKey:@"remind"];
    }
    return self;
}

@end
