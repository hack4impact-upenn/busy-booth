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

//    [CheckIns checkingOutWithController:self];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    pin.enabled = YES;
    pin.canShowCallout = YES;
    return pin;
}

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
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


@end
