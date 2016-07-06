//
//  AppDelegate.h
//  BusyBooth
//
//  Created by Krishna Bharathala on 2/8/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)presentSWController;
- (void)logOut;

@end
