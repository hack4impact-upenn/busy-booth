//
//  PollingPlaceViewController.h
//  BusyBooth
//
//  Created by Krishna Bharathala on 2/13/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "MasterTableViewController.h"

@interface PollingPlaceViewController : UIViewController <UINavigationControllerDelegate,
                                                          CLLocationManagerDelegate>

@property(nonatomic, weak) MasterTableViewController* masterVC;

@end
