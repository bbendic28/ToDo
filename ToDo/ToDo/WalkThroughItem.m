//
//  WalkThroughItem.m
//  ToDo
//
//  Created by Cubes School 2 on 4/25/16.
//  Copyright © 2016 Cubes School 2. All rights reserved.
//

#import "WalkThroughItem.h"

@implementation WalkThroughItem

- (instancetype) initWithText:(NSString *)text andImage:(UIImage *)image{
    
    if(self = [super init]){
    self.text=text;
    self.image=image;
    }
    return self;
}

@end
