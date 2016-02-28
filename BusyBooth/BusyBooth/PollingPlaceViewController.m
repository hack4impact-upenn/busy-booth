//
//  PollingPlaceViewController.m
//  BusyBooth
//
//  Created by Krishna Bharathala on 2/13/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import "PollingPlaceViewController.h"

@interface PollingPlaceViewController ()

@property (nonatomic, strong) SWRevealViewController *revealController;

@end

@implementation PollingPlaceViewController

-(id) init {
    self = [super init];
    if (self) {
        self.title = @"My Polling Place";
    }
    return self;
}

- (void) presentPollTimes {
    [self.delegate presentTimes];
}

- (void) logDrivingDirections {
    NSLog(@"Show driving directions");
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%@", self.parentViewController);
    
    self.view.backgroundColor = [UIColor colorWithRed:240.0/256 green:240.0/256 blue:242.0/256 alpha:1.0];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    self.revealController = [self revealViewController];
    [self.revealController panGestureRecognizer];
    [self.revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self.revealController
                                                                        action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = mainColor;
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    UIImageView *pollingPlaceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Oset_Logo2.png"]];
    [pollingPlaceImage setFrame:CGRectMake(0, 0, 150, 150)];
    [pollingPlaceImage setCenter:CGPointMake(width/2, height*2/7)];
    [pollingPlaceImage setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:pollingPlaceImage];
    
    UIFont * customFont = [UIFont fontWithName:@"TimesNewRoman-BoldMT" size:12]; //custom font
    NSString * text = @"Insert Polling Place Address";
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/5, height*2.5/7, 200, 200)];
    addressLabel.text = text;
    addressLabel.font = customFont;
    addressLabel.numberOfLines = 1;
    //addressLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    addressLabel.adjustsFontSizeToFitWidth = YES;
    addressLabel.adjustsLetterSpacingToFitWidth = YES;
    addressLabel.minimumScaleFactor = 10.0f/12.0f;
    addressLabel.clipsToBounds = YES;
    //addressLabel.backgroundColor = [UIColor clearColor];
    addressLabel.textColor = [UIColor blackColor];
    addressLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:addressLabel];
    
    UIButton *viewWaitTimeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [viewWaitTimeButton setFrame:CGRectMake(0, 0, 275, 40)];
    [viewWaitTimeButton setTitleColor: mainColor forState:UIControlStateNormal];
    [viewWaitTimeButton setBackgroundColor: [UIColor whiteColor]];
    [viewWaitTimeButton setTitle:@"View Wait Time" forState:UIControlStateNormal];
    [viewWaitTimeButton setCenter:CGPointMake(width/2, height*6/7)];
    [viewWaitTimeButton addTarget:self action:@selector(presentPollTimes) forControlEvents:UIControlEventTouchUpInside];
    viewWaitTimeButton.layer.cornerRadius = 8;
    [self.view addSubview:viewWaitTimeButton];
    
    UIButton *viewDrivingDirectionsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [viewDrivingDirectionsButton setFrame:CGRectMake(0, 0, 275, 40)];
    [viewDrivingDirectionsButton setTitleColor: mainColor forState:UIControlStateNormal];
    [viewDrivingDirectionsButton setBackgroundColor: [UIColor whiteColor]];
    [viewDrivingDirectionsButton setTitle:@"Get Driving Directions" forState:UIControlStateNormal];
    [viewDrivingDirectionsButton setCenter:CGPointMake(width/2, height*6/7 + 0.6*height/7)];
    [viewDrivingDirectionsButton addTarget:self action:@selector(logDrivingDirections) forControlEvents:UIControlEventTouchUpInside];
    viewDrivingDirectionsButton.layer.cornerRadius = 8;
    [self.view addSubview:viewDrivingDirectionsButton];

}

@end
