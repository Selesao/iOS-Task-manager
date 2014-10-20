//
//  NAATaskDetailViewS.m
//  Task manager
//
//  Created by Admin on 20.10.14.
//  Copyright (c) 2014 PlaceHolder. All rights reserved.
//

#import "NAATaskDetailViewS.h"

@interface NAATaskDetailViewS ()

@end

@implementation NAATaskDetailViewS

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3) {
        return 1;
    } else {
        return [super tableView:tableView numberOfRowsInSection:section];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        cell.textLabel.text = @"Repeat";
        return cell;
        
    } else {
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        <#statements#>
    } else {
        return [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end
