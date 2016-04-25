//
//  WalkThroughCollectionViewCell.m
//  ToDo
//
//  Created by Cubes School 2 on 4/25/16.
//  Copyright © 2016 Cubes School 2. All rights reserved.
//

#import "WalkThroughCollectionViewCell.h"
#import "WalkThroughItem.h"

@implementation WalkThroughCollectionViewCell

- (void)setWalkThroughItem:(WalkThroughItem *)walkThroughItem{
    _walkThroughItem=walkThroughItem;
    self.textLabel.text=walkThroughItem.text;
    self.imageView.image=walkThroughItem.image;
}

@end
