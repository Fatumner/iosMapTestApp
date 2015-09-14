//
//  PositionManager.h
//  mapTestApp
//
//  Created by Mateusz Florczak on 14/09/15.
//  Copyright (c) 2015 Kainos Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Position.h"

@interface PositionManager : NSObject

+ (void)saveNewPositionWithLatitude:(NSNumber *)Lat Longitude:(NSNumber *)Lon;
+ (NSArray *)fetchAllPositions;
+ (void)deletePositionForLatitude:(NSNumber *)Lat Longitude:(NSNumber *)Lon;

@end
