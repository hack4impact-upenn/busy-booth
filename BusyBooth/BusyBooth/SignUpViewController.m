//
//  SignUpViewController.m
//  iOS-Starter-App
//
//  Created by Krishna Bharathala on 1/18/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import "SignUpViewController.h"
#import "AppDelegate.h"
#import "Parse/Parse.h"
#import "SVProgressHUD/SVProgressHUD.h"

@interface SignUpViewController ()

@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)signupPressed:(id)sender {
    
    PFUser *user = [PFUser user];
    user.username = self.usernameField.text;
    user.password = self.passwordField.text;
    
    NSLog(@"%@, %@", self.usernameField.text, self.passwordField.text);
    
    // user.email = @"email@example.com";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] presentSWController];
            NSLog(@"Pressed");
        } else {
            NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat: @"%@", errorString]];
            NSLog(@"%@", errorString);
        }
    }];
}

@end
