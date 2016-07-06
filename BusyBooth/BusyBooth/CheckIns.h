//
//  CheckIns.h
//  BusyBooth
//
//  Created by Krishna Bharathala on 1/18/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckInViewController.h"
#import "MainViewController.h"

@interface CheckIns : NSObject<UIAlertViewDelegate>

+ (void)checkingInWithController:(UIViewController *)currController;
+ (void)checkingOutWithController:(UIViewController *)currController;

@end
