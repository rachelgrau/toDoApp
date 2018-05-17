//
//  MyListsViewController.m
//  ToDoApp
//
//  Created by Rachel on 17/05/2018.
//  Copyright © 2018 Rachel. All rights reserved.
//

#import "MyListsViewController.h"
#import "ToDoListViewController.h"

@interface MyListsViewController ()

@end

@implementation MyListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)seeListButtonPressed:(id)sender {
    ToDoListViewController *toDoListVC = [[ToDoListViewController alloc] initWithNibName:@"ToDoListViewController" bundle:nil];
    [self.navigationController pushViewController:toDoListVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
