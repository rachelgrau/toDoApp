/**
 * File: ToDoItemViewController.h
 * ------------------------------
 * Displays a single to-do item: its title, details, and an option to mark it as urgent.
 */

//  Created by Rachel on 17/05/2018.
//  Copyright © 2018 Rachel. All rights reserved.

#import <UIKit/UIKit.h>
#import "ToDoItem.h"

/* Delegate method which we'll call when the user clicks "save." */
@protocol ToDoItemDelegate
- (void)editedToDoItem:(ToDoItem *)toDoItem;
@end

@interface ToDoItemViewController : UIViewController <UITextFieldDelegate>
@property ToDoItem *toDoItem;
@property (weak, nonatomic) id delegate;
@end
