//
//  MasterTableViewController.h
//  BusyBooth
//
//  Created by Krishna Bharathala on 9/4/15.
//  Copyright © 2015 Krishna Bharathala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterTableViewController : UITableViewController

@property(nonatomic, retain) UITableView *rearTableView;

- (void)presentTimes;
- (void)presentMapView;

@end
