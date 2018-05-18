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
#import "ToDoItemViewController.h"
#import "ToDoItem.h"
#import "Constants.h"

@interface ToDoListViewController ()

/* VIEWS */
@property (strong, nonatomic) IBOutlet UITableView *toDosTableView;
@property (strong, nonatomic) IBOutlet UITextField *addToDoTextField;
@property (strong, nonatomic) IBOutlet UIButton *addToDoButton;

/* MODELS */
@property NSMutableArray *myToDos;

/* OTHER */
/* When the user selects a particular to do item, we store the index path because if they decide to edit it, we want to remember where it is so that we can update the item after they're done editing. */
@property NSIndexPath *selectedIndexPath;

@end

#define TO_DO_TABLE_VIEW_CELL_HEIGHT 64
#define TO_DO_ITEM_CELL_IDENTIFIER @"ToDoItemTableViewCellIdentifier"

@implementation ToDoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

    /* Set up add to do textfield. */
    self.addToDoTextField.placeholder = ADD_TO_DO_TEXTFIELD_PLACEHOLDER;
    self.addToDoButton.hidden = YES; // hide the add button until a user has typed something
    [self.addToDoTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    /* Make the table view not bounce */
    self.toDosTableView.bounces = NO;
    self.toDosTableView.alwaysBounceVertical = NO;

    /* This line makes it so that we don't have separator lines showing up on blank cells. */
    self.toDosTableView.tableFooterView = [UIView new];
    
    /* Add a tap gesture recognizer so that when they're typing in a textfield they can hide the keyboard by tapping outside of it.  */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    /* This line gets rid of a bit of padding at the top of the table view.. */
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    /* Initialize to do list model. */
    [self loadToDos];
    
    [self setUpColors];
}

/* Loads in our list of To Dos from user defaults. This just a hack – in reality I would load them from an API. */
- (void)loadToDos {
    NSData *toDosData = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_TO_DOS_KEY];
    if (toDosData != nil) {
        NSArray *savedArray = [NSKeyedUnarchiver unarchiveObjectWithData:toDosData];
        self.myToDos = [savedArray mutableCopy];
    } else {
        self.myToDos = [[NSMutableArray alloc] init];
    }
}

/* Saves our list of To Dos to user defaults. Similarly, I wouldn't actually do this, I would call an API (and wouldn't save ALL reminders at once, just update individual reminders). */
- (void)saveToDos {
    NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:self.myToDos];
    [[NSUserDefaults standardUserDefaults] setObject:dataSave forKey:USER_DEFAULTS_TO_DOS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setUpColors {
    [self.addToDoButton setTitleColor:TO_DO_APP_BLUE forState:UIControlStateNormal];
    self.addToDoTextField.textColor = TO_DO_APP_TEXT_GRAY;
    self.addToDoTextField.tintColor = TO_DO_APP_BLUE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark – IBAction Callbacks

/* Creates a To Do Item (model) and adds it to our array of To Dos. Then reloads the table view so we display it. Also clears the textfield after adding the To Do. */
- (IBAction)addToDoButtonPressed:(id)sender {
    if (self.addToDoTextField.text.length > 0) {
        ToDoItem *toDoItem = [[ToDoItem alloc] initWithTitle:self.addToDoTextField.text];
        [self.myToDos addObject:toDoItem];
        [self.toDosTableView reloadData];
        self.addToDoTextField.text = @"";
        self.addToDoButton.hidden = YES;
        [self saveToDos]; /* Save to user defaults. Here we would ideally only save the individual reminder that was added (in an API call). */
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
    self.selectedIndexPath = indexPath;
    ToDoItemViewController *toDoItemViewController = [[ToDoItemViewController alloc] initWithNibName:@"ToDoItemViewController" bundle:nil];
    toDoItemViewController.toDoItem = [self.myToDos objectAtIndex:indexPath.row];
    toDoItemViewController.delegate = self;
    [self.toDosTableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:toDoItemViewController animated:YES];
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
        /* Hide the keyboard */
        [self.addToDoTextField resignFirstResponder];
    }
}

- (void)dismissKeyboard {
    [self.addToDoTextField resignFirstResponder];
}

#pragma mark – ToDoItem Delegate

/* This method gets called after a user clicks on a particular to do item, edits it, and presses save. */
- (void)editedToDoItem:(ToDoItem *)toDoItem {
    [self.myToDos replaceObjectAtIndex:self.selectedIndexPath.row withObject:toDoItem];
    [self saveToDos]; /* Save to user defaults. Here we would ideally only save the individual reminder that was changed (in an API call). */
    [self.toDosTableView reloadData];
}

@end
