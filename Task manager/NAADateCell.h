//
//  NAADateCell.h
//  Task manager
//
//  Created by Admin on 12.10.14.
//  Copyright (c) 2014 PlaceHolder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NAADateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateText;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, copy) void (^actionBlock)(void);
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end
