//
//  NAATask.h
//  Task manager
//
//  Created by Admin on 12.10.14.
//  Copyright (c) 2014 PlaceHolder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NAATask : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSDate *fromDate;
@property (nonatomic, strong) NSDate *toDate;
@property (nonatomic) BOOL remind;


@end
