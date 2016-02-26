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
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    [pollingPlaceImage setCenter:CGPointMake(width/2, height*5/7)];
    [pollingPlaceImage setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:pollingPlaceImage];
    
    UIFont * customFont = [UIFont fontWithName:@"TimesNewRoman-BoldMT" size:12]; //custom font
    NSString * text = @"Insert Polling Place Address";
    
    CGSize labelSize = [text sizeWithFont:customFont constrainedToSize:CGSizeMake(380, 20) lineBreakMode:NSLineBreakByTruncatingTail];
    
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(91, 15, labelSize.width, labelSize.height)];
    fromLabel.text = text;
    fromLabel.font = customFont;
    fromLabel.numberOfLines = 1;
    fromLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    fromLabel.adjustsFontSizeToFitWidth = YES;
    fromLabel.adjustsLetterSpacingToFitWidth = YES;
    fromLabel.minimumScaleFactor = 10.0f/12.0f;
    fromLabel.clipsToBounds = YES;
    fromLabel.backgroundColor = [UIColor clearColor];
    fromLabel.textColor = [UIColor blackColor];
    fromLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:fromLabel];
    
    UIButton *viewWaitTimeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [viewWaitTimeButton setFrame:CGRectMake(0, 0, 50, 30)];
    [viewWaitTimeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [viewWaitTimeButton setTitle:@"Back" forState:UIControlStateNormal];
    [viewWaitTimeButton setCenter:CGPointMake(width/2 - 30, height*5/7)];
    [viewWaitTimeButton addTarget:self action:@selector(presentPollTimes) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:viewWaitTimeButton];
    
    UIButton *viewDrivingDirectionsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [viewDrivingDirectionsButton setFrame:CGRectMake(0, 0, 50, 30)];
    [viewDrivingDirectionsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [viewDrivingDirectionsButton setTitle:@"Back" forState:UIControlStateNormal];
    [viewDrivingDirectionsButton setCenter:CGPointMake(width/2 - 30, height*5/7 + height)];
    [viewDrivingDirectionsButton addTarget:self action:@selector(logDrivingDirections) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:viewDrivingDirectionsButton];

}

@end
