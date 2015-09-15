//
//  MapViewController.m
//  mapTestApp
//
//  Created by Mateusz Florczak on 11/09/15.
//  Copyright (c) 2015 Kainos Software Ltd. All rights reserved.
//

#import "MapViewController.h"
#import "CoreDataHelper.h"
#import "MyAnnotation.h"
#import "Position.h"
#import "PositionManager.h"

@interface MapViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fetchedResultsController = [CoreDataHelper fetchedResultsControllerWithEntityName:@"Position"];
    
    self.mapView.delegate = self;
    self.fetchedResultsController.delegate = self;
}

- (void)initAnnotations {
    for (Position *position in [self.fetchedResultsController fetchedObjects]) {
        [self addAnnotationForLongitude:position.lon latitude:position.lat];
    }
}

- (IBAction)tapped:(id)sender {
    CGPoint point = [sender locationInView:self.mapView];
    [PositionManager saveNewPositionWithLongitude:@(point.y) Latitude:@(point.x)];
}

- (void)removeMissingAnnotation {
    BOOL foundPosition = NO;
    CLLocationCoordinate2D coord;
    
    for (id<MKAnnotation> mkAnnotation in self.mapView.annotations) {
        MyAnnotation *annotation = (MyAnnotation *)[self.mapView viewForAnnotation:mkAnnotation];
        
        for (Position *position in [self.fetchedResultsController fetchedObjects]) {
            coord = [self.mapView convertPoint:CGPointMake([position.lat floatValue], [position.lon floatValue]) toCoordinateFromView:self
             .mapView];
            
            if (coord.latitude == annotation.coordinate.latitude && coord.longitude == annotation.coordinate.longitude) {
                foundPosition = YES;
                
                break;
            }
        }
        
        if (!foundPosition) {
            [self.mapView removeAnnotation:mkAnnotation];
            
            return;
        }
        foundPosition = NO;
    }
}

- (void)removeAnnotationWithLongitude:(NSNumber *)longitude latitude:(NSNumber *)latitude {
    CGPoint point = CGPointMake([latitude doubleValue], [longitude doubleValue]);
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
    MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinates:coordinate];
    for (id<MKAnnotation> annotatio in self.mapView.annotations) {
        MKAnnotationView* anView = [self.mapView viewForAnnotation: annotatio];
        MyAnnotation *anno = (MyAnnotation *)anView;
        if (anView){
            if (anno.coordinate.latitude == annotation.coordinate.latitude && anno.coordinate.longitude == annotation.coordinate.longitude) {
                [self.mapView removeAnnotation:annotatio];
                return;
            }
        }
    }
}

- (void)addAnnotationForLongitude:(NSNumber *)longitude latitude:(NSNumber *)latitude {
    CGPoint point = CGPointMake([latitude floatValue], [longitude floatValue]);
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
    MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinates:coordinate];
    [self.mapView addAnnotation:annotation];
}

#pragma mark - Map view delegate

- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
    [self initAnnotations];
}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    
}

#pragma mark - Fetched results controller

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    Position *position = anObject;
    
    switch (type) {
        case NSFetchedResultsChangeDelete:
            [self removeAnnotationWithLongitude:position.lon latitude:position.lat];
            break;
        case NSFetchedResultsChangeInsert:
            [self addAnnotationForLongitude:position.lon latitude:position.lat];
            break;
        case NSFetchedResultsChangeUpdate: {
            [self removeMissingAnnotation];
            [self addAnnotationForLongitude:position.lon latitude:position.lat];
            break;
        }
        case NSFetchedResultsChangeMove: {
            [self removeMissingAnnotation];
            [self addAnnotationForLongitude:position.lon latitude:position.lat];
            break;
        }
    }
}

@end
