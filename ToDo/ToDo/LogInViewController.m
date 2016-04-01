//
//  LogInViewController.m
//  ToDo
//
//  Created by Cubes School 2 on 3/30/16.
//  Copyright © 2016 Cubes School 2. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController()
@property (weak, nonatomic) IBOutlet UIImageView *usenameImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@end

@implementation LogInViewController

#pragma mark - Private API

- (void)configureTextField:(UITextField *)textField{

    if (textField.placeholder.length>0) {
        //UIColor *color=[UIColor colorWithRed:117.0/255.0 green:113.0/255.0 blue:111.0/255.0 alpha:1.0];
        NSDictionary *attributes=@{
                                   NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Regular" size:14.0],
                                   NSForegroundColorAttributeName: [UIColor whiteColor]
                                   };
        textField.attributedPlaceholder=[[NSAttributedString alloc] initWithString:textField.placeholder attributes:attributes];
    }
}

#pragma mark - Actions

- (IBAction)forgotPasswordButtonTapped:(UIButton *)sender {
}

- (IBAction)signInButtonTapped:(UIButton *)sender {
}

- (IBAction)signUpButtonTapped:(UIButton *)sender {
}

- (void)viewDidLoad{

    [super viewDidLoad];
    [self configureTextField:self.usernameTextField];
    [self configureTextField:self.passwordTextField];
}

@end
