//
//  Task.h
//  ToDo
//
//  Created by Cubes School 2 on 5/11/16.
//  Copyright © 2016 Cubes School 2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreData/CoreData.h"
#import "MapKit/MapKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSManagedObject <MKAnnotation>

- (BOOL)isLocationValid;


-(CLLocationCoordinate2D)coordinate;

-(NSString *)title;

-(NSString *)subtitle;

@end

NS_ASSUME_NONNULL_END

#import "Task+CoreDataProperties.h"
