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

@implementation LogInViewController

#pragma mark - Private API

- (IBAction)signUpButtonTapped:(UIButton *)sender {
}

- (IBAction)forgotPassworButtonTapped:(UIButton *)sender {
    NSLog(@"Forgot password....");
}

- (IBAction)submitButtonTapped {
    if (self.usernameTextField.text.length == 0) {
        [self presentErrorWithTitle:@"Validation" andError:@"Please enter your username."];
        return;
    }
    
    if (self.passwordTextField.text.length == 0) {
        [self presentErrorWithTitle:@"Validation" andError:@"Please enter your password."];
        return;
    }
    
    NSLog(@"Signing in...");
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:LOGGED_IN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.activityIndicatorView startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.activityIndicatorView stopAnimating];
        [self performSegueWithIdentifier:@"HomeSegue" sender:self];
    });
    
}



-(void)configureTextFieldPlaceholders {
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setObject:[UIFont fontWithName:@"Avenir-Book" size:15.0] forKey:NSFontAttributeName];
    [attributes setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    NSAttributedString *usernamePlaceholder = [[NSAttributedString alloc] initWithString:self.usernameTextField.placeholder
                                                                              attributes:attributes];
    self.usernameTextField.attributedPlaceholder = usernamePlaceholder;
    
    NSAttributedString *passwordPlaceholder = [[NSAttributedString alloc] initWithString:self.passwordTextField.placeholder
                                                                              attributes:attributes];
    self.passwordTextField.attributedPlaceholder = passwordPlaceholder;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTextFieldPlaceholders];
    [self registerForNotifications];
    self.containerViewOrignY=self.containerView.frame.origin.y;
    
    
    [self.activityIndicatorView stopAnimating];
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

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    /*[UIView animateWithDuration:10.0
                          delay:0.0
         usingSpringWithDamping:0.4
          initialSpringVelocity:10.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.containerView.frame;
                         frame.origin.y = frame.origin.y - kConstant;
                         self.containerView.frame = frame;
                     }
                     completion:nil];*/
    if (textField==self.usernameTextField) {
        self.usernameImageView.image=[UIImage imageNamed:@"username-active"];
    }
    
    if (textField==self.passwordTextField) {
        self.passwordImageView.image=[UIImage imageNamed:@"password-active"];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    /*[UIView animateWithDuration:1.0
                          delay:0.0
         usingSpringWithDamping:0.4
          initialSpringVelocity:10.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect frame = self.containerView.frame;
                         frame.origin.y = frame.origin.y + kConstant;
                         self.containerView.frame = frame;
                     }
                     completion:nil];*/
    self.usernameImageView.image=[UIImage imageNamed:@"username"];
    self.passwordImageView.image=[UIImage imageNamed:@"password"];}

- (void)prepareForAnimations{
    
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

-(void)registerForNotifications{
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification
                                                    object:nil
                                                     queue:[NSOperationQueue mainQueue]
                                                usingBlock:^(NSNotification *note)
    {
        NSDictionary *keyboardInfo=note.userInfo;
        NSValue *keyBoardFrameBegin=[keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
        CGRect keyBoardFrameBeginRect=keyBoardFrameBegin.CGRectValue;
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.containerView.frame;
            frame.origin.y=self.view.frame.size.height-keyBoardFrameBeginRect.size.height-self.containerView.frame.size.height;
            self.containerView.frame=frame;
        }];
    }];
    
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note)
     {
            [UIView animateWithDuration:0.3 animations:^{
             CGRect frame = self.containerView.frame;
                frame.origin.y=self.containerViewOrignY;
             self.containerView.frame=frame;
         }];
     }];


}

@end