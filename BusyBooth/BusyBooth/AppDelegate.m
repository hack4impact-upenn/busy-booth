//
//  AppDelegate.m
//  BusyBooth
//
//  Created by Krishna Bharathala on 1/18/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterTableViewController.h"
#import "MainViewController.h"
#import "PollingPlaceViewController.h"
#import "SignUpViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic, strong) SignUpViewController *viewController;
@property (nonatomic, strong) MasterTableViewController *masterTableViewController;
@property (nonatomic, strong) PollingPlaceViewController *pollVC;
@property (nonatomic, strong) SWRevealViewController *SWRevealViewController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.viewController = [[SignUpViewController alloc] init];
    
    self.navController =
        [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.navController.navigationBarHidden = YES;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:IsLoggedIn] isEqualToString:@"true"]) {
        [self presentSWController];
    }
    
    return YES;
}

- (void)presentSWController{
    self.masterTableViewController = [[MasterTableViewController alloc] init];
    UINavigationController *masterNavigationController =
        [[UINavigationController alloc] initWithRootViewController:self.masterTableViewController];
    
    self.pollVC = [[PollingPlaceViewController alloc] init];
    self.pollVC.masterVC = self.masterTableViewController;
    UINavigationController *mainViewNavigationController =
        [[UINavigationController alloc] initWithRootViewController:self.pollVC];
    
    self.SWRevealViewController =
        [[SWRevealViewController alloc] initWithRearViewController:masterNavigationController
                                               frontViewController:mainViewNavigationController];
    
    [self.navController pushViewController:self.SWRevealViewController animated:YES];
}

- (void)presentSignUpViewController {
    SignUpViewController *signupVC = [[SignUpViewController alloc] init];
    [self.navController pushViewController:signupVC animated:YES];
}

- (void)logOut {
    [self presentSignUpViewController];
    [[NSUserDefaults standardUserDefaults] setObject:@"false" forKey:IsLoggedIn];
}

@end
