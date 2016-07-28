//
//  PollingPlaceViewController.m
//  BusyBooth
//
//  Created by Krishna Bharathala on 2/13/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import "PollingPlaceViewController.h"

@interface PollingPlaceViewController ()

@property(nonatomic, strong) SWRevealViewController *revealController;

@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic) int loops;
@property(nonatomic) int heading;
@property(nonatomic, strong) UILabel *addressLabel;

@end

@implementation PollingPlaceViewController

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"My Polling Place";
  }
  return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

  self.view.backgroundColor = [UIColor colorWithRed:240.0 / 256 green:240.0 / 256
                                               blue:242.0 / 256 alpha:1.0];
  [self.navigationController.navigationBar setTitleTextAttributes:@{
    NSForegroundColorAttributeName : [UIColor whiteColor]
  }];

  self.revealController = [self revealViewController];
  [self.revealController panGestureRecognizer];
  [self.revealController tapGestureRecognizer];

  UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc]
      initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
              style:UIBarButtonItemStylePlain
             target:self.revealController
             action:@selector(revealToggle:)];
  self.navigationItem.leftBarButtonItem = revealButtonItem;
  self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
  self.navigationController.navigationBar.barTintColor = mainColor;

  CGFloat width = self.view.frame.size.width;
  CGFloat height = self.view.frame.size.height;

  UIImageView *pollingPlaceImage =
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"GardnerPhoto.png"]];
  [pollingPlaceImage setFrame:CGRectMake(0, 0, 320, 181)];
  [pollingPlaceImage setCenter:CGPointMake(width / 2, height * 1.9 / 7)];
  [pollingPlaceImage setBackgroundColor:[UIColor clearColor]];
  [self.view addSubview:pollingPlaceImage];

  self.addressLabel =
    [[UILabel alloc] initWithFrame:CGRectMake(width / 5, height * 3 / 7, 200, 200)];
  self.addressLabel.numberOfLines = 4;
  self.addressLabel.adjustsFontSizeToFitWidth = YES;
  self.addressLabel.minimumScaleFactor = 10.0f / 12.0f;
  self.addressLabel.clipsToBounds = YES;
  self.addressLabel.textColor = [UIColor blackColor];
  self.addressLabel.textAlignment = NSTextAlignmentCenter;
  [self.view addSubview:self.addressLabel];

  [self updateAddressLabel];

  UIButton *viewWaitTimeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [viewWaitTimeButton setFrame:CGRectMake(0, 0, 275, 40)];
  [viewWaitTimeButton setTitleColor:mainColor forState:UIControlStateNormal];
  [viewWaitTimeButton setBackgroundColor:[UIColor whiteColor]];
  [viewWaitTimeButton setTitle:@"View Wait Time" forState:UIControlStateNormal];
  [viewWaitTimeButton setCenter:CGPointMake(width / 2, height * 6 / 7)];
  [viewWaitTimeButton addTarget:self
                         action:@selector(presentPollTimes)
               forControlEvents:UIControlEventTouchUpInside];
  viewWaitTimeButton.layer.cornerRadius = 8;
  [self.view addSubview:viewWaitTimeButton];

  UIButton *viewDrivingDirectionsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [viewDrivingDirectionsButton setFrame:CGRectMake(0, 0, 275, 40)];
  [viewDrivingDirectionsButton setTitleColor:mainColor forState:UIControlStateNormal];
  [viewDrivingDirectionsButton setBackgroundColor:[UIColor whiteColor]];
  [viewDrivingDirectionsButton setTitle:@"Get Driving Directions"
                               forState:UIControlStateNormal];
  [viewDrivingDirectionsButton setCenter:CGPointMake(width / 2, height * 6 / 7 + 0.6 * height / 7)];
  [viewDrivingDirectionsButton addTarget:self
                                  action:@selector(getDrivingDirections)
                        forControlEvents:UIControlEventTouchUpInside];
  viewDrivingDirectionsButton.layer.cornerRadius = 8;
  [self.view addSubview:viewDrivingDirectionsButton];
}


- (void)updateAddressLabel {
    
  NSString *address = [[NSUserDefaults standardUserDefaults] objectForKey:@"boothAddress"];
  int zip = [[[NSUserDefaults standardUserDefaults] objectForKey:@"boothZip"] intValue];

  CLGeocoder *geocoder = [[CLGeocoder alloc] init];
  [geocoder geocodeAddressString:[NSString stringWithFormat:@"%@ %i", address, zip]
               completionHandler:^(NSArray *placemarks, NSError *error) {

                   CLPlacemark *p = [placemarks firstObject];
                   NSLog(@"%@", p.subLocality);
                   NSLog(@"%@", p.addressDictionary);
                   NSLog(@"%@", p.postalCode);

                   NSDictionary *attrs1 = @{
                                            NSFontAttributeName :
                                                [UIFont fontWithName:@"Helvetica-Bold" size:16.0f],
                                            NSForegroundColorAttributeName : [UIColor blackColor]
                                            };
                   NSDictionary *attrs2 = @{
                                            NSFontAttributeName :
                                                [UIFont fontWithName:@"Helvetica-Bold" size:20.0f],
                                            NSForegroundColorAttributeName : [UIColor blackColor]
                                            };
                   NSDictionary *attrs3 = @{
                                            NSFontAttributeName :
                                                [UIFont fontWithName:@"Helvetica" size:18.0f],
                                            NSForegroundColorAttributeName : [UIColor grayColor]
                                            };

                   NSString *string2 = [NSString stringWithFormat:@"%@\n", p.subLocality];
                   NSString *string3 = [NSString stringWithFormat:@"%@\n",
                                        [p.addressDictionary objectForKey:@"Street"]];
                   NSString *string4 = [NSString stringWithFormat:@"%@, %@ %@",
                                        [p.addressDictionary objectForKey:@"City"],
                                        p.administrativeArea, p.postalCode];

                   NSMutableAttributedString *line1 =
                       [[NSMutableAttributedString alloc] initWithString:@"Your Polling Place is\n"
                                                              attributes:attrs1];
                   NSMutableAttributedString *line2 =
                       [[NSMutableAttributedString alloc] initWithString:string2
                                                              attributes:attrs2];
                   NSMutableAttributedString *line3 =
                       [[NSMutableAttributedString alloc] initWithString:string3
                                                              attributes:attrs3];
                   NSMutableAttributedString *line4 =
                       [[NSMutableAttributedString alloc] initWithString:string4
                                                              attributes:attrs3];

                   NSMutableAttributedString *allLines = [[NSMutableAttributedString alloc] init];
                   [allLines appendAttributedString:line1];
                   [allLines appendAttributedString:line2];
                   [allLines appendAttributedString:line3];
                   [allLines appendAttributedString:line4];

                   self.addressLabel.attributedText = allLines;
         }];
}

- (void)presentPollTimes {
  [self.revealController revealToggle:self.revealController];
  [self.masterVC presentTimes];
}

- (void)getDrivingDirections {
  [self.revealController revealToggle:self.revealController];
  [self.masterVC presentMapView];
}

@end
