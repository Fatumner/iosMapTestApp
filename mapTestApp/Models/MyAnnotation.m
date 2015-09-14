//
//  MyAnnotation.m
//  mapTestApp
//
//  Created by Mateusz Florczak on 14/09/15.
//  Copyright (c) 2015 Kainos Software Ltd. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

- (instancetype)initWithCoordinates:(CLLocationCoordinate2D)coordinates {
    self = [super init];
    
    if (self != nil) {
        _coordinate = coordinates;
    }
    
    return self;
}

@end
