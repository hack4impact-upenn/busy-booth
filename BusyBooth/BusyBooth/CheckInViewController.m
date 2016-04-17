//
//  CheckInViewController.m
//  
//
//  Created by Krishna Bharathala on 4/3/16.
//
//

#import "CheckInViewController.h"

@interface CheckInViewController ()

@property (strong, nonatomic) NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate; // Stores the date of the click on the start button *
@property (nonatomic, strong) UILabel *stopWatchLabel;
@property (nonatomic) BOOL stopWatchRunning;

@end

@implementation CheckInViewController

-(id) init {
    self = [super init];
    if (self) {
        self.title = @"Check In";
        self.stopWatchRunning = false;
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
    
    // [CheckIns checkingOutWithController:self];
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startButton.frame = CGRectMake(100, 100, 100, 100);
    [startButton setTitle:@"Start" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(onStartPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    UIButton *endButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    endButton.frame = CGRectMake(100, 200, 100, 100);
    [endButton setTitle:@"End" forState:UIControlStateNormal];
    [endButton addTarget:self action:@selector(onStopPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:endButton];
    
    self.stopWatchLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 200, 100)];
    [self.view addSubview:self.stopWatchLabel];
    
}

- (void)updateTimer
{
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSLog(@"%@", timerDate);
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.stopWatchLabel.text = timeString;
}

- (void)onStartPressed:(id)sender {
    if(!self.stopWatchRunning) {
        self.stopWatchRunning = YES;
        self.startDate = [NSDate date];
        
        // Create the stop watch timer that fires every 10 ms
        self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                               target:self
                                                             selector:@selector(updateTimer)
                                                             userInfo:nil
                                                              repeats:YES];
    }
}

- (void)onStopPressed:(id)sender {
    if(self.stopWatchRunning) {
        self.stopWatchRunning = NO;
        [self.stopWatchTimer invalidate];
        self.stopWatchTimer = nil;
        [self updateTimer];
    }
}

@end
