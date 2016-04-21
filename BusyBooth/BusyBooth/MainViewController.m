//
//  MainViewController.m
//  BusyBooth
//
//  Created by Krishna Bharathala on 12/7/15.
//  Copyright © 2015 Krishna Bharathala. All rights reserved.
//

#import "MainViewController.h"
#import <MapKit/MapKit.h>
#import "CheckIns.h"

@interface MainViewController () <CLLocationManagerDelegate, MKMapViewDelegate>
@property(nonatomic,strong) CLLocationManager *location;
@property(nonatomic, strong) MKMapView *mapView;
@property(nonatomic, strong) MKRoute *routeDetails;
@end

@implementation MainViewController

-(id) init {
    self = [super init];
    if (self) {
        self.title = @"Busy Booth";
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:revealController
                                                                        action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = mainColor;
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    self.mapView.delegate = self;
    self.location = [[CLLocationManager alloc]init];
    self.location.delegate = self;
    [self.location requestAlwaysAuthorization];
    [self.location startUpdatingLocation];
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
    
    // hard code polling booth destination
    CLLocation *dest = [[CLLocation alloc] initWithLatitude:39.949466 longitude:-75.171864];
    [self drawRoute:[self.location location] goingTo:dest];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    pin.enabled = YES;
    pin.canShowCallout = YES;
    return pin;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"Authorization Status changed.");
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    NSLog(@"Lat = %f, Lng = %f", userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:userLocation.coordinate.latitude forKey:@"latitude"];
    [defaults setFloat:userLocation.coordinate.longitude forKey:@"longitude"];
    [defaults synchronize];
    [self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
}

-(void)drawRoute:(CLLocation *)source goingTo:(CLLocation *)destination {
    
    
    // zoom to region
    MKCoordinateRegion region;
    region.center.latitude = (source.coordinate.latitude + destination.coordinate.latitude)/2;
    region.center.longitude = (source.coordinate.longitude + destination.coordinate.longitude)/2;
    region.span.latitudeDelta = fabs(source.coordinate.latitude - destination.coordinate.latitude)*1.1;
    region.span.latitudeDelta = (region.span.latitudeDelta < 0.01)? 0.01:region.span.latitudeDelta;
    region.span.longitudeDelta = fabs(source.coordinate.longitude - destination.coordinate.longitude)*1.1;
    MKCoordinateRegion scaledRegion = [self.mapView regionThatFits:region];
    [self.mapView setRegion: scaledRegion animated:YES];
    
    // request directions
    MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
    MKPlacemark *placemarkSource = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(source.coordinate.latitude, source.coordinate.longitude) addressDictionary:nil];
    MKPlacemark *placemarkDest = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(destination.coordinate.latitude, destination.coordinate.longitude) addressDictionary:nil];
    MKMapItem *sourceItem = [[MKMapItem alloc] initWithPlacemark:placemarkSource];
    MKMapItem *destItem = [[MKMapItem alloc] initWithPlacemark:placemarkDest];
    
    [directionsRequest setSource:sourceItem];
    [directionsRequest setDestination:destItem];
    directionsRequest.transportType = MKDirectionsTransportTypeAutomobile;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error %@", error.description);
        } else {
            
            
            self.routeDetails = response.routes.lastObject;
            [self.mapView addOverlay:self.routeDetails.polyline];
            NSLog(@"%@", [placemarkSource.addressDictionary objectForKey:@"Street"]);
            NSLog(@"%@", [NSString stringWithFormat:@"%0.1f Miles", self.routeDetails.distance/1609.344]);
            NSLog(@"%@", [NSString stringWithFormat:@"%lu" ,(unsigned long)self.routeDetails.transportType]);

            for (int i = 0; i < self.routeDetails.steps.count; i++) {
                MKRouteStep *step = [self.routeDetails.steps objectAtIndex:i];
                NSString *newStep = step.instructions;
                NSLog(@"%@", newStep);
            }
        }
    }];

}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer  * routeLineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:self.routeDetails.polyline];
    routeLineRenderer.strokeColor = [UIColor redColor];
    routeLineRenderer.lineWidth = 5;
    return routeLineRenderer;
}


@end
