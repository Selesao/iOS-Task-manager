//
//  NAATaskDetailViewR.m
//  Task manager
//
//  Created by Admin on 11.10.14.
//  Copyright (c) 2014 PlaceHolder. All rights reserved.
//

#import "NAATaskDetailViewR.h"
#import "NAADateCell.h"
#import "NAATextFieldCell.h"
#import "NAATaskStore.h"
@interface NAATaskDetailViewR () <UITextFieldDelegate>

- (void)saveTask;
- (void)cancelChanges;

@end

@implementation NAATaskDetailViewR

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
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
                cell.dateLabel.text = @"Starts";
                cell.actionBlock = ^{
                    NSLog(@"Wow!So rolling!Much date!");
                };
                break;
            case 1:
                cell.dateLabel.text = @"Ends";
                break;
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
    if (indexPath.section == 1) {
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

- (void)saveTask
{
    NSIndexPath *textCellIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *fromDateCellIndex = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *toDateCellIndex = [NSIndexPath indexPathForRow:1 inSection:1];
    
    NAATextFieldCell *textCell = (NAATextFieldCell *) [self.tableView cellForRowAtIndexPath:textCellIndex];
    NAADateCell *fromDateCell = (NAADateCell *) [self.tableView cellForRowAtIndexPath:fromDateCellIndex];
    NAADateCell *toDateCell = (NAADateCell *) [self.tableView cellForRowAtIndexPath:toDateCellIndex];
    self.task.title = textCell.textField.text;
    self.task.fromDate = fromDateCell.datePicker.date;
    self.task.toDate = toDateCell.datePicker.date;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)cancelChanges
{
    if (self.isNew) {
        [[NAATaskStore sharedStore] removeTask:self.task];
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
