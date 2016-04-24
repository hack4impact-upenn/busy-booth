//
//  PastPollingTableViewController.m
//  
//
//  Created by Krishna Bharathala on 2/21/16.
//
//

#import "PastPollingTableViewController.h"

#import "WaitTimeTableViewCell.h"
#import "SmallWaitTime.h"
#import "LargeWaitTime.h"

@interface PastPollingTableViewController ()

@end

@implementation PastPollingTableViewController

-(id) init {
    self = [super init];
    if (self) {
        self.title = @"Past Poll Times";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    self.tableView.tableFooterView = [UIView new];
    [self.tableView setUserInteractionEnabled: NO];
    
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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getBoothId];
    
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int time = 60;
    int wait = 0;
    if(indexPath.row != 0) {
        long i = indexPath.row - 1;
        if(i < self.waitTimesKeys.count) {
            time = [self.waitTimesKeys[i] intValue];
            wait = [[self.waitTimes objectForKey:self.waitTimesKeys[i]] intValue];
        }
    }
    
    if(indexPath.row == 0) {
        static NSString *cellIdentifier = @"HeaderCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:22.0/255.0 blue:47.0/255.0 alpha:1.0];
        cell.textLabel.text = @"The approximate wait time to vote is";
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        return cell;
        
    } else if(indexPath.row == 1) {
        static NSString *cellIdentifier = @"MainCell";
        LargeWaitTime *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[LargeWaitTime alloc] initWithReuseIdentifier:cellIdentifier time:time wait:wait];
        }

        return cell;
        
    } else {
        static NSString *cellIdentifier = @"WaitTimeCell";
        SmallWaitTime *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[SmallWaitTime alloc] initWithReuseIdentifier:cellIdentifier time:time wait:wait];
        }
        
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) {
        return 57;
    } else if(indexPath.row == 1) {
        return 214;
    } else {
        return 42;
    }
    
}

- (void)getBoothId
{
//    NSString *post = @"";
//    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    
//    NSString *domain = @"localhost:5000";
//    NSString *phoneNumber = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"curr-number"]];
//    NSString *url = [NSString stringWithFormat:@"http://%@/lookup/%@", domain, phoneNumber];
//    
//    [request setURL:[NSURL URLWithString:url]];
//    [request setHTTPMethod:@"GET"];
//    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:postData];
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
//                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
//                                      {
//                                          NSDictionary *user = [NSJSONSerialization JSONObjectWithData:data
//                                                                                                options:kNilOptions
//                                                                                                  error:&error];
//                                          NSLog(@"%@", user);
//                                          self.boothId = 1;
//                                          if([[user objectForKey:@"code"] integerValue] == 0) {
//                                              dispatch_async(dispatch_get_main_queue(), ^{
//                                                  //[APPDELEGATE presentSWController];
//                                                  self.boothId = [[user objectForKey:@"booth_id"] intValue];
//                                              });
//                                          } else if([[user objectForKey:@"code"] integerValue] == 1) {
//                                              dispatch_async(dispatch_get_main_queue(), ^{
//                                                  [SVProgressHUD showErrorWithStatus:@"Could not find your location. Are you logged in?"];
//                                              });
//                                          } else {
//                                              dispatch_async(dispatch_get_main_queue(), ^{
//                                                  [SVProgressHUD showErrorWithStatus:@"Error loading location information. Try again later"];
//                                              });
//                                          }
//                                          [self getTimes];
//                                      }];
//    [dataTask resume];
}

- (void)getTimes
{
    NSString *post = @"";
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *domain = @"localhost:5000";
    NSString *url = [NSString stringWithFormat:@"http://%@/history_wait/%d", domain, self.boothId];
    
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          NSDictionary *times = [NSJSONSerialization JSONObjectWithData:data
                                                                                                    options:kNilOptions
                                                                                                    error:&error];
                                          NSLog(@"%@", times);
                                          if([[times objectForKey:@"code"] integerValue] == 0) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  //[APPDELEGATE presentSWController];
                                                  self.waitTimesKeys = [[NSMutableArray alloc] initWithCapacity:6];
                                                  self.waitTimes = [[NSMutableDictionary alloc] initWithCapacity:6];
                                                  
                                                  NSArray *arr = [times objectForKey:@"data"];
                                                  for(NSDictionary *element in arr) {
                                                      [self.waitTimes setValue:[element objectForKey:@"time"] forKey:[element objectForKey:@"minute_start"]];
                                                      [self.waitTimesKeys addObject:[element objectForKey:@"minute_start"]];
                                                  }
                                                  [self.tableView reloadData];
                                              });
                                          } else if([[times objectForKey:@"code"] integerValue] == 2) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [SVProgressHUD showErrorWithStatus:@"Could not find polling booth. Try again later."];
                                              });
                                          } else {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [SVProgressHUD showErrorWithStatus:@"Could not load times. Try again later"];
                                              });
                                          }
                                      }];
    [dataTask resume];
}

@end
