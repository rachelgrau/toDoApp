/**
 * File: ToDoItem.m
 * -------------------------
 * Model of a "to-do Item." A to-do Item contains the description of the item (e.g. "Clean the kitchen") and whether or not the item has been completed.
 */

//  Created by Rachel on 17/05/2018.
//  Copyright © 2018 Rachel. All rights reserved.

#import "ToDoItem.h"
#import "Constants.h"

@implementation ToDoItem

- (id)initWithTitle:(NSString *)toDoTitle {
    self = [super init];
    if (self) {
        self.toDoTitle = toDoTitle;
        self.isCompleted = NO;
        self.isHighPriority = NO;
    }
    return self;
}

/* So we can load from NSUserDefaults*/
- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.toDoTitle = [decoder decodeObjectForKey:USER_DEFAULTS_TO_DO_TITLE_KEY];
    self.toDoDescription = [decoder decodeObjectForKey:USER_DEFAULTS_TO_DO_DESCRIPTION_KEY];
    self.isCompleted = [decoder decodeBoolForKey:USER_DEFAULTS_TO_DO_IS_COMPLETED_KEY];
    self.isHighPriority = [decoder decodeBoolForKey:USER_DEFAULTS_TO_DO_IS_HIGH_PRIORITY_KEY];
    
    return self;
}

/* So we can store in NSUserDefaults*/
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.toDoTitle forKey:USER_DEFAULTS_TO_DO_TITLE_KEY];
    [encoder encodeObject:self.toDoDescription forKey:USER_DEFAULTS_TO_DO_DESCRIPTION_KEY];
    [encoder encodeBool:self.isCompleted forKey:USER_DEFAULTS_TO_DO_IS_COMPLETED_KEY];
    [encoder encodeBool:self.isHighPriority forKey:USER_DEFAULTS_TO_DO_IS_HIGH_PRIORITY_KEY];
}

- (NSString*)description {
    return [NSString stringWithFormat:@"\Title %@\Description: %@\Is Completed:%d\r", self.toDoTitle, self.toDoDescription, self.isCompleted];
}


@end
