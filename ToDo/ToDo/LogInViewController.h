//
//  LogInViewController.h
//  ToDo
//
//  Created by Cubes School 2 on 3/30/16.
//  Copyright © 2016 Cubes School 2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInViewController : UIViewController <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *usernameImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *logoView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UIView *maskLogoView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIView *footerViewFrame;
@property(nonatomic) CGFloat containerViewOrignY;

-(IBAction)submitButtonTapped;
-(void)configureTextFieldPlaceholders;
-(void)registerForNotifications;
-(void)prepareForAnimations;
-(void)animate;

@end
