//
//  SettingsTableViewController.m
//  BusyBooth
//
//  Created by Krishna Bharathala on 2/19/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "AppDelegate.h"
#import "MyAccountViewController.h"

@interface SettingsTableViewController ()

typedef NS_ENUM (NSUInteger, SettingsTableViewRowType) {
    SettingsTableViewRowTypeAccount,
    SettingsTableViewRowTypeLogOut,
    SettingsTableViewRowTypeCount,
};

@end

@implementation SettingsTableViewController

-(id) init {
    self = [super init];
    if (self) {
        self.title = @"Settings";
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.bounces = NO;
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return SettingsTableViewRowTypeCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    if(indexPath.row == SettingsTableViewRowTypeAccount) {
        cell.textLabel.text = @"My Account";
    } else if(indexPath.row == SettingsTableViewRowTypeLogOut){
        cell.textLabel.text = @"Log Out";
    } else {
        cell.textLabel.text = @"";
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == SettingsTableViewRowTypeAccount) {
        MyAccountViewController *accountVC = [[MyAccountViewController alloc] init];
        [self.navigationController pushViewController:accountVC animated:YES];
    } else if(indexPath.row == SettingsTableViewRowTypeLogOut){
        [APPDELEGATE logOut];
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isAuthenticated"];
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:IsLoggedIn];
    } else {
        NSLog(@"Shouldn't ever get here");
    }
}



@end
