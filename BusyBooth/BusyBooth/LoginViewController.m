//
//  ViewController.m
//  BusyBooth
//
//  Created by Krishna Bharathala on 12/7/15.
//  Copyright © 2015 Krishna Bharathala. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "Parse/Parse.h"
#import "SVProgressHUD/SVProgressHUD.h"

#import "AppDelegate.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)loginButtonPressed:(id)sender;
- (IBAction)signUpButtonPressed:(id)sender;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
}

- (IBAction)loginButtonPressed:(id)sender {
    NSLog(@"%@, %@", self.usernameField.text, self.passwordField.text);
    [PFUser logInWithUsernameInBackground:self.usernameField.text password:self.passwordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            [(AppDelegate *)[[UIApplication sharedApplication] delegate] presentSWController];
                                        } else {
                                            [SVProgressHUD showErrorWithStatus:@"Password Incorrect"];
                                        }
                                    }];
}

- (IBAction)signUpButtonPressed:(id)sender {
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] presentSignUpViewController];
}

@end
