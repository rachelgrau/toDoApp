/**
 * File: ToDoItem.h
 * -------------------------
 * Model of a "to-do Item." A to-do Item contains the title of the item (e.g. "Clean the kitchen"), a more detailed description (optional), and whether or not the item has been completed.
 */

//  Created by Rachel on 17/05/2018.
//  Copyright © 2018 Rachel. All rights reserved.


#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject
@property NSString *toDoTitle;
@property NSString *toDoDescription;
@property BOOL isCompleted;
@property BOOL isHighPriority;

/* Initializes a to-do Item with the given description, and marks it by default as incompleted. */
- (id)initWithTitle:(NSString *)toDoTitle;
@end
