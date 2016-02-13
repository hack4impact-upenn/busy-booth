//
//  AppDelegate.m
//  iOS-Starter-App
//
//  Created by Krishna Bharathala on 1/18/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "MasterTableViewController.h"
#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "SignUpViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic, strong) LoginViewController *viewController;
@property (nonatomic, strong) MasterTableViewController *masterTableViewController;
@property (nonatomic, strong) MainViewController *mainVC;
@property (nonatomic, strong) SWRevealViewController *SWRevealViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.viewController = [[LoginViewController alloc] init];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.navController.navigationBarHidden = YES;
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    
    [Parse setApplicationId:@"kkDmU3bzswvfLcOd1GI0lVUtZxKXOfWxblkTFLuB"
                  clientKey:@"mXkHvFn6lUv23MBNgoBQTDyXn9lpAoseEQjThRKu"];
    
    return YES;
}

- (void)presentSWController{
    
    self.masterTableViewController = [[MasterTableViewController alloc] init];
    UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:self.masterTableViewController];
    
    self.mainVC = [[MainViewController alloc] init];
    UINavigationController *mainViewNavigationController = [[UINavigationController alloc] initWithRootViewController:self.mainVC];
    
    self.SWRevealViewController = [[SWRevealViewController alloc] initWithRearViewController:masterNavigationController frontViewController:mainViewNavigationController];
    
    [self.navController pushViewController:self.SWRevealViewController animated:YES];
}

- (void)presentLoginViewController {
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navController pushViewController:loginVC animated:NO];
}

- (void)presentSignUpViewController {
    
    SignUpViewController *signupVC = [[SignUpViewController alloc] init];
    [self.navController pushViewController:signupVC animated:YES];
}

- (void) logOut {
    [self presentLoginViewController];
}

@end
