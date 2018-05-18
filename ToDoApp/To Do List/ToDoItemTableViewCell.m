/**
 * File: ToDoItemTableViewCell.m
 * ------------------------------
 * A Table View Cell that displays one to do list item. Displays a description and a button that allows the user to mark the cell as completed.
 */

//  Created by Rachel on 17/05/2018.
//  Copyright © 2018 Rachel. All rights reserved.

#import "ToDoItemTableViewCell.h"
#import "Constants.h"

@interface ToDoItemTableViewCell ()
@property ToDoItem *toDoItem;
@end

@implementation ToDoItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/* Given a ToDoItem, updates the views on this cell with the information stored in |toDoItem|. Updates the description label to display the description of the to do item and updates the check mark image to be either checked or unchecked depending on whether |toDoItem| is completed. */
- (void)setUpCellWithToDoItem:(ToDoItem *)toDoItem {
    self.toDoItem = toDoItem;
    
    /* Update description of to do item. */
    self.toDoDescriptionLabel.text = toDoItem.toDoTitle;

    /* Update check mark depending on whether item has been completed. */
    if (toDoItem.isCompleted) {
        [self.completeItemButton setBackgroundImage:[UIImage imageNamed:CHECKED_CIRLCE] forState:UIControlStateNormal];
    } else {
        [self.completeItemButton setBackgroundImage:[UIImage imageNamed:UNCHECKED_CIRCLE] forState:UIControlStateNormal];
    }
}

- (IBAction)checkButtonPressed:(id)sender {
    /* Update check mark image depending on whether item has been completed. */
    if (self.toDoItem.isCompleted) {
        [self.completeItemButton setBackgroundImage:[UIImage imageNamed:UNCHECKED_CIRCLE] forState:UIControlStateNormal];
        self.toDoItem.isCompleted = NO;
    } else {
        [self.completeItemButton setBackgroundImage:[UIImage imageNamed:CHECKED_CIRLCE] forState:UIControlStateNormal];
        self.toDoItem.isCompleted = YES;
    }
    
    if ([self.delegate respondsToSelector:@selector(markedItemAsComplete:)]) {
        [self.delegate markedItemAsComplete:self.toDoItem];
    }
}


@end
