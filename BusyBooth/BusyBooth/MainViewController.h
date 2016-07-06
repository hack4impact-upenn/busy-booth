//
//  MainViewController.h
//  BusyBooth
//
//  Created by Krishna Bharathala on 12/7/15.
//  Copyright © 2015 Krishna Bharathala. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>

@property(strong, nonatomic) CLLocationManager *locationManager;

@end