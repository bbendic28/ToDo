//
//  StatisticsViewController.m
//  ToDo
//
//  Created by Cubes School 2 on 5/4/16.
//  Copyright © 2016 Cubes School 2. All rights reserved.
//

#import "StatisticsViewController.h"
#import "DataManager.h"
#import "Constants.h"

@interface StatisticsViewController()
@property (weak,nonatomic) IBOutlet UILabel *completedPercentageLabel;
@property (weak,nonatomic) IBOutlet UILabel *notCompletedPercentageLabel;
@property (weak,nonatomic) IBOutlet UILabel *inProgressPercentageLabel;

@property (weak,nonatomic) IBOutlet UILabel *completedCountLabel;
@property (weak,nonatomic) IBOutlet UILabel *notCompletedCountLabel;
@property (weak,nonatomic) IBOutlet UILabel *inProgressCountLabel;

@end

@implementation StatisticsViewController


#pragma mark - Actions
- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - View lifecycle

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    CGFloat completedCount=[[DataManager sharedInstance] numberOfTasksPerTaskGroup:COMPLETED_TASK_GROUP];
    CGFloat notCompletedCount=[[DataManager sharedInstance] numberOfTasksPerTaskGroup:NOT_COMPLETED_TASK_GROUP];
    CGFloat inProgressCount=[[DataManager sharedInstance] numberOfTasksPerTaskGroup:IN_PROGRESS_TASK_GROUP];
    CGFloat tasksCount=completedCount+notCompletedCount+inProgressCount;
    
    self.completedCountLabel.text=[NSString stringWithFormat:@"%.0f",completedCount];
    self.notCompletedCountLabel.text=[NSString stringWithFormat:@"%.0f",notCompletedCount];
    self.inProgressCountLabel.text=[NSString stringWithFormat:@"%.0f",inProgressCount];
    
    if (completedCount>0) {
        CGFloat percentage=(completedCount/tasksCount)*100;
        self.completedCountLabel.text=[NSString stringWithFormat:@"%.0f",percentage];
    }
    else{
        self.completedCountLabel.text=@"0";
    }
    
    
    
    if (notCompletedCount>0) {
        CGFloat percentage=(notCompletedCount/tasksCount)*100;
        self.notCompletedCountLabel.text=[NSString stringWithFormat:@"%.0f",percentage];
    }else{
    self.notCompletedCountLabel.text=@"0";
    }
    
    
    
    if (inProgressCount>0) {
        CGFloat percentage=(inProgressCount/tasksCount)*100;
        self.inProgressCountLabel.text=[NSString stringWithFormat:@"%.0f",percentage];
    }
    else{
        self.inProgressCountLabel.text=@"0";
    }

}

@end
