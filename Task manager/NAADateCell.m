//
//  NAADateCell.m
//  Task manager
//
//  Created by Admin on 12.10.14.
//  Copyright (c) 2014 PlaceHolder. All rights reserved.
//

#import "NAADateCell.h"

@interface NAADateCell()


@end

@implementation NAADateCell


    


- (void)awakeFromNib
{
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    self.dateFormatter.timeStyle = NSDateFormatterShortStyle;
    self.dateText.text = [self.dateFormatter stringFromDate:[NSDate date]];
    
}

- (IBAction)datePIcked:(id)sender {
    self.dateText.text = [self.dateFormatter stringFromDate:self.datePicker.date];
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
