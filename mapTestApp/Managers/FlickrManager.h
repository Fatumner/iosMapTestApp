//
//  FlickrManager.h
//  mapTestApp
//
//  Created by Mateusz Florczak on 20/09/15.
//  Copyright (c) 2015 Kainos Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FlickerCollectionViewController.h"
#import "Position.h"

@interface FlickrManager : NSObject

+ (void)loadImagesForPosition:(Position *)position withBlock:(void (^)(FlickerCollectionViewController *self, UIImage *image))block forView:(FlickerCollectionViewController *)view;

@end
