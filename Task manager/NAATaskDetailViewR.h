//
//  NAATaskDetailViewR.h
//  Task manager
//
//  Created by Admin on 11.10.14.
//  Copyright (c) 2014 PlaceHolder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NAATask.h"

@interface NAATaskDetailViewR : UITableViewController

@property (nonatomic, strong) NAATask* task;
@property (nonatomic) BOOL isNew;

@end
