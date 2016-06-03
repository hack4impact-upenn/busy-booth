//
//  CheckInViewController.m
//  
//
//  Created by Krishna Bharathala on 4/3/16.
//
//

#import "CheckInViewController.h"
#import "Checkins.h"

@interface CheckInViewController ()

@property (strong, nonatomic) NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate; // Stores the date of the click on the start button *
@property (nonatomic, strong) UILabel *stopWatchLabel;
@property (nonatomic) BOOL stopWatchRunning;

@property (nonatomic, strong) UITextField *addTimeField;

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
    
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
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
    
    self.view.backgroundColor = [UIColor colorWithRed:240.0/256 green:240.0/256 blue:242.0/256 alpha:1.0];
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [startButton setFrame:CGRectMake(0, 0, 275, 40)];
    [startButton setTitleColor: mainColor forState:UIControlStateNormal];
    [startButton setBackgroundColor: [UIColor whiteColor]];
    [startButton setTitle:@"Checkin to Polling Place" forState:UIControlStateNormal];
    [startButton setCenter:CGPointMake(width/2, height*6/7)];
    [startButton addTarget:self action:@selector(onStartPressed:) forControlEvents:UIControlEventTouchUpInside];
    startButton.layer.cornerRadius = 8;
    [self.view addSubview:startButton];
    
    UIButton *stopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [stopButton setFrame:CGRectMake(0, 0, 275, 40)];
    [stopButton setTitleColor: mainColor forState:UIControlStateNormal];
    [stopButton setBackgroundColor: [UIColor whiteColor]];
    [stopButton setTitle:@"Checkout of Polling Place" forState:UIControlStateNormal];
    [stopButton setCenter:CGPointMake(width/2, height*6.6/7)];
    [stopButton addTarget:self action:@selector(onStopPressed:) forControlEvents:UIControlEventTouchUpInside];
    stopButton.layer.cornerRadius = 8;
    [self.view addSubview:stopButton];
    
    self.stopWatchLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    self.stopWatchLabel.text = [NSString stringWithFormat:@"00:00"];
    
    bool isAdmin = YES; //[[NSUserDefaults standardUserDefaults] objectForKey:@"isAdmin"];
    if(isAdmin) {
        UIBarButtonItem *addTimeButton = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                            target:self
                                            action:@selector(onAddPressed:)];
        [addTimeButton setTintColor: [UIColor whiteColor]];
        self.navigationItem.rightBarButtonItem = addTimeButton;
    }
    
    self.stopWatchLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [self.stopWatchLabel setCenter:CGPointMake(width/2, height/2)];
    [self.view addSubview:self.stopWatchLabel];
    
}

- (void)updateTimer
{
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.stopWatchLabel.text = timeString;
}

- (void) startTimer {
    self.stopWatchRunning = YES;
    self.startDate = [NSDate date];
    
    // Create the stop watch timer that fires every 10 ms
    self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];
}

- (void) stopTimer {
    self.stopWatchRunning = NO;
    [self.stopWatchTimer invalidate];
    [self updateTimer];
}

- (void)onStartPressed:(id)sender {
    if(!self.stopWatchRunning) {
        [CheckIns checkingInWithController:self];
    }
}

- (void)onAddPressed:(id)sender {
    UIAlertView *addTime = [[UIAlertView alloc] initWithTitle:@"Add wait time" message:@"How many minutes is the current wait time?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"This many minutes", nil];
    addTime.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    _addTimeField = [addTime textFieldAtIndex:0];
    [_addTimeField resignFirstResponder];
    [_addTimeField setKeyboardType:UIKeyboardTypePhonePad];
    [_addTimeField becomeFirstResponder];
    
    [addTime show];

}

- (void)onStopPressed:(id)sender {
    if(self.stopWatchRunning) {
        [CheckIns checkingOutWithController:self];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        /* TODO: validate user with something other than phone# (i.e. this is not secure) */
        NSString *post = [NSString stringWithFormat:@"phone=%@&time=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"curr-number"], _addTimeField.text];                                    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        [request setURL:[NSURL URLWithString:@"http://localhost:5000/add_time"]]; /* TODO: add /add_time route */
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              
                                              if(data) {
                                                  NSLog(@"Posted time");
                                              } else {
                                                  NSLog(@"Failed to post time");
                                              }
                                          }];
        [dataTask resume];
    }
}

@end
