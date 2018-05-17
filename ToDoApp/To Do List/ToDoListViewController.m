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
#import "Constants.h"

@interface ToDoListViewController ()

/* VIEWS */
@property (strong, nonatomic) IBOutlet UITableView *toDosTableView;
@property (strong, nonatomic) IBOutlet UITextField *addToDoTextField;
@property (strong, nonatomic) IBOutlet UIButton *addToDoButton;

/* MODELS */
@property NSMutableArray *myToDos;

@end

#define TO_DO_TABLE_VIEW_CELL_HEIGHT 50
#define TO_DO_ITEM_CELL_IDENTIFIER @"ToDoItemTableViewCellIdentifier"

@implementation ToDoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Hi";
    self.navigationItem.title = @"HI!";
    
    /* Set up add to do textfield. */
    self.addToDoTextField.placeholder = ADD_TO_DO_TEXTFIELD_PLACEHOLDER;
    self.addToDoButton.hidden = YES; // hide the add button until a user has typed something
    [self.addToDoTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    
    /* Initialize to do list model. */
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

#pragma mark – IBAction Callbacks

/* Creates a To Do Item (model) and adds it to our array of To Dos. Then reloads the table view so we display it. Also clears the textfield after adding the To Do. */
- (IBAction)addToDoButtonPressed:(id)sender {
    if (self.addToDoTextField.text.length > 0) {
        ToDoItem *toDoItem = [[ToDoItem alloc] initWithDescription:self.addToDoTextField.text];
        [self.myToDos addObject:toDoItem];
        [self.toDosTableView reloadData];
        self.addToDoTextField.text = @"";
    }
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

/* Callback for when user edits a cell. In this case we only care about deleting. */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.myToDos removeObjectAtIndex:indexPath.row];
        [self.toDosTableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TO_DO_TABLE_VIEW_CELL_HEIGHT;
}

#pragma mark – TextField Delegate

/* Callback for when the user makes a change to the text in the add to do item text field. If they have any text entered, then we'll show the "ADD" button so they can add their to do. If the textfield is empty, we hide the "ADD" button. */
- (void)textFieldDidChange:(UITextField *) textField {
    if (textField.text.length != 0) {
        self.addToDoButton.hidden = NO;
    } else {
        self.addToDoButton.hidden = YES;
    }
}

@end
