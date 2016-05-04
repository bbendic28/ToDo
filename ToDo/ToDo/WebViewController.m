//
//  WebViewController.m
//  ToDo
//
//  Created by Cubes School 2 on 5/4/16.
//  Copyright © 2016 Cubes School 2. All rights reserved.
//

#import "WebViewController.h"
#import "Constants.h"

@interface WebViewController() <UIWebViewDelegate>
@property (weak,nonatomic) IBOutlet UIWebView *webView;
@property (weak,nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@end

@implementation WebViewController
- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)animateCloseButton{
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.closeButton.alpha = ZERO_VALUE;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    [self animateCloseButton];
}

@end
