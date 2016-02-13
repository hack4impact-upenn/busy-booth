//
//  ViewController.m
//  BusyBooth
//
//  Created by Krishna Bharathala on 12/7/15.
//  Copyright © 2015 Krishna Bharathala. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = mainColor;
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton setFrame:CGRectMake(0, 0, 50, 30)];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [loginButton setCenter:CGPointMake(width/2 - 30, height*5/7)];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *signUpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [signUpButton setFrame:CGRectMake(0, 0, 50, 30)];
    [signUpButton setTitle:@"Signup" forState:UIControlStateNormal];
    [signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signUpButton setCenter:CGPointMake(width/2 + 30, height*5/7)];
    [signUpButton addTarget:self action:@selector(signup) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpButton];
    
    self.usernameField = [[UITextField alloc] init];
    [self.usernameField setFrame:CGRectMake(0, 0, 240, 30)];
    [self.usernameField setPlaceholder:@"Username"];
    [self.usernameField setCenter:CGPointMake(width/2, height*4/7)];
    [self.usernameField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:self.usernameField];
    
    self.passwordField = [[UITextField alloc] init];
    [self.passwordField setFrame:CGRectMake(0, 0, 240, 30)];
    [self.passwordField setPlaceholder:@"Password"];
    [self.passwordField setCenter:CGPointMake(width/2, height*9/14)];
    [self.passwordField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.passwordField setSecureTextEntry:YES];
    [self.view addSubview:self.passwordField];
    
}

- (void)login {
    [PFUser logInWithUsernameInBackground:self.usernameField.text password:self.passwordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            [(AppDelegate *)[[UIApplication sharedApplication] delegate] presentSWController];
                                        } else {
                                            [SVProgressHUD showErrorWithStatus:@"Password Incorrect"];
                                        }
                                    }];
}

- (void)signup {
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] presentSignUpViewController];
}

@end
