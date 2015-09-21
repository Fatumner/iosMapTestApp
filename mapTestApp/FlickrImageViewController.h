//
//  FlickrImageViewController.h
//  mapTestApp
//
//  Created by Mateusz Florczak on 21/09/15.
//  Copyright (c) 2015 Kainos Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrImageViewController : UIViewController

@property (nonatomic, strong) NSArray *images;
@property (nonatomic) NSInteger currentImageIndex;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeGestureRecognizerLeft;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeGestureRecognizerRight;

@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
