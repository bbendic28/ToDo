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

@interface HomeViewController () <UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@end

@implementation HomeViewController

#pragma mark - View lifecyle

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(pickImage)];
    tap.numberOfTapsRequired=1;
    
    [self.profileImageView addGestureRecognizer:tap];
    
    self.profileImageView.clipsToBounds=YES;
    self.profileImageView.layer.cornerRadius=self.profileImageView.frame.size.width/2;
    
    
    //set profile image if nsdata exists in nsuserdefaults
    if ([[NSUserDefaults standardUserDefaults] objectForKey:USER_IMAGE]) {
        
        //nsdata was previously stored in nsuserdefaults when user selected an image
        NSData *data=[[NSUserDefaults standardUserDefaults] objectForKey:USER_IMAGE];
        
        self.profileImageView.image=[[UIImage alloc] initWithData:data];
    }
    
    
    /*dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"StatisticsSegue" sender:self];
    });*/
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"AboutSegue" sender:self];
    });
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:WALK_THROUGH_PRESENTED]) {
        [self performSegueWithIdentifier:@"WalkThroughSegue" sender:nil];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
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

@end

//COMPLETED_TASK_GROUP=1,
//NOT_COMPLETED_TASK_GROUP,
//IN_PROGRESS_TASK_GROUP