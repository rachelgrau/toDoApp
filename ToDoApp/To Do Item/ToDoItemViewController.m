/**
 * File: ToDoItemViewController.m
 * ------------------------------
 * Displays a single to do item: its title, details, and an option to mark it as urgent.
 */

//  Created by Rachel on 17/05/2018.
//  Copyright © 2018 Rachel. All rights reserved.

#import "ToDoItemViewController.h"
#import "Constants.h"

@interface ToDoItemViewController ()

/* VIEWS */
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property UILabel *titleLabel;
@property UITextView *titleTextView;
@property UILabel *descriptionLabel;
@property UITextView *descriptionTextView;
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
    self.titleTextView = [[UITextView alloc] initWithFrame:CGRectMake(LEFT_MARGIN, startingY, SCREEN_WIDTH - LEFT_MARGIN, 100)];
    self.titleTextView.font = [UIFont fontWithName:@"Raleway-ExtraLight" size:30];
    self.titleTextView.text = @"Clean the kitchen.";
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
    self.descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(LEFT_MARGIN, startingY, SCREEN_WIDTH - LEFT_MARGIN, 100)];
    self.descriptionTextView.font = [UIFont fontWithName:@"Raleway-ExtraLight" size:20];
    self.descriptionTextView.text = @"Clean the house before mom and dad get home!";
    [self.descriptionTextView setTextContainerInset:UIEdgeInsetsZero];
    self.descriptionTextView.textContainer.lineFragmentPadding = 0; // to remove left padding
    [self.view addSubview:self.descriptionTextView];
    
    startingY += self.descriptionTextView.frame.size.height;
    startingY += VERTICAL_SPACE_BETWEEN_SECTIONS;
    
    [self setUpColors];
}

/* Programatically sets up all the colors since we have them saved in constants. */
- (void)setUpColors {
    self.titleLabel.textColor = TO_DO_APP_TEXT_GRAY;
    self.titleTextView.textColor = TO_DO_APP_TEXT_GRAY;
    self.descriptionLabel.textColor = TO_DO_APP_TEXT_GRAY;
    self.descriptionTextView.textColor = TO_DO_APP_TEXT_GRAY;
    [self.saveButton setBackgroundColor:TO_DO_APP_BLUE];
}

- (IBAction)saveButtonPressed:(id)sender {
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

@end
