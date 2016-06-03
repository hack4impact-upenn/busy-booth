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
@property (strong, nonatomic) UITextField *phoneNumberField;
@property (strong, nonatomic) UITableView *autocompleteTableView;
@property (strong, nonatomic) NSMutableArray *resultsArray;

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
    
    self.phoneNumberField = [[UITextField alloc] init];
    [self.phoneNumberField setFrame:CGRectMake(0, 0, 240, 30)];
    [self.phoneNumberField setPlaceholder:@"Phone Number"];
    [self.phoneNumberField setCenter:CGPointMake(width/2, height*4/7)];
    [self.phoneNumberField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.phoneNumberField setDelegate:self];
    self.phoneNumberField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.phoneNumberField];
    
//    self.autocompleteTableView = [[UITableView alloc] initWithFrame:
//                             CGRectMake(0, height*4/7+30, 320, 120) style:UITableViewStylePlain];
//    self.autocompleteTableView.delegate = self;
//    self.autocompleteTableView.dataSource = self;
//    self.autocompleteTableView.scrollEnabled = YES;
//    self.autocompleteTableView.hidden = YES;
//    [self.view addSubview:self.autocompleteTableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    self.autocompleteTableView.hidden = NO;
//    
//    NSString *substring = [NSString stringWithString:textField.text];
//    substring = [substring
//                 stringByReplacingCharactersInRange:range withString:string];
//    [self searchAutocompleteEntriesWithSubstring:substring];
//    return YES;
//}
//
//- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
//    
//    // Put anything that starts with this substring into the autocompleteUrls array
//    // The items in this array is what will show up in the table view
////    [autocompleteUrls removeAllObjects];
////    for(NSString *curString in pastUrls) {
////        NSRange substringRange = [curString rangeOfString:substring];
////        if (substringRange.location == 0) {
////            [autocompleteUrls addObject:curString];
////        }
////    }
////    [self.autocompleteTableView reloadData];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.resultsArray count];
//}

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
    
    NSString *post = [NSString stringWithFormat:@"phone=%@", self.phoneNumberField.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:@"http://localhost:5000/login"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          if(data) {
                                              NSDictionary *loginSuccessful = [NSJSONSerialization JSONObjectWithData:data
                                                                                                              options:kNilOptions
                                                                                                                error:&error];
                                              if([[loginSuccessful objectForKey:@"logged_in"] boolValue]) {
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [APPDELEGATE presentSWController];
                                                  });
                                                  [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:IsLoggedIn];
                                                  [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isAuthenticated"];
                                                  [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumberField.text forKey:@"curr-number"];
                                              } else {
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [SVProgressHUD showErrorWithStatus:@"This does not match our records. Try Again."];
                                                  });
                                              }
                                          } else {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [SVProgressHUD showErrorWithStatus:@"An error occurred. Check if you are connected to the internet."];
                                              });
                                          }
                                      }];
    [dataTask resume];

//    [APPDELEGATE presentSWController];
//    [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:IsLoggedIn];
//    [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumberField.text forKey:@"curr-number"];
}

- (void)noLogin {
    [APPDELEGATE presentSWController];
}

- (void)signup {
    [APPDELEGATE presentSignUpViewController];
}

@end
