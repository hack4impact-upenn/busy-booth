//
//  PastPollingTableViewController.h
//  
//
//  Created by Krishna Bharathala on 2/21/16.
//
//

#import <UIKit/UIKit.h>

@interface PastPollingTableViewController : UITableViewController

@property (nonatomic) int boothId;
@property (nonatomic, strong) NSMutableDictionary* waitTimes;
@property (nonatomic, strong) NSMutableArray* waitTimesKeys;

@end
