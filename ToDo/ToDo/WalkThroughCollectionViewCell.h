//
//  WalkThroughCollectionViewCell.h
//  ToDo
//
//  Created by Cubes School 2 on 4/25/16.
//  Copyright © 2016 Cubes School 2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WalkThroughItem.h"


@interface WalkThroughCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) WalkThroughItem *walkThroughItem;

@end
