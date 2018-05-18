/**
 * File: Constants.h
 * ------------------------------
 * Contains a list of constants used throughout the app (e.g. image names).
 */

//  Created by Rachel on 17/05/2018.
//  Copyright © 2018 Rachel. All rights reserved.


#ifndef Constants_h
#define Constants_h

/* IMAGES */
#define UNCHECKED_CIRCLE @"UncheckedCircle"
#define CHECKED_CIRLCE @"CheckedCircle"
#define BACK_BUTTON @"BackButton"
#define URGENT_ICON @"UrgentIcon"

/* STRINGS */
#define ADD_TO_DO_TEXTFIELD_PLACEHOLDER @"Add a goal..."
#define TO_DO_TITLE_PLACEHOLDER @"Add a title."
#define TO_DO_DESCRIPTION_PLACEHOLDER @"Add a description."

/* COLORS */
#define TO_DO_APP_BLUE [UIColor colorWithRed:0.33 green:0.77 blue:0.90 alpha:1.0]
#define TO_DO_APP_TEXT_GRAY [UIColor colorWithRed:0.23 green:0.23 blue:0.23 alpha:1.0]
#define TO_DO_APP_GRAY [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.0]
#define TO_DO_APP_LIGHTEST_GRAY [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.0]

/* MISC */
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

/* USER DEFAULT KEYS */
#define USER_DEFAULTS_OUTSTANDING_TO_DOS_KEY @"OutstandingToDosKey"
#define USER_DEFAULTS_COMPLETED_TO_DOS_KEY @"CompletedToDosKey"
#define USER_DEFAULTS_TO_DO_TITLE_KEY @"ToDoTitleKey"
#define USER_DEFAULTS_TO_DO_DESCRIPTION_KEY @"ToDoDescriptionKey"
#define USER_DEFAULTS_TO_DO_IS_COMPLETED_KEY @"ToDoIsCompletedKey"
#define USER_DEFAULTS_TO_DO_IS_HIGH_PRIORITY_KEY @"ToDoIsHighPriorityKey"

#endif /* Constants_h */
