/**
 * File: ToDoItem.h
 * -------------------------
 * Model of a "To Do Item." A To Do Item contains the description of the item (e.g. "Clean the kitchen") and whether or not the item has been completed.
 */

//  Created by Rachel on 17/05/2018.
//  Copyright © 2018 Rachel. All rights reserved.


#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject
@property NSString *toDoDescription;
@property BOOL isCompleted;
@end