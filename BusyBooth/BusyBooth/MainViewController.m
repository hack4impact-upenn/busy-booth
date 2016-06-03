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
#import "BFPaperButton.h"

@interface MainViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) CLLocation *destination;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) MKRoute *routeDetails;
@property (nonatomic, strong) BFPaperButton *directionsButton;

@property (nonatomic) float latitude;
@property (nonatomic) float longitude;

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
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
    
    self.directionsButton = [[BFPaperButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80, self.view.frame.size.height - 80, 50, 50) raised:YES];
    [self.directionsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // [self.directionsButton addTarget:self action:@selector(buttonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.directionsButton.backgroundColor = [UIColor colorWithRed:0.3 green:0 blue:1 alpha:1];
    self.directionsButton.cornerRadius = self.directionsButton.frame.size.width / 2;
    self.directionsButton.rippleFromTapLocation = NO;
    self.directionsButton.tapCircleDiameter = MAX(self.directionsButton.frame.size.width, self.directionsButton.frame.size.height) * 1.3;
    [self.view addSubview:self.directionsButton];
    
    [SVProgressHUD show];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    pin.canShowCallout = YES;
    return pin;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    self.location = userLocation.location;
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.2;
    mapRegion.span.longitudeDelta = 0.2;
    [mapView setRegion:mapRegion animated: YES];
    
    [self getDestination];
    
}

-(void) getDestination {
    
    NSString *url = [NSString stringWithFormat:@"http://localhost:5000/lookup/%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"hash"]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error;
    NSHTTPURLResponse *responseCode;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
        return;
    }
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData
                                                         options:kNilOptions
                                                           error:&error];
    
    NSString *address = [[json objectForKey:@"data"] objectForKey:@"address"];
    int zip = [[[json objectForKey:@"data"] objectForKey:@"zip"] intValue];
    
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:[NSString stringWithFormat:@"%@ %i", address, zip]
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     CLPlacemark *p = [placemarks firstObject];
                     self.destination = [p location];
                     
                     [self drawRoute:self.location goingTo:self.destination];
                     
                 }];

}

-(void)drawRoute:(CLLocation *)source goingTo:(CLLocation *)destination {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
    MKCoordinateRegion region;
    region.center.latitude = (source.coordinate.latitude + destination.coordinate.latitude)/2;
    region.center.longitude = (source.coordinate.longitude + destination.coordinate.longitude)/2;
    region.span.latitudeDelta = fabs(source.coordinate.latitude - destination.coordinate.latitude)*1.5;
    region.span.latitudeDelta = (region.span.latitudeDelta < 0.01)? 0.01:region.span.latitudeDelta;
    region.span.longitudeDelta = fabs(source.coordinate.longitude - destination.coordinate.longitude)*1.5;
    MKCoordinateRegion scaledRegion = [self.mapView regionThatFits:region];
    [self.mapView setRegion: scaledRegion animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = destination.coordinate;
    point.title = @"Polling Booth";
    [self.mapView addAnnotation:point];
    
    [self getDirections:source goingTo:destination];

}

-(void) getDirections:(CLLocation *)source goingTo:(CLLocation *)destination {
    
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
            [self.directionsButton setTitle:[NSString stringWithFormat:@"%d min", (int)self.routeDetails.expectedTravelTime/60] forState:UIControlStateNormal];
            [self.directionsButton addTarget:self action:@selector(openMaps) forControlEvents:UIControlEventTouchUpInside];
        }
    }];
}

-(void) openMaps {
    
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)]) {
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.destination.coordinate addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:@"Polling Booth"];
        NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
        MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
        [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem] launchOptions:launchOptions];
    } else {
        [SVProgressHUD showErrorWithStatus:@"IOS 6 or greater required for directions"];
    }
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer  * routeLineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:self.routeDetails.polyline];
    routeLineRenderer.strokeColor = [UIColor redColor];
    routeLineRenderer.lineWidth = 5;
    return routeLineRenderer;
}


@end
