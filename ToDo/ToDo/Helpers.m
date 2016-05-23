//
//  Helpers.m
//  ToDo
//
//  Created by Cubes School 2 on 5/23/16.
//  Copyright © 2016 Cubes School 2. All rights reserved.
//

#import "Helpers.h"


@implementation Helpers

+(BOOL)isMorning{
    NSDateComponents *components=[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:[NSDate date]];
    
    NSInteger hour=components.hour;
    
    if (hour>12) {
        return NO;
    }
    
    return YES;
}

+(BOOL)isEmailValid:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    //self matches je apple-ova rec, znaci ako neciji email matchuje emailRegex
    NSPredicate *emailTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [emailTest evaluateWithObject:emailRegex];
    
    return isValid;
}

+(BOOL)isLoggedIn{
    return [[NSUserDefaults standardUserDefaults] boolForKey:LOGGED_IN];
}

+(UIColor *)colorForTaskGroup:(TaskGroup)group{
    
    UIColor *color;
    
    switch (group) {
        case COMPLETED_TASK_GROUP:
            color=kTurquoiseColor;
            break;
            
        case NOT_COMPLETED_TASK_GROUP:
            color=kOrangeColor;
            break;
        
        case IN_PROGRESS_TASK_GROUP:
            color=kPurpleColor;
            break;
            
    }
    
    return color;
}
@end
