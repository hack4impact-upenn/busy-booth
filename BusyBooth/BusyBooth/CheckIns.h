//
//  CheckIns.h
//  
//
//  Created by Krishna Bharathala on 3/27/16.
//
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
#import "CheckInViewController.h"

@interface CheckIns : NSObject <UIAlertViewDelegate>

+(void)checkingInWithController:(UIViewController *)currController;
+(void)checkingOutWithController:(UIViewController *)currController;

@end
