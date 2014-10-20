//
//  NAATaskDetailViewR.m
//  Task manager
//
//  Created by Admin on 11.10.14.
//  Copyright (c) 2014 PlaceHolder. All rights reserved.
//

#import "NAATaskDetailView.h"
#import "NAADateCell.h"
#import "NAATextFieldCell.h"
#import "NAATaskStore.h"
#import "NAATask.h"

@interface NAATaskDetailView () <UITextFieldDelegate>

@property (nonatomic) NSTimeInterval taskDuration;

@end

@implementation NAATaskDetailView

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        

    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"NAADateCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"NAADateCell"];
    [self.tableView registerClass:[NAATextFieldCell class] forCellReuseIdentifier:@"NAATextFieldCell"];
    self.taskDuration = [self.task.toDate timeIntervalSinceDate:self.task.fromDate];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return 2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        NAATextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NAATextFieldCell" forIndexPath:indexPath];
        cell.textField.placeholder = @"Title";
        cell.textField.delegate = self;
        cell.textField.returnKeyType = UIReturnKeyDone;
        return cell;
    } else {
        NAADateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NAADateCell" forIndexPath:indexPath];
        switch (indexPath.row) {
            case 0:
            {
                cell.dateLabel.text = @"Starts";
                cell.datePicker.date = self.task.fromDate;
                cell.dateText.text = [cell.dateFormatter stringFromDate:cell.datePicker.date];
                
                //Presetving same task duration
                cell.actionBlock = ^{
                    NSIndexPath *fromDateCellIndex = [NSIndexPath indexPathForRow:0 inSection:1];
                    NSIndexPath *toDateCellIndex = [NSIndexPath indexPathForRow:1 inSection:1];
                    
                    NAADateCell *fromDateCell = (NAADateCell *) [self.tableView cellForRowAtIndexPath:fromDateCellIndex];
                    NAADateCell *toDateCell = (NAADateCell *) [self.tableView cellForRowAtIndexPath:toDateCellIndex];
                    toDateCell.datePicker.date = [fromDateCell.datePicker.date dateByAddingTimeInterval:self.taskDuration];
                    toDateCell.dateText.text = [toDateCell.dateFormatter stringFromDate:toDateCell.datePicker.date];

                    NSLog(@"%f", self.taskDuration);
                };
                break;
            }
            case 1:
            {
                cell.dateLabel.text = @"Ends";
                cell.datePicker.date = self.task.toDate;
                cell.dateText.text = [cell.dateFormatter stringFromDate:cell.datePicker.date];
                

                cell.actionBlock = ^{
                    NSIndexPath *fromDateCellIndex = [NSIndexPath indexPathForRow:0 inSection:1];
                    NSIndexPath *toDateCellIndex = [NSIndexPath indexPathForRow:1 inSection:1];
                    
                    NAADateCell *fromDateCell = (NAADateCell *) [self.tableView cellForRowAtIndexPath:fromDateCellIndex];
                    NAADateCell *toDateCell = (NAADateCell *) [self.tableView cellForRowAtIndexPath:toDateCellIndex];
                    //Preventing negative task duration
                    if ([fromDateCell.datePicker.date compare:toDateCell.datePicker.date] == NSOrderedDescending) {
                        fromDateCell.datePicker.date = toDateCell.datePicker.date;
                        fromDateCell.dateText.text = [fromDateCell.dateFormatter stringFromDate:fromDateCell.datePicker.date];
                        
                    }
                    //Update new task duration
                    self.taskDuration = [toDateCell.datePicker.date timeIntervalSinceDate:fromDateCell.datePicker.date];
                    NSLog(@"%f", self.taskDuration);
                };
                break;
            }
        }
        
        return cell;
        
    }
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Change size of selected row
    if ([indexPath isEqual:tableView.indexPathForSelectedRow] && indexPath.section == 1) {
        return 280;
    } else {
        return 44;
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Deselect selected row on tap
    if ([indexPath isEqual:tableView.indexPathForSelectedRow]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [tableView beginUpdates];
        [tableView endUpdates];
        return nil;
    }
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Update table view for animated height change of selected row
    [tableView beginUpdates];
    [tableView endUpdates];
    
    //Dismiss keyboard on selecting other cell
    if (indexPath.section != 0) {
        [self.view endEditing:YES];
    }


}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Setup navigation bar title and buttons
    self.navigationItem.title = self.task.title;
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveTask)];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelChanges)];
    self.navigationItem.rightBarButtonItem = done;
    self.navigationItem.leftBarButtonItem = cancel;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
#pragma mark -Naviagation bar action methods
- (void)saveTask
{
    NSIndexPath *textCellIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *fromDateCellIndex = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *toDateCellIndex = [NSIndexPath indexPathForRow:1 inSection:1];
    
    NAATextFieldCell *textCell = (NAATextFieldCell *) [self.tableView cellForRowAtIndexPath:textCellIndex];
    NAADateCell *fromDateCell = (NAADateCell *) [self.tableView cellForRowAtIndexPath:fromDateCellIndex];
    NAADateCell *toDateCell = (NAADateCell *) [self.tableView cellForRowAtIndexPath:toDateCellIndex];
    if (![textCell.textField.text isEqualToString:@""]) {
        self.task.title = textCell.textField.text;
    }
    self.task.fromDate = fromDateCell.datePicker.date;
    self.task.toDate = toDateCell.datePicker.date;
    
    //Adding notification
    UILocalNotification *taskNotification = self.task.notification;
    taskNotification = [[UILocalNotification alloc] init];
    taskNotification.alertBody = self.task.title;
    taskNotification.fireDate = self.task.fromDate;
    taskNotification.soundName = UILocalNotificationDefaultSoundName;
    taskNotification.alertAction = self.task.title;
    [[UIApplication sharedApplication] scheduleLocalNotification:taskNotification];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)cancelChanges
{
    if (self.isNew) {
        [[NAATaskStore sharedStore] removeTask:self.task];
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
