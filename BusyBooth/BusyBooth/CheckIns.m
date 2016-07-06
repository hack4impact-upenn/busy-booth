//
//  CheckIns.m
//  BusyBooth
//
//  Created by Krishna Bharathala on 1/18/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import "CheckIns.h"

@implementation CheckIns

+ (void)checkingInWithController:(UIViewController *)currController {
  UIAlertController *alert = [UIAlertController
      alertControllerWithTitle:@"Checking In"
                       message:@"Have you reached the polling booth?"
                preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *yesButton = [UIAlertAction
      actionWithTitle:@"Yes"
                style:UIAlertActionStyleDefault
              handler:^(UIAlertAction *action) {
                [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:@"isCheckedIn"];

                if ([currController isKindOfClass:[CheckInViewController class]]) {
                  [(CheckInViewController *)currController startTimer];
                }

                NSString *post =
                    [NSString stringWithFormat:@"phone=%@", [[NSUserDefaults standardUserDefaults]
                                                             objectForKey:@"curr-number"]];
                NSData *postData =
                    [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
                NSString *postLength =
                    [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];

                [request setURL:[NSURL URLWithString: @"http://localhost:5000/start_time"]];
                [request setHTTPMethod:@"POST"];
                [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
                [request setValue:@"application/x-www-form-urlencoded"
               forHTTPHeaderField:@"Content-Type"];
                [request setHTTPBody:postData];

                NSURLSession *session = [NSURLSession sharedSession];
                NSURLSessionDataTask *dataTask = [session
                    dataTaskWithRequest:request
                      completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                        if (data) {
                          NSDictionary *loginSuccessful =
                              [NSJSONSerialization JSONObjectWithData:data
                                                              options:kNilOptions
                                                                error:&error];
                          NSLog(@"%@", loginSuccessful);
                        } else {
                          NSLog(@"hey");
                        }
                      }];
                [dataTask resume];
              }];
    
  UIAlertAction *noButton = [UIAlertAction actionWithTitle:@"No"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action) {
                                                       [[NSUserDefaults standardUserDefaults]
                                                            setObject:@"false"
                                                               forKey:@"isCheckedIn"];
                                                   }];

  [alert addAction:yesButton];
  [alert addAction:noButton];

  [currController presentViewController:alert animated:YES completion:nil];
}

+ (void)checkingOutWithController:(UIViewController *)currController {
  UIAlertController *alert =
      [UIAlertController alertControllerWithTitle:@"Checking out"
                                          message:@"Have you finished voting?"
                                   preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *yesButton = [UIAlertAction
      actionWithTitle:@"Yes"
                style:UIAlertActionStyleDefault
              handler:^(UIAlertAction *action) {
                  [[NSUserDefaults standardUserDefaults] setObject:@"true"
                                                            forKey:@"isCheckedOut"];
                  [[NSUserDefaults standardUserDefaults] setObject:@"true"
                                                            forKey:@"finishedVoting"];
                  if ([currController isKindOfClass:[CheckInViewController class]]) {
                      [(CheckInViewController *)currController stopTimer];
                  }

                //                                    NSString *post = [NSString
                //                                    stringWithFormat:@"phone=%@",
                //                                    [[NSUserDefaults
                //                                    standardUserDefaults]
                //                                    objectForKey:@"curr-number"]];
                //                                    NSData *postData = [post
                //                                    dataUsingEncoding:NSASCIIStringEncoding
                //                                    allowLossyConversion:YES];
                //                                    NSString *postLength =
                //                                    [NSString
                //                                    stringWithFormat:@"%lu",(unsigned
                //                                    long)[postData length]];
                //                                    NSMutableURLRequest
                //                                    *request =
                //                                    [[NSMutableURLRequest
                //                                    alloc] init];
                //
                //
                //                                    [request setURL:[NSURL
                //                                    URLWithString:@"http://localhost:5000/end_time"]];
                //                                    [request
                //                                    setHTTPMethod:@"POST"];
                //                                    [request
                //                                    setValue:postLength
                //                                    forHTTPHeaderField:@"Content-Length"];
                //                                    [request
                //                                    setValue:@"application/x-www-form-urlencoded"
                //                                    forHTTPHeaderField:@"Content-Type"];
                //                                    [request
                //                                    setHTTPBody:postData];
                //
                //                                    NSURLSession *session =
                //                                    [NSURLSession
                //                                    sharedSession];
                //                                    NSURLSessionDataTask
                //                                    *dataTask = [session
                //                                    dataTaskWithRequest:request
                //                                                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                //                                                                      {
                //                                                                          NSDictionary *loginSuccessful = [NSJSONSerialization JSONObjectWithData:data
                //                                                                                                                                          options:kNilOptions
                //                                                                                                                                            error:&error];
                //                                                                          NSLog(@"%@", loginSuccessful);
                //                                                                      }];
                //                                    [dataTask resume];

              }];

  UIAlertAction *noButton = [UIAlertAction actionWithTitle:@"No"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action) {
                                                       [[NSUserDefaults standardUserDefaults]
                                                            setObject:@"false"
                                                               forKey:@"isCheckedOut"];
                                                   }];

  [alert addAction:yesButton];
  [alert addAction:noButton];

  [currController presentViewController:alert animated:YES completion:nil];
}

@end
