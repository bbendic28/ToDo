//
//  Helpers.h
//  ToDo
//
//  Created by Cubes School 2 on 5/23/16.
//  Copyright © 2016 Cubes School 2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helpers : NSObject

+(BOOL)isMorning;

+(BOOL)isEmailValid:(NSString *)email;

+(UIColor *)colorForTaskGroup:(TaskGroup)group;

+(BOOL)isLoggedIn;

@end
