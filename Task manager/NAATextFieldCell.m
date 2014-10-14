//
//  NAATextFieldCell.m
//  Task manager
//
//  Created by Admin on 14.10.14.
//  Copyright (c) 2014 PlaceHolder. All rights reserved.
//

#import "NAATextFieldCell.h"

@implementation NAATextFieldCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        //Indent text field from left border of the cell
        CGRect textFrame = self.contentView.bounds;
        textFrame.origin.x = 20;
        textFrame.size.width -= 20;
        self.textField = [[UITextField alloc] initWithFrame:textFrame];
        
        [self.contentView addSubview:self.textField];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
