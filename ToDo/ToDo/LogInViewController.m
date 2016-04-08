//
//  LoginViewController.m
//  ToDo
//
//  Created by Djuro Alfirevic on 3/30/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import "LoginViewController.h"

#define kConstant 50.0
#define ZERO_VALUE 0.0

@interface LogInViewController() <UITextFieldDelegate>
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
@end

@implementation LogInViewController

#pragma mark - Private API
- (IBAction)signInButtonTapped:(UIButton *)sender {
    [self.activityIndicatorView startAnimating];
}
- (IBAction)signUpButtonTapped:(UIButton *)sender {
}
- (IBAction)forgotPassworButtonTapped:(UIButton *)sender {
}

- (void)configureTextField:(UITextField *)textField {
    if (textField.placeholder.length > 0) {
//        UIColor *color = [UIColor colorWithRed:117.0/255.0
//                                         green:113.0/255.0
//                                          blue:111.0/255.0
//                                         alpha:1.0];
        
        NSDictionary *attributes = @{
                                     NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Regular" size:14.0],
                                     NSForegroundColorAttributeName: [UIColor whiteColor]
                                     };
        
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textField.placeholder
                                                                          attributes:attributes];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTextField:self.usernameTextField];
    [self configureTextField:self.passwordTextField];
    
    //[self.activityIndicatorView stopAnimating];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //[UIView animateWithDuration:3.0 animations:^{
        //self.logoView.alpha = 0.0;
    
    //}];
    
    [self animate];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self prepareForAnimations];
    
    [self.activityIndicatorView stopAnimating];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:10.0
                          delay:0.0
         usingSpringWithDamping:0.4
          initialSpringVelocity:10.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.containerView.frame;
                         frame.origin.y = frame.origin.y - kConstant;
                         self.containerView.frame = frame;
                     }
                     completion:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:1.0
                          delay:0.0
         usingSpringWithDamping:0.4
          initialSpringVelocity:10.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.containerView.frame;
                         frame.origin.y = frame.origin.y + kConstant;
                         self.containerView.frame = frame;
                     }
                     completion:nil];
}



-(void)prepareForAnimations{
    
    CGRect footerViewFrame=self.footerViewFrame.frame;
    footerViewFrame.origin.y = self.view.frame.size.width;
    self.footerViewFrame.frame=footerViewFrame;
    
    CGRect submitButtonFrame=self.submitButton.frame;
    submitButtonFrame.origin.x = self.view.frame.size.width;
    self.submitButton.frame=submitButtonFrame;
}

- (void)animate{
    
    
    
    [UIView animateWithDuration:2.0 animations:^{
        //self.maskLogoView.alpha=0.0;
        [self.maskLogoView setAlpha:0.0];
    }];
    
    [UIView animateWithDuration:0.4 animations:^{
        CGRect frame=self.footerViewFrame.frame;
        frame.origin.y=625;
        self.footerViewFrame.frame=frame;
    }];
    
    
    [UIView animateWithDuration:0.4
                          delay:0.2
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                            CGRect submitButtonFrame=self.submitButton.frame;
                         submitButtonFrame.origin.x=ZERO_VALUE;
                            self.submitButton.frame=submitButtonFrame;
                     }
                     completion:NULL];
    
    
}

@end