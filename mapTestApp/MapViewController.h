//
//  MapViewController.h
//  mapTestApp
//
//  Created by Mateusz Florczak on 11/09/15.
//  Copyright (c) 2015 Kainos Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
