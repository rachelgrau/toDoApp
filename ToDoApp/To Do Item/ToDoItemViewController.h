/**
 * File: ToDoItemViewController.h
 * ------------------------------
 * Displays a single to do item: its title, details, and an option to mark it as urgent.
 */

//  Created by Rachel on 17/05/2018.
//  Copyright © 2018 Rachel. All rights reserved.

#import <UIKit/UIKit.h>
#import "ToDoItem.h"

@interface ToDoItemViewController : UIViewController
@property ToDoItem *toDoItem;
@end
