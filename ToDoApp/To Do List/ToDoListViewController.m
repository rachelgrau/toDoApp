/**
 * File: ToDoListViewController.m
 * ------------------------------
 * This view controller displays one list of "To Dos."
 * User can add a new "To Do"
 * User can delete a "To Do"
 * User can check a "To Do" as completed
 */

//  Created by Rachel on 17/05/2018.
//  Copyright © 2018 Rachel. All rights reserved.

#import "ToDoListViewController.h"
#import "ToDoItemTableViewCell.h"
#import "ToDoItem.h"

@interface ToDoListViewController ()
@property (strong, nonatomic) IBOutlet UITableView *toDosTableView;
@property NSMutableArray *myToDos;
@end

#define TO_DO_TABLE_VIEW_CELL_HEIGHT 50
#define TO_DO_ITEM_CELL_IDENTIFIER @"ToDoItemTableViewCellIdentifier"
@implementation ToDoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Hi";
    self.navigationItem.title = @"HI!";
    
    self.myToDos = [[NSMutableArray alloc] init];
    
    ToDoItem *item = [[ToDoItem alloc]  init];
    item.toDoDescription = @"Clean the kitchen.";
    item.isCompleted = NO;
    [self.myToDos addObject:item];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark – TableView Delegate and Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.toDosTableView) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.toDosTableView) {
        return self.myToDos.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoItemTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:TO_DO_ITEM_CELL_IDENTIFIER];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ToDoItemTableViewCell" owner:self options:nil];
        cell = (ToDoItemTableViewCell *)[nib objectAtIndex:0];
    }
    ToDoItem *itemToDisplay = [self.myToDos objectAtIndex:indexPath.row];
    [cell setUpCellWithToDoItem:itemToDisplay];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TO_DO_TABLE_VIEW_CELL_HEIGHT;
}

@end
