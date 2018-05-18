/**
 * File: ToDoListViewController.m
 * ------------------------------
 * This view controller displays one list of "to-dos."
 * User can add a new "to-do"
 * User can delete a "to-do"
 * User can check a "to-do" as completed
 */

//  Created by Rachel on 17/05/2018.
//  Copyright © 2018 Rachel. All rights reserved.

#import "ToDoListViewController.h"
#import "ToDoItemTableViewCell.h"
#import "ToDoItemViewController.h"
#import "NoMoreToDosTableViewCell.h"
#import "ToDoItem.h"
#import "Constants.h"

@interface ToDoListViewController ()

/* VIEWS */
@property (strong, nonatomic) IBOutlet UITableView *toDosTableView;
@property (strong, nonatomic) IBOutlet UITextField *addToDoTextField;
@property (strong, nonatomic) IBOutlet UIButton *addToDoButton;

/* MODELS */
@property NSMutableArray *outstandingTodos; /* to-dos that haven't been completed. */
@property NSMutableArray *completedTodos; /* to-dos that have been completed. */

/* OTHER */
/* When the user selects a particular to-do item, we store the index path because if they decide to edit it, we want to remember where it is so that we can update the item after they're done editing. */
@property NSIndexPath *selectedIndexPath;

@end

#define TO_DO_TABLE_VIEW_CELL_HEIGHT 64
#define TO_DO_ITEM_CELL_IDENTIFIER @"ToDoItemTableViewCellIdentifier"
#define NO_MORE_TO_DOS_CELL_IDENTIFIER @"NoMoreToDosTableViewCellIdentifier"

#define OUTSTANDING_TO_DOS_SECTION 0
#define COMPLETED_TO_DOS_SECTION 1

@implementation ToDoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

    /* Set up add to-do textfield. */
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
    
    /* Initialize to-do list model. */
    [self loadToDos];
    
    [self setUpColors];
}

/* Loads in our list of to-dos from user defaults. This just a hack – in reality I would load them from an API. */
- (void)loadToDos {
    /* Load outstanding to-dos */
    NSData *outstandingTodosData = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_OUTSTANDING_TO_DOS_KEY];
    if (outstandingTodosData != nil) {
        NSArray *savedArray = [NSKeyedUnarchiver unarchiveObjectWithData:outstandingTodosData];
        self.outstandingTodos = [savedArray mutableCopy];
    } else {
        self.outstandingTodos = [[NSMutableArray alloc] init];
    }
    
    /* Load completed to-dos */
    NSData *completedTodosData = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_COMPLETED_TO_DOS_KEY];
    if (completedTodosData != nil) {
        NSArray *savedArray = [NSKeyedUnarchiver unarchiveObjectWithData:completedTodosData];
        self.completedTodos = [savedArray mutableCopy];
    } else {
        self.completedTodos = [[NSMutableArray alloc] init];
    }
}

/* Saves our list of to-dos to user defaults. Similarly, I wouldn't actually do this, I would call an API (and wouldn't save ALL reminders at once, just update individual reminders). */
- (void)saveToDos {
    NSData *outstandingToDosDataToSave = [NSKeyedArchiver archivedDataWithRootObject:self.outstandingTodos];
    [[NSUserDefaults standardUserDefaults] setObject:outstandingToDosDataToSave forKey:USER_DEFAULTS_OUTSTANDING_TO_DOS_KEY];
    
    NSData *completedToDosDataToSave = [NSKeyedArchiver archivedDataWithRootObject:self.completedTodos];
    [[NSUserDefaults standardUserDefaults] setObject:completedToDosDataToSave forKey:USER_DEFAULTS_COMPLETED_TO_DOS_KEY];
    
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

/* Creates a to-do Item (model) and adds it to our array of to-dos. Then reloads the table view so we display it. Also clears the textfield after adding the to-do. */
- (IBAction)addToDoButtonPressed:(id)sender {
    if (self.addToDoTextField.text.length > 0) {
        ToDoItem *toDoItem = [[ToDoItem alloc] initWithTitle:self.addToDoTextField.text];
        [self.outstandingTodos addObject:toDoItem];
        [self.toDosTableView reloadData];
        self.addToDoTextField.text = @"";
        self.addToDoButton.hidden = YES;
        [self saveToDos]; /* Save to user defaults. Here we would ideally only save the individual reminder that was added (in an API call). */
    }
}

#pragma mark – TableView Delegate and Data Source

/* There are 2 sections: to-do and COMPLETED. If the completed section has no items, we don't display it at all. */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.completedTodos.count > 0) {
        return 2;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.toDosTableView) {
        if (section == OUTSTANDING_TO_DOS_SECTION) {
            if (self.outstandingTodos.count == 0) {
                /* If there are no outstanding to-dos, we display a special cell that lets the user know they have no to-dos left. */
                return 1;
            } else {
                return self.outstandingTodos.count;
            }
        } else if (section == COMPLETED_TO_DOS_SECTION) {
            return self.completedTodos.count;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.toDosTableView) {
        if ((indexPath.section == OUTSTANDING_TO_DOS_SECTION) && (self.outstandingTodos.count == 0)) {
            /* If it's the outstanding to-dos section and we don't have outstanding to-dos, display a special cell that lets the user know that. */
            NoMoreToDosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NO_MORE_TO_DOS_CELL_IDENTIFIER];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NoMoreToDosTableViewCell" owner:self options:nil];
                cell = (NoMoreToDosTableViewCell *)[nib objectAtIndex:0];
            }
            return cell;
        } else {
            /* Display normal to-do cell. */
            ToDoItemTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:TO_DO_ITEM_CELL_IDENTIFIER];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ToDoItemTableViewCell" owner:self options:nil];
                cell = (ToDoItemTableViewCell *)[nib objectAtIndex:0];
            }
            cell.delegate = self;
            ToDoItem *itemToDisplay;
            if (indexPath.section == OUTSTANDING_TO_DOS_SECTION) {
                itemToDisplay = [self.outstandingTodos objectAtIndex:indexPath.row];
            } else if (indexPath.section == COMPLETED_TO_DOS_SECTION) {
                itemToDisplay = [self.completedTodos objectAtIndex:indexPath.row];
            }
            [cell setUpCellWithToDoItem:itemToDisplay];
            return cell;
        }
    }
    return nil;
}

/* All cells are "editable" except for the special cell that we display if the user has no outstanding to-dos. */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if ((indexPath.section == OUTSTANDING_TO_DOS_SECTION) && (self.outstandingTodos.count == 0)) {
        return NO;
    }
    return YES;
}

/* Callback for when user edits a cell. In this case we only care about deleting. */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == OUTSTANDING_TO_DOS_SECTION) {
            if (self.outstandingTodos.count > 0) {
                [self.outstandingTodos removeObjectAtIndex:indexPath.row];
            }
        } else if (indexPath.section == COMPLETED_TO_DOS_SECTION) {
            [self.completedTodos removeObjectAtIndex:indexPath.row];
        }
        [self.toDosTableView reloadData];
        [self saveToDos];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndexPath = indexPath;
    ToDoItemViewController *toDoItemViewController = [[ToDoItemViewController alloc] initWithNibName:@"ToDoItemViewController" bundle:nil];
    if (indexPath.section == OUTSTANDING_TO_DOS_SECTION) {
        if (self.outstandingTodos.count > 0) {
            toDoItemViewController.toDoItem = [self.outstandingTodos objectAtIndex:indexPath.row];
        }
    } else if (indexPath.section == COMPLETED_TO_DOS_SECTION) {
        toDoItemViewController.toDoItem = [self.completedTodos objectAtIndex:indexPath.row];
    }
    toDoItemViewController.delegate = self;
    [self.toDosTableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:toDoItemViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TO_DO_TABLE_VIEW_CELL_HEIGHT;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(24, 5, tableView.frame.size.width, 18)];
    label.font = [UIFont fontWithName:@"Raleway-Bold" size:12.0];
    label.textColor = [UIColor whiteColor];
    if (section == OUTSTANDING_TO_DOS_SECTION) {
        label.text = @"TO-DOS";
    } else {
        label.text = @"COMPLETED";
    }
    [view addSubview:label];
    [view setBackgroundColor:TO_DO_APP_LIGHTEST_GRAY];
    return view;
}

#pragma mark – TextField Delegate

/* Callback for when the user makes a change to the text in the add to-do item text field. If they have any text entered, then we'll show the "ADD" button so they can add their to-do. If the textfield is empty, we hide the "ADD" button. */
- (void)textFieldDidChange:(UITextField *) textField {
    if (textField.text.length != 0) {
        self.addToDoButton.hidden = NO;
    } else {
        self.addToDoButton.hidden = YES;
        /* Hide the keyboard */
        [self.addToDoTextField resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [self addToDoButtonPressed:nil];
    [aTextField resignFirstResponder];
    return YES;
}

- (void)dismissKeyboard {
    [self.addToDoTextField resignFirstResponder];
}

#pragma mark – ToDoItemCell Delegate

/* Called when the user checks or unchecks the checkbox for the given |toDoItem|. In this case we want to swap the to-do from one section to another (outstanding to completed or vice versa). We also want to update our data model and save it. */
- (void)markedItemAsComplete:(ToDoItem *)toDoItem {
    if (toDoItem.isCompleted) {
        [self.outstandingTodos removeObject:toDoItem];
        [self.completedTodos addObject:toDoItem];
    } else {
        [self.completedTodos removeObject:toDoItem];
        [self.outstandingTodos addObject:toDoItem];
    }
    [self.toDosTableView reloadData];
    [self saveToDos];
}

#pragma mark – ToDoItem Delegate

/* This method gets called after a user clicks on a particular to-do item, edits it, and presses save. */
- (void)editedToDoItem:(ToDoItem *)toDoItem {
    if (self.selectedIndexPath.section == 0) {
        /* First section. If there are no outstanding to-dos, then this is the only section – the completed section. */
        if (self.outstandingTodos.count == 0) {
            [self.completedTodos replaceObjectAtIndex:self.selectedIndexPath.row withObject:toDoItem];
        } else {
            [self.outstandingTodos replaceObjectAtIndex:self.selectedIndexPath.row withObject:toDoItem];
        }
    } else if (self.selectedIndexPath.section == 1) {
        [self.completedTodos replaceObjectAtIndex:self.selectedIndexPath.row withObject:toDoItem];
    }
    [self saveToDos]; /* Save to user defaults. Here we would ideally only save the individual reminder that was changed (in an API call). */
    [self.toDosTableView reloadData];
}

@end
