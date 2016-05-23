//
//  HomeViewController.m
//  ToDo
//
//  Created by Cubes School 2 on 4/8/16.
//  Copyright © 2016 Cubes School 2. All rights reserved.
//

#import "HomeViewController.h"
#import "TaskTableViewCell.h"
#import "Constants.h"
#import "MenuView.h"
#import "Task.h"
#import "DataManager.h"
#import "WalkViewController.h"
#import "WebViewController.h"
#import "Helpers.h"


@interface HomeViewController () <UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, MenuViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak,nonatomic) IBOutlet MenuView *menuView;
//da bismo dodatno konfigurisali table view moramo ovako hard dodati propertu tableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *badgeImageView;
@property (weak, nonatomic) IBOutlet UILabel *badgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property(strong,nonatomic) NSMutableArray *itemsArray;

@end

@implementation HomeViewController

#pragma mark - Properties

-(NSMutableArray *)itemsArray{
    return [[DataManager sharedInstance] fetchEntity:NSStringFromClass([Task class]) withFilter:nil withSortAsc:YES forKey:@"date"];
}

#pragma mark - Private API

-(void)configureBadge{
    self.badgeImageView.alpha=(self.itemsArray.count == 0) ? ZERO_VALUE : 1.0;
    self.badgeLabel.alpha=(self.itemsArray.count==0) ? ZERO_VALUE : 1.0;
    self.badgeLabel.text=[NSString stringWithFormat:@"%ld", self.itemsArray.count];
}

-(void)configureProfileImage{
    
    
    //set profile image if nsdata exists in nsuserdefaults
    if ([[NSUserDefaults standardUserDefaults] objectForKey:USER_IMAGE]) {
        
        //nsdata was previously stored in nsuserdefaults when user selected an image
        NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:USER_IMAGE];
        
        self.profileImageView.image=[[UIImage alloc] initWithData:data];
    }

    
    
    /*dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [self performSegueWithIdentifier:@"StatisticsSegue" sender:self];
     [self presentErrorWithTitle:@"BORKO" andError:@"BORKO"];
     });
     
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [self performSegueWithIdentifier:@"AboutSegue" sender:self];
     });*/
    
    /*dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [self performSegueWithIdentifier:@"TaskDetailsSegue" sender:self];
     });*/
    
    self.menuView.delegate=self;
}

-(void)configureWelcomeLabel{
    if ([Helpers isMorning]) {
        self.welcomeLabel.text=@"Good Morning!";
    }
    else{
        self.welcomeLabel.text=@"Good afternoon!";
    }
}

#pragma mark - View lifecyle

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self configureProfileImage];
    
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(pickImage)];
    tap.numberOfTapsRequired=1;
    
    [self.profileImageView addGestureRecognizer:tap];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    /*if (![[NSUserDefaults standardUserDefaults] boolForKey:WALK_THROUGH_PRESENTED]) {
        [self performSegueWithIdentifier:@"WalkThroughSegue" sender:nil];
    }*/
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemsArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TaskTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.taskTitleLabel.text=[NSString stringWithFormat:@"Red %ld",indexPath.row];
    
    switch (indexPath.row) {
            
        case COMPLETED_TASK_GROUP:
            cell.taskGroupView.backgroundColor=kTurquoiseColor;
            break;
            
        case IN_PROGRESS_TASK_GROUP:
            cell.taskGroupView.backgroundColor=kPurpleColor;
            break;
            
        default:
            cell.taskGroupView.backgroundColor=kOrangeColor;
            break;
    }
    
    return cell;
}




#pragma mark - UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)pickImage {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Choose source:"
                                                                 message:nil
                                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Photo library"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                
                                                UIImagePickerController *picker=[[UIImagePickerController alloc] init];
                                                picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                                                picker.delegate=self;
                                                picker.allowsEditing=YES;
                                                
                                                [self presentViewController:picker animated:YES completion:nil];
        
    }]];
    
    
    
    
    
    if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear] || [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
    [alert addAction:[UIAlertAction actionWithTitle:@"Camera"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                
                                                
                                                    
                                                    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
                                                    picker.sourceType=UIImagePickerControllerSourceTypeCamera;
                                                    picker.delegate=self;
                                                    picker.allowsEditing=YES;
                                                    
                                                    [self presentViewController:picker animated:YES completion:nil];
                                                
                                            }]];}
    
    
    
    
    
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                              style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                
                                            }]];
    
    

    [self presentViewController:alert animated:YES completion:nil];
}





#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    self.profileImageView.image=image;
    
    //convert uiimage to nsdata
    NSData *nsData=UIImagePNGRepresentation(image);
    
    //store nsdata to nsuserdefaults
    [[NSUserDefaults standardUserDefaults] setObject:nsData forKey:USER_IMAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    //after picking image,close imagePickerController
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MenuViewDelegate

- (void)menuViewOptionTapped:(MenuOption)option{
    switch (option) {
        case TASK_DETAILS_MENU_OPTION:{
            [self performSegueWithIdentifier:@"TaskDetailsSegue" sender:nil];
        }break;
        
            
        case ABOUT_MENU_OPTION:{
            [self performSegueWithIdentifier:@"AboutSegue" sender:nil];
        }break;
        
            
        case STATISTICS_MENU_OPTION:{
            [self performSegueWithIdentifier:@"StatisticsSegue" sender:nil];
        }break;
        
            
        case WALKTHROUGH_MENU_OPTION:{
            [self performSegueWithIdentifier:@"WalkThroughSegue" sender:nil];
        }break;
        
        
    }
}


@end

//COMPLETED_TASK_GROUP=1,
//NOT_COMPLETED_TASK_GROUP,
//IN_PROGRESS_TASK_GROUP