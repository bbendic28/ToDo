//
//  UIViewController+Utilities.m
//  ToDo
//
//  Created by Cubes School 2 on 5/20/16.
//  Copyright © 2016 Cubes School 2. All rights reserved.
//

#import "UIViewController+Utilities.h"

@implementation UIViewController (Utilities)

-(void)presentErrorWithTitle:(NSString *)title andError:(NSString *)error{
    
    UIAlertController *alertController= [UIAlertController alertControllerWithTitle:title message:error preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action=[UIAlertAction actionWithTitle:OK_STRING style:UIAlertActionStyleCancel handler:NULL];
    
    [alertController addAction:action];
    
    [self presentViewController:alertController animated:YES completion:NULL];
}
@end
