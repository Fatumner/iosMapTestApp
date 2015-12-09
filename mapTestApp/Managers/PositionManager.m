//
//  PositionManager.m
//  mapTestApp
//
//  Created by Mateusz Florczak on 14/09/15.
//  Copyright (c) 2015 Kainos Software Ltd. All rights reserved.
//

#import "PositionManager.h"
#import "CoreDataHelper.h"

@implementation PositionManager

+ (void)saveNewPositionWithLongitude:(NSNumber *)Lon Latitude:(NSNumber *)Lat {
    
    Position *position = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Position"
                      inManagedObjectContext:[CoreDataHelper managedObjectContext]];
    
    if (position != nil) {
        position.lon = Lon;
        position.lat = Lat;
        
        NSError *savingError = nil;
        if ([[CoreDataHelper managedObjectContext] save:&savingError]) {
            NSLog(@"Successfully saved the context");
        } else {
            NSLog(@"Failed to save the context. Error = %@", savingError);
        }
    } else {
        NSLog(@"Failed to save the new position.");
    }
}
//test
+ (NSArray *)fetchAllPositions {
    return [CoreDataHelper fetchDataWithEntityName:@"Position"];
}

+ (void)deletePositionForLongitude:(NSNumber *)Lon Latitude:(NSNumber *)Lat {
    NSArray *positions = [self fetchAllPositions];
    
    for (Position *position in positions) {
        if (position.lat == Lat && position.lon == Lon) {
            [[CoreDataHelper managedObjectContext] deleteObject:position];
            
            NSError *savingError = nil;
            if ([[CoreDataHelper managedObjectContext] save:&savingError]) {
                NSLog(@"Successfully deleted position");
            } else {
                NSLog(@"Failed to delete the position");
            }
            return;
        }
    }
    NSLog(@"Didin't find position with latitude: %@ and longitude: %@", Lat, Lon);
}

@end
