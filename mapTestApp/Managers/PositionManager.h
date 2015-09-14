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

+ (void)saveNewPositionWithLongitude:(NSNumber *)Lon Latitude:(NSNumber *)Lat;
+ (NSArray *)fetchAllPositions;
+ (void)deletePositionForLongitude:(NSNumber *)Lon Latitude:(NSNumber *)Lat;

@end
