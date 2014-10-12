//
//  NAATaskCell.h
//  Task manager
//
//  Created by Admin on 11.10.14.
//  Copyright (c) 2014 PlaceHolder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NAATaskCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
