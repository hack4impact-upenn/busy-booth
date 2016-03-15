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

@property (strong, nonatomic) UITextField *usernameField;
@property (strong, nonatomic) UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = mainColor;
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    UIImageView *logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Oset_Logo2.png"]];
    [logoImage setFrame:CGRectMake(0, 0, 150, 150)];
    [logoImage setCenter:CGPointMake(width/2, height*2/7)];
    [logoImage setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:logoImage];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton setFrame:CGRectMake(0, 0, 50, 30)];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [loginButton setCenter:CGPointMake(width/2 - 30, height*5/7)];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    UIButton *nologinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [nologinButton setFrame:CGRectMake(0, 0, 0, 0)];
    [nologinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nologinButton setTitle:@"Continue without login" forState:UIControlStateNormal];
    [nologinButton sizeToFit];
    [nologinButton setCenter:CGPointMake(width/2, height*25/28)];
    [nologinButton addTarget:self action:@selector(noLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nologinButton];
    
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
    [self.usernameField setDelegate:self];
    self.usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.usernameField.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:self.usernameField];
    
    self.passwordField = [[UITextField alloc] init];
    [self.passwordField setFrame:CGRectMake(0, 0, 240, 30)];
    [self.passwordField setPlaceholder:@"Password"];
    [self.passwordField setCenter:CGPointMake(width/2, height*9/14)];
    [self.passwordField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.passwordField setSecureTextEntry:YES];
    [self.passwordField setDelegate:self];
    [self.view addSubview:self.passwordField];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
}

-(void)dismissKeyboard {
    [self.passwordField resignFirstResponder];
    [self.usernameField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up {
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)login {
    [PFUser logInWithUsernameInBackground:self.usernameField.text password:self.passwordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            [APPDELEGATE presentSWController];
                                            [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:IsLoggedIn];
                                        } else {
                                            [SVProgressHUD showErrorWithStatus:@"Password Incorrect"];
                                        }
                                    }];
}

- (void)noLogin {
    [APPDELEGATE presentSWController];
}

- (void)signup {
    [APPDELEGATE presentSignUpViewController];
}

@end
