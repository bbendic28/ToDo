//
//  WalkViewController.m
//  ToDo
//
//  Created by Cubes School 2 on 4/22/16.
//  Copyright © 2016 Cubes School 2. All rights reserved.
//

#import "WalkViewController.h"
#import "Constants.h"

@implementation WalkViewController

- (IBAction)closeButtonTapped:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:WALK_THROUGH_PRESENTED];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
