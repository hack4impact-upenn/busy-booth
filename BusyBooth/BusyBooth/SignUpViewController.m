//
//  SignUpViewController.m
//  iOS-Starter-App
//
//  Created by Krishna Bharathala on 1/18/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import "SignUpViewController.h"
#import "AppDelegate.h"

@interface SignUpViewController ()

@property (strong, nonatomic) UITextField *usernameField;
@property (strong, nonatomic) UITextField *passwordField;
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = mainColor;
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backButton setFrame:CGRectMake(0, 0, 50, 30)];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton setCenter:CGPointMake(width/2 - 30, height*5/7)];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
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
    [self.usernameField setCenter:CGPointMake(width/2, height*2/7)];
    [self.usernameField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:self.usernameField];
    
    self.passwordField = [[UITextField alloc] init];
    [self.passwordField setFrame:CGRectMake(0, 0, 240, 30)];
    [self.passwordField setPlaceholder:@"Password"];
    [self.passwordField setCenter:CGPointMake(width/2, height*5/14)];
    [self.passwordField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.passwordField setSecureTextEntry:YES];
    [self.view addSubview:self.passwordField];

}

- (void) back {
        [(AppDelegate *)[[UIApplication sharedApplication] delegate] presentLoginViewController];
}

- (void)signup {
    
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