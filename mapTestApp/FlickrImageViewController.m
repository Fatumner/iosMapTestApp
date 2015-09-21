//
//  FlickrImageViewController.m
//  mapTestApp
//
//  Created by Mateusz Florczak on 21/09/15.
//  Copyright (c) 2015 Kainos Software Ltd. All rights reserved.
//

#import "FlickrImageViewController.h"

@interface FlickrImageViewController ()

@end

@implementation FlickrImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.swipeGestureRecognizerLeft = [[UISwipeGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(handleSwipes:)];
    self.swipeGestureRecognizerLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    self.swipeGestureRecognizerLeft.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:self.swipeGestureRecognizerLeft];
    
    self.swipeGestureRecognizerRight = [[UISwipeGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(handleSwipes:)];
    self.swipeGestureRecognizerRight.direction = UISwipeGestureRecognizerDirectionRight;
    self.swipeGestureRecognizerRight.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:self.swipeGestureRecognizerRight];
    
    [self loadImage];
}

- (void)loadImage {
    self.image.image = [self.images objectAtIndex:self.currentImageIndex];
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender {
    
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (self.currentImageIndex + 1 < self.images.count) {
            self.currentImageIndex++;
        }
    } else if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if (self.currentImageIndex > 0) {
            self.currentImageIndex--;
        }
    }
    [self loadImage];
}

@end
