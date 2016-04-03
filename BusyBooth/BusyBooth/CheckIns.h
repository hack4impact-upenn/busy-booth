//
//  CheckIns.h
//  
//
//  Created by Krishna Bharathala on 3/27/16.
//
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"

@interface CheckIns : NSObject <UIAlertViewDelegate>

+(void)checkingInWithController:(MainViewController *)currController;
+(void)checkingOutWithController:(MainViewController *)currController;

@end
