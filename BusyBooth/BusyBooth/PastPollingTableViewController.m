//
//  PastPollingTableViewController.m
//  
//
//  Created by Krishna Bharathala on 2/21/16.
//
//

#import "PastPollingTableViewController.h"

#import "WaitTimeTableViewCell.h"

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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == 0) {
        static NSString *cellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];\
        }
        
        cell.backgroundColor = [UIColor redColor];
        cell.textLabel.text = @"The approximate wait time to vote is";
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.center = cell.center;
        
        return cell;
        
    } else if(indexPath.row == 1) {
        static NSString *cellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];\
        }
        
        cell.textLabel.text = @"Sanjay";
        
        return cell;
        
    } else {
        static NSString *cellIdentifier = @"Cell";
        WaitTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[WaitTimeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        
        cell.descriptionLabel.text = @"12:00 PM";
        cell.timeLabel.text = @"70";
        
        return cell;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 1) {
        return 200;
    } else {
        return 44;
    }
    
}

@end
