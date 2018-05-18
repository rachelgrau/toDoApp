/**
 * File: ToDoItemTableViewCell.h
 * ------------------------------
 * A Table View Cell that displays one to do list item. Displays a description and a button that allows the user to mark the cell as completed.
 */

//  Created by Rachel on 17/05/2018.
//  Copyright © 2018 Rachel. All rights reserved.

#import <UIKit/UIKit.h>
#import "ToDoItem.h"

/* Delegate method which we'll call when the user clicks "save." */
@protocol ToDoItemTableViewCellDelegate
- (void)markedItemAsComplete:(ToDoItem *)toDoItem;
@end

@interface ToDoItemTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *toDoDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIButton *completeItemButton;
@property (strong, nonatomic) IBOutlet UIImageView *urgentIcon;

@property (weak, nonatomic) id delegate;
/* Given a ToDoItem, updates the views on this cell with the information stored in |toDoItem|. Updates the description label to display the description of the to do item and updates the check mark image to be either checked or unchecked depending on whether |toDoItem| is completed. */
- (void)setUpCellWithToDoItem:(ToDoItem *)toDoItem;

@end
