//
//  NAATask.h
//  Task manager
//
//  Created by Admin on 11.10.14.
//  Copyright (c) 2014 PlaceHolder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NAATask : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * fromDate;
@property (nonatomic, retain) NSDate * toDate;
@property (nonatomic) BOOL remind;
@property (nonatomic, retain) NSSet *weekDay;
@end

@interface NAATask (CoreDataGeneratedAccessors)

- (void)addWeekDayObject:(NSManagedObject *)value;
- (void)removeWeekDayObject:(NSManagedObject *)value;
- (void)addWeekDay:(NSSet *)values;
- (void)removeWeekDay:(NSSet *)values;

@end
