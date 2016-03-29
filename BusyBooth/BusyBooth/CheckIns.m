//
//  CheckIns.m
//  
//
//  Created by Krishna Bharathala on 3/27/16.
//
//

#import "CheckIns.h"

@implementation CheckIns

+(void) checkingInWithController:(MainViewController *)currController {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Checking In"
                                  message:@"Have you reached the polling booth?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:@"isCheckedIn"];
                                    // SEND SOMETHING TO THE SERVER
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [[NSUserDefaults standardUserDefaults] setObject:@"false" forKey:@"isCheckedIn"];
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [currController presentViewController:alert animated:YES completion:nil];
}

+(void) checkingOutWithController:(MainViewController *)currController {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Checking out"
                                  message:@"Have you finished voting?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:@"isCheckedOut"];
                                    [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:@"finishedVoting"];
                                    // SEND SOMETHING TO THE SERVER
                                }];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [[NSUserDefaults standardUserDefaults] setObject:@"false" forKey:@"isCheckedOut"];
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [currController presentViewController:alert animated:YES completion:nil];
}

@end
