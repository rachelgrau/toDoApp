/**
 * File: ToDoItem.m
 * -------------------------
 * Model of a "To Do Item." A To Do Item contains the description of the item (e.g. "Clean the kitchen") and whether or not the item has been completed.
 */

//  Created by Rachel on 17/05/2018.
//  Copyright © 2018 Rachel. All rights reserved.

#import "ToDoItem.h"

@implementation ToDoItem

- (id)initWithTitle:(NSString *)toDoTitle {
    self = [super init];
    if (self) {
        self.toDoTitle = toDoTitle;
        self.isCompleted = NO;
    }
    return self;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"\Title %@\Description: %@\Is Completed:%d\r", self.toDoTitle, self.toDoDescription, self.isCompleted];
}


@end
