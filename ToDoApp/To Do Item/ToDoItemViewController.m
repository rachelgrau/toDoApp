/**
 * File: ToDoItemViewController.m
 * ------------------------------
 * Displays a single to do item: its title, details, and an option to mark it as urgent.
 */

//  Created by Rachel on 17/05/2018.
//  Copyright © 2018 Rachel. All rights reserved.

#import "ToDoItemViewController.h"
#import "Constants.h"
#import "Utilities.h"

@interface ToDoItemViewController ()

/* VIEWS */
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property UILabel *titleLabel;
@property UITextView *titleTextView;
@property UILabel *descriptionLabel;
@property UITextView *descriptionTextView;
@property UILabel *priorityTitle;
@property UILabel *priorityDescription;
@property UISwitch *highPrioritySwitch;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@end

@implementation ToDoItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    /* Add a tap gesture recognizer so that when they're typing in a textfield they can hide the keyboard by tapping outside of it.  */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

    [self layoutView];
    [self setUpColors];
}

/* Layout the view programatically because the height of the labels depends on the length of the strings. */
- (void)layoutView {
    const int LEFT_MARGIN = 36;
    const int VERTICAL_SPACE_BELOW_TITLE = 15; /* Space below a title (e.g., "DESCRIPTION" and the component that comes below it. */
    const int VERTICAL_SPACE_BETWEEN_SECTIONS = 48;
    int startingY = self.backButton.frame.origin.y + self.backButton.frame.size.height + 40; /* Will be used as the y origin for every view. */
    
    /* To do title */
    if (self.titleLabel) {
        [self.titleLabel removeFromSuperview];
    }
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, startingY, 0, 0)];
    self.titleLabel.text = @"TITLE";
    self.titleLabel.font = [UIFont fontWithName:@"Raleway-Bold" size:10.0];
    [self.titleLabel sizeToFit];
    [self.view addSubview:self.titleLabel];
    
    startingY += self.titleLabel.frame.size.height;
    startingY += VERTICAL_SPACE_BELOW_TITLE;
    
    /* To do title text view, where the user can edit the title of their to do */
    if (self.titleTextView) {
        [self.titleTextView removeFromSuperview];
    }
    UIFont *titleTextViewFont = [UIFont fontWithName:@"Raleway-ExtraLight" size:30];
    CGFloat textViewHeight = [Utilities heightOfString:self.toDoItem.toDoTitle containedToWidth:SCREEN_WIDTH - (2 * LEFT_MARGIN) withFont:titleTextViewFont]; // programatically calculate height of string.
    self.titleTextView = [[UITextView alloc] initWithFrame:CGRectMake(LEFT_MARGIN, startingY, SCREEN_WIDTH - (2 * LEFT_MARGIN), textViewHeight)];
    self.titleTextView.font = titleTextViewFont;
    self.titleTextView.delegate = self;
    self.titleTextView.text = self.toDoItem.toDoTitle;
    self.titleTextView.returnKeyType = UIReturnKeyDone;
    [self.titleTextView setTextContainerInset:UIEdgeInsetsZero];
    self.titleTextView.textContainer.lineFragmentPadding = 0; // to remove left padding
    [self.view addSubview:self.titleTextView];
    
    startingY += self.titleTextView.frame.size.height;
    startingY += VERTICAL_SPACE_BETWEEN_SECTIONS;
    
    /* To do description title */
    if (self.descriptionLabel) {
        [self.descriptionLabel removeFromSuperview];
    }
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, startingY, 0, 0)];
    self.descriptionLabel.text = @"DESCRIPTION";
    self.descriptionLabel.font = [UIFont fontWithName:@"Raleway-Bold" size:10.0];
    [self.descriptionLabel sizeToFit];
    [self.view addSubview:self.descriptionLabel];
    startingY += self.descriptionLabel.frame.size.height;
    startingY += VERTICAL_SPACE_BELOW_TITLE;
    
    /* To do description text view, where the user can edit the title of their to do */
    if (self.descriptionTextView) {
        [self.descriptionTextView removeFromSuperview];
    }
    NSString *toDoDescription = self.toDoItem.toDoDescription;
    if (toDoDescription.length <= 0) {
        toDoDescription = TO_DO_DESCRIPTION_PLACEHOLDER;
    }
    UIFont *descriptionTextViewFont = [UIFont fontWithName:@"Raleway-ExtraLight" size:20];
    CGFloat descriptionViewHeight = [Utilities heightOfString:toDoDescription containedToWidth:SCREEN_WIDTH - (2 * LEFT_MARGIN) withFont:descriptionTextViewFont]; // programatically calculate height of string.
    self.descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(LEFT_MARGIN, startingY, SCREEN_WIDTH - (2 * LEFT_MARGIN), descriptionViewHeight)];
    self.descriptionTextView.font = [UIFont fontWithName:@"Raleway-ExtraLight" size:20];
    self.descriptionTextView.text = toDoDescription;
    self.descriptionTextView.returnKeyType = UIReturnKeyDone;
    self.descriptionTextView.delegate = self;
    [self.descriptionTextView setTextContainerInset:UIEdgeInsetsZero];
    self.descriptionTextView.textContainer.lineFragmentPadding = 0; // to remove left padding
    [self.view addSubview:self.descriptionTextView];
    
    startingY += self.descriptionTextView.frame.size.height;
    startingY += VERTICAL_SPACE_BETWEEN_SECTIONS;
    
    /* To do priority title */
    if (self.priorityTitle) {
        [self.priorityTitle removeFromSuperview];
    }
    self.priorityTitle = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, startingY, 0, 0)];
    self.priorityTitle.text = @"PRIORITY";
    self.priorityTitle.font = [UIFont fontWithName:@"Raleway-Bold" size:10.0];
    [self.priorityTitle sizeToFit];
    [self.view addSubview:self.priorityTitle];
    startingY += self.priorityTitle.frame.size.height;
    startingY += VERTICAL_SPACE_BELOW_TITLE;
    
    /* To do priority description */
    if (self.priorityDescription) {
        [self.priorityDescription removeFromSuperview];
    }
    self.priorityDescription = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, startingY, 0, 0)];
    self.priorityDescription.text = @"Mark as high priority?";
    self.priorityDescription.font = [UIFont fontWithName:@"Raleway-ExtraLight" size:20];
    [self.priorityDescription sizeToFit];
    [self.view addSubview:self.priorityDescription];
    
    /* High priority switch */
    if (self.highPrioritySwitch) {
        [self.highPrioritySwitch removeFromSuperview];
    }
    self.highPrioritySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - LEFT_MARGIN - 40, startingY, 0, 0)];
    if (self.toDoItem.isHighPriority) {
        self.highPrioritySwitch.on = YES;
    } else {
        self.highPrioritySwitch.on = NO;
    }
    self.highPrioritySwitch.center = self.priorityDescription.center;
    CGRect prioritySwitchFrame = self.highPrioritySwitch.frame;
    prioritySwitchFrame.origin.x = SCREEN_WIDTH - LEFT_MARGIN - prioritySwitchFrame.size.width;
    self.highPrioritySwitch.frame = prioritySwitchFrame;
    [self.view addSubview:self.highPrioritySwitch];
    
    [self setUpColors];
}

/* Programatically sets up all the colors since we have them saved in constants. */
- (void)setUpColors {
    self.titleLabel.textColor = TO_DO_APP_TEXT_GRAY;
    if ([self.titleTextView.text isEqualToString:TO_DO_TITLE_PLACEHOLDER]) {
        self.titleTextView.textColor = TO_DO_APP_GRAY;
    } else {
        self.titleTextView.textColor = TO_DO_APP_TEXT_GRAY;
    }
    self.descriptionLabel.textColor = TO_DO_APP_TEXT_GRAY;
    self.descriptionTextView.textColor = TO_DO_APP_TEXT_GRAY;
    if ([self.descriptionTextView.text isEqualToString:TO_DO_DESCRIPTION_PLACEHOLDER]) {
        self.descriptionTextView.textColor = TO_DO_APP_GRAY;
    } else {
        self.descriptionTextView.textColor = TO_DO_APP_TEXT_GRAY;
    }
    [self.saveButton setBackgroundColor:TO_DO_APP_BLUE];
    self.descriptionTextView.tintColor = TO_DO_APP_BLUE;
    self.titleTextView.tintColor = TO_DO_APP_BLUE;
    self.priorityTitle.textColor = TO_DO_APP_TEXT_GRAY;
    self.priorityDescription.textColor = TO_DO_APP_TEXT_GRAY;
    self.highPrioritySwitch.tintColor = TO_DO_APP_BLUE;
    self.highPrioritySwitch.onTintColor = TO_DO_APP_BLUE;
}

- (IBAction)saveButtonPressed:(id)sender {
    if ([self.delegate respondsToSelector:@selector(editedToDoItem:)]) {
        /* Update the to do item and pass it to our delegate. */
        self.toDoItem.toDoTitle = self.titleTextView.text;
        if ([self.descriptionTextView.text isEqualToString:TO_DO_DESCRIPTION_PLACEHOLDER]) {
            self.toDoItem.toDoDescription = @"";
        } else {
            self.toDoItem.toDoDescription = self.descriptionTextView.text;
        }
        self.toDoItem.isHighPriority = self.highPrioritySwitch.isOn;
        [self.delegate editedToDoItem:self.toDoItem];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismissKeyboard {
    [self.titleTextView resignFirstResponder];
    [self.descriptionTextView resignFirstResponder];
}

#pragma mark - TextView Delegate

/* If they begin editing a textview, check if the text that was there was the placeholder. If so, let's clear it. */
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == self.titleTextView) {
        if ([textView.text isEqualToString:TO_DO_TITLE_PLACEHOLDER]) {
            textView.text = @"";
            textView.textColor = TO_DO_APP_TEXT_GRAY;
        }
    } else if (textView == self.descriptionTextView) {
        if ([textView.text isEqualToString:TO_DO_DESCRIPTION_PLACEHOLDER]) {
            textView.text = @"";
            textView.textColor = TO_DO_APP_TEXT_GRAY;
        }
    }
    [textView becomeFirstResponder];
}

/* If they end editing a textview, check if they left it empty. If so, display the placeholder. If the title is empty, disable the save button. */
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        if (textView == self.titleTextView) {
            textView.text = TO_DO_TITLE_PLACEHOLDER;
            textView.textColor = TO_DO_APP_GRAY;
            self.saveButton.enabled = NO;
            [self.saveButton setBackgroundColor:TO_DO_APP_LIGHTEST_GRAY];
        } else if (textView == self.descriptionTextView) {
            textView.text = TO_DO_DESCRIPTION_PLACEHOLDER;
            textView.textColor = TO_DO_APP_GRAY;
        }
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        /* Means they hit the done button */
        [textView resignFirstResponder];
        return NO;
    }
    if (textView == self.titleTextView) {
        if ([textView.text isEqualToString:TO_DO_TITLE_PLACEHOLDER]) {
            self.saveButton.enabled = NO;
            [self.saveButton setBackgroundColor:TO_DO_APP_LIGHTEST_GRAY];
        } else {
            self.saveButton.enabled = YES;
            [self.saveButton setBackgroundColor:TO_DO_APP_BLUE];
        }
    } else if (textView == self.descriptionTextView) {
        if ([textView.text isEqualToString:TO_DO_DESCRIPTION_PLACEHOLDER]) {
            self.saveButton.enabled = NO;
            [self.saveButton setBackgroundColor:TO_DO_APP_LIGHTEST_GRAY];
        } else {
            self.saveButton.enabled = YES;
            [self.saveButton setBackgroundColor:TO_DO_APP_BLUE];
        }
    }
    return YES;
}
@end
