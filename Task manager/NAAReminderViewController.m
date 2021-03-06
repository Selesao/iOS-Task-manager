//
//  NAAReminderViewController.m
//  Task manager
//
//  Created by Admin on 11.10.14.
//  Copyright (c) 2014 PlaceHolder. All rights reserved.
//

#import "NAAReminderViewController.h"
#import "NAATaskStore.h"
#import "NAATaskCell.h"
#import "NAATaskDetailViewR.h"

@interface NAAReminderViewController ()

- (void)addTask;
@end

@implementation NAAReminderViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //Setting up navigation bar
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Reminder";
        UIBarButtonItem *addTask = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                    target:self
                                    action:@selector(addTask)];
        navItem.rightBarButtonItem = addTask;
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"NAATaskCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"NAATaskCell"];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[NAATaskStore sharedStore] allTasks] count];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NAATaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NAATaskCell" forIndexPath:indexPath];
    NSArray *tasks = [[NAATaskStore sharedStore] allTasks];
    NAATask *task = tasks[indexPath.row];
    cell.titleLabel.text = task.title;
    //Format date for user output
    static NSDateFormatter *dateFormatterDay; //Format date to show day
    if (!dateFormatterDay) {
        dateFormatterDay = [[NSDateFormatter alloc] init];
        dateFormatterDay.dateStyle = NSDateFormatterMediumStyle;
        dateFormatterDay.timeStyle = NSDateFormatterNoStyle;
    }
    static NSDateFormatter *dateFormatterTime; // Format date to show time
    if (!dateFormatterTime) {
        dateFormatterTime = [[NSDateFormatter alloc] init];
        dateFormatterTime.dateStyle = NSDateFormatterNoStyle;
        dateFormatterTime.timeStyle = NSDateFormatterShortStyle;
    }
    cell.dayLabel.text = [dateFormatterDay stringFromDate:task.fromDate];
    cell.timeLabel.text = [dateFormatterTime stringFromDate:task.fromDate];
    
    
    return cell;
}

- (void)addTask
{
    NAATask *newTask = [[NAATaskStore sharedStore] createTask];
    NAATaskDetailViewR *detailView = [[NAATaskDetailViewR alloc] init];
    detailView.task = newTask;
    detailView.isNew = YES;
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:detailView];
    
    [self presentViewController:navController animated:YES completion:nil];
    
}

#pragma mark -My methods

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *allTasks = [[NAATaskStore sharedStore] allTasks];
    NAATask *selectedTask = allTasks[indexPath.row];
    NAATaskDetailViewR *detailView = [[NAATaskDetailViewR alloc] init];
    detailView.task = selectedTask;
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:detailView];
    
    [self presentViewController:navController animated:YES completion:nil];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *allTasks = [[NAATaskStore sharedStore] allTasks];
        NAATask *taskToDelete = allTasks[indexPath.row];
        [[NAATaskStore sharedStore] removeTask:taskToDelete];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
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
