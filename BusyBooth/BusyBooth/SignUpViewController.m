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

@property (strong, nonatomic) UITextField *firstNameField;
@property (strong, nonatomic) UITextField *lastNameField;
@property (strong, nonatomic) UITextField *phoneNumberField;
@property (strong, nonatomic) UITextField *zipCodeNumberField;

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
    
    self.firstNameField = [[UITextField alloc] init];
    [self.firstNameField setFrame:CGRectMake(0, 0, 240, 30)];
    [self.firstNameField setPlaceholder:@"First Name"];
    [self.firstNameField setCenter:CGPointMake(width/2, height*2/7)];
    [self.firstNameField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.firstNameField setDelegate:self];
//    self.firstNameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.firstNameField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.firstNameField.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:self.firstNameField];
    
    self.lastNameField = [[UITextField alloc] init];
    [self.lastNameField setFrame:CGRectMake(0, 0, 240, 30)];
    [self.lastNameField setPlaceholder:@"Last Name"];
    [self.lastNameField setCenter:CGPointMake(width/2, height*5/14)];
    [self.lastNameField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.lastNameField setDelegate:self];
//    self.lastNameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.lastNameField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.lastNameField.keyboardType = UIKeyboardTypeASCIICapable;
    [self.view addSubview:self.lastNameField];
    
//    self.passwordField = [[UITextField alloc] init];
//    [self.passwordField setFrame:CGRectMake(0, 0, 240, 30)];
//    [self.passwordField setPlaceholder:@"Password"];
//    [self.passwordField setCenter:CGPointMake(width/2, height*5/14)];
//    [self.passwordField setBorderStyle:UITextBorderStyleRoundedRect];
//    [self.passwordField setSecureTextEntry:YES];
//    [self.passwordField setDelegate:self];
//    [self.view addSubview:self.passwordField];
    
    self.phoneNumberField = [[UITextField alloc] init];
    [self.phoneNumberField setFrame:CGRectMake(0, 0, 240, 30)];
    [self.phoneNumberField setPlaceholder:@"Phone Number"];
    [self.phoneNumberField setCenter:CGPointMake(width/2, height*3/7)];
    [self.phoneNumberField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.phoneNumberField setDelegate:self];
//    self.phoneNumberField.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    self.phoneNumberField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.phoneNumberField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:self.phoneNumberField];
    
    self.zipCodeNumberField = [[UITextField alloc] init];
    [self.zipCodeNumberField setFrame:CGRectMake(0, 0, 240, 30)];
    [self.zipCodeNumberField setPlaceholder:@"Zip Code"];
    [self.zipCodeNumberField setCenter:CGPointMake(width/2, height*1/2)];
    [self.zipCodeNumberField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.zipCodeNumberField setDelegate:self];
//    self.zipCodeNumber.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    self.zipCodeNumber.autocorrectionType = UITextAutocorrectionTypeNo;
    self.zipCodeNumberField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:self.zipCodeNumberField];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

}

-(void)dismissKeyboard {
    [self.firstNameField resignFirstResponder];
    [self.lastNameField resignFirstResponder];
    [self.phoneNumberField resignFirstResponder];
    [self.zipCodeNumberField resignFirstResponder];
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

- (void) back {
    [APPDELEGATE presentLoginViewController];
}

- (void)signup {
    
    NSString *post = [NSString stringWithFormat:@"fname=%@&lname=%@&phone=%@&address=%@", self.firstNameField.text,
                      self.lastNameField.text, self.phoneNumberField.text, self.zipCodeNumberField.text];
    NSLog(@"%@", post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:@"http://localhost:5000/create_account"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          NSDictionary *loginSuccessful = [NSJSONSerialization JSONObjectWithData:data
                                                                                                          options:kNilOptions
                                                                                                            error:&error];
                                          NSLog(@"%@", loginSuccessful);
                                          if([[loginSuccessful objectForKey:@"code"] integerValue] == 0) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [APPDELEGATE presentSWController];
                                              });
                                              [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:IsLoggedIn];
                                          } else if([[loginSuccessful objectForKey:@"code"] integerValue] == 2) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [SVProgressHUD showErrorWithStatus:@"This phone number is already in use"];
                                              });
                                          } else {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [SVProgressHUD showErrorWithStatus:@"Signup Failed. Try Again Later"];
                                              });
                                          }
                                      }];
    [dataTask resume];
}

@end
