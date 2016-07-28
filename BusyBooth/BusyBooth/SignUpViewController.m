//
//  SignUpViewController.m
//  BusyBooth
//
//  Created by Krishna Bharathala on 1/18/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#include <CommonCrypto/CommonDigest.h>
#import "AppDelegate.h"
#import "SignUpViewController.h"

@interface SignUpViewController ()

@property (strong, nonatomic) UITextField *firstNameField;
@property (strong, nonatomic) UITextField *lastNameField;
@property (strong, nonatomic) UITextField *DOBField;
@property (strong, nonatomic) UITextField *addressField;
@property (strong, nonatomic) UITextField *zipCodeNumberField;

@property (strong, nonatomic) UIDatePicker *datePicker;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = mainColor;

  CGFloat width = self.view.frame.size.width;
  CGFloat height = self.view.frame.size.height;

  UIImageView *logoImage = [[UIImageView alloc]
      initWithImage:[UIImage imageNamed:@"Oset_Logo2.png"]];
  [logoImage setFrame:CGRectMake(0, 0, 150, 150)];
  [logoImage setCenter:CGPointMake(width / 2, height * 2 / 7)];
  [logoImage setBackgroundColor:[UIColor clearColor]];
  [self.view addSubview:logoImage];

  UIButton *signUpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [signUpButton setFrame:CGRectMake(0, 0, 50, 30)];
  [signUpButton setTitle:@"Signup" forState:UIControlStateNormal];
  [signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [signUpButton setCenter:CGPointMake(width / 2, height * 11 / 14)];
  [signUpButton addTarget:self
                   action:@selector(signup)
         forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:signUpButton];

  self.firstNameField = [[UITextField alloc] init];
  [self.firstNameField setFrame:CGRectMake(0, 0, 240, 30)];
  [self.firstNameField setPlaceholder:@"First Name"];
  [self.firstNameField setCenter:CGPointMake(width / 2, height * 3 / 7)];
  [self.firstNameField setBorderStyle:UITextBorderStyleRoundedRect];
  [self.firstNameField setDelegate:self];
  self.firstNameField.autocorrectionType = UITextAutocorrectionTypeNo;
  self.firstNameField.keyboardType = UIKeyboardTypeASCIICapable;
  [self.view addSubview:self.firstNameField];

  self.lastNameField = [[UITextField alloc] init];
  [self.lastNameField setFrame:CGRectMake(0, 0, 240, 30)];
  [self.lastNameField setPlaceholder:@"Last Name"];
  [self.lastNameField setCenter:CGPointMake(width / 2, height * 1 / 2)];
  [self.lastNameField setBorderStyle:UITextBorderStyleRoundedRect];
  [self.lastNameField setDelegate:self];
  self.lastNameField.autocorrectionType = UITextAutocorrectionTypeNo;
  self.lastNameField.keyboardType = UIKeyboardTypeASCIICapable;
  [self.view addSubview:self.lastNameField];

  self.datePicker = [[UIDatePicker alloc] init];
  self.datePicker.datePickerMode = UIDatePickerModeDate;
  unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
  NSDate *now = [NSDate date];
  NSCalendar *gregorian = [NSCalendar currentCalendar];
  NSDateComponents *comps = [gregorian components:unitFlags fromDate:now];
  [comps setYear:[comps year] - 17];
  NSDate *eighteenYearsAgo = [gregorian dateFromComponents:comps];
  [self.datePicker setMaximumDate:eighteenYearsAgo];
  self.datePicker.date = [NSDate date];

  self.DOBField = [[UITextField alloc] init];
  [self.DOBField setFrame:CGRectMake(0, 0, 240, 30)];
  [self.DOBField setPlaceholder:@"Date of Birth"];
  [self.DOBField setCenter:CGPointMake(width / 2, height * 4 / 7)];
  [self.DOBField setBorderStyle:UITextBorderStyleRoundedRect];
  [self.DOBField setDelegate:self];
  [self.DOBField setInputView:self.datePicker];
  [self.view addSubview:self.DOBField];

  self.addressField = [[UITextField alloc] init];
  [self.addressField setFrame:CGRectMake(0, 0, 240, 30)];
  [self.addressField setPlaceholder:@"Street Address"];
  [self.addressField setCenter:CGPointMake(width / 2, height * 9 / 14)];
  [self.addressField setBorderStyle:UITextBorderStyleRoundedRect];
  [self.addressField setDelegate:self];
  [self.view addSubview:self.addressField];

  self.zipCodeNumberField = [[UITextField alloc] init];
  [self.zipCodeNumberField setFrame:CGRectMake(0, 0, 240, 30)];
  [self.zipCodeNumberField setPlaceholder:@"Zip Code"];
  [self.zipCodeNumberField setCenter:CGPointMake(width / 2, height * 5 / 7)];
  [self.zipCodeNumberField setBorderStyle:UITextBorderStyleRoundedRect];
  [self.zipCodeNumberField setDelegate:self];
  self.zipCodeNumberField.keyboardType = UIKeyboardTypePhonePad;
  [self.view addSubview:self.zipCodeNumberField];

  UIButton *nologinButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [nologinButton setFrame:CGRectMake(0, 0, 0, 0)];
  [nologinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [nologinButton setTitle:@"Continue without signup" forState:UIControlStateNormal];
  [nologinButton sizeToFit];
  [nologinButton setCenter:CGPointMake(width / 2, height * 25 / 28)];
  [nologinButton addTarget:self
                    action:@selector(noLogin)
          forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:nologinButton];

  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(dismissKeyboard)];

  [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.firstNameField resignFirstResponder];
    [self.lastNameField resignFirstResponder];
    [self.DOBField resignFirstResponder];
    [self.addressField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  [self animateTextField:textField up:NO];

  if (textField == self.DOBField) {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM/dd/yy";
    self.DOBField.text = [dateFormatter stringFromDate:self.datePicker.date];
  }
}

- (void)animateTextField:(UITextField *)textField up:(BOOL)up {
  const int movementDistance = 80;      // tweak as needed
  const float movementDuration = 0.3f;  // tweak as needed

  int movement = (up ? -movementDistance : movementDistance);

  [UIView beginAnimations:@"anim" context:nil];
  [UIView setAnimationBeginsFromCurrentState:YES];
  [UIView setAnimationDuration:movementDuration];
  self.view.frame = CGRectOffset(self.view.frame, 0, movement);
  [UIView commitAnimations];
}

- (NSString *)sha256HashForFirstName:(NSString *)fName
                            lastName:(NSString *)lName
                                 DOB:(NSString *)DOB
                             address:(NSString *)address {
    
  NSString *number = [[address componentsSeparatedByString:@" "] firstObject];
  const char *str = [[NSString stringWithFormat:@"%@%@%@%@", fName, lName, DOB, number] UTF8String];
  unsigned char result[CC_SHA256_DIGEST_LENGTH];
  CC_SHA256(str, strlen(str), result);

  NSMutableString *ret =
      [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
  for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
    [ret appendFormat:@"%02x", result[i]];
  }
  return ret;
}

- (void)signup {
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"MM/dd/yyyy"];
  NSString *dob = [dateFormat stringFromDate:self.datePicker.date];
  NSString *hashValue = [self sha256HashForFirstName:self.firstNameField.text
                                            lastName:self.lastNameField.text
                                                 DOB:dob
                                             address:self.addressField.text];

  NSString *post = [NSString stringWithFormat:@"hashVal=%@", hashValue];
  NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
  NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];

  [request setURL:[NSURL URLWithString:@"http://localhost:5000/validate_user"]];
  [request setHTTPMethod:@"POST"];
  [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
  [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
  [request setHTTPBody:postData];

  NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionDataTask *dataTask = [session
      dataTaskWithRequest:request
        completionHandler:^(NSData *data, NSURLResponse *response,
                            NSError *error) {
          NSDictionary *loginSuccessful = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions
                                                                            error:&error];
          if ([[loginSuccessful objectForKey:@"code"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{ [SVProgressHUD showErrorWithStatus:
                @"Signup Failed. Please check that you have entered your information correctly."];
            });

          } else {
              NSString *address = [[loginSuccessful objectForKey:@"data"] objectForKey:@"address"];
              NSString *boothZip = [[loginSuccessful objectForKey:@"data"] objectForKey:@"zip"];
              
              [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"boothAddress"];
              [[NSUserDefaults standardUserDefaults] setObject:boothZip forKey:@"boothZip"];
              
            dispatch_async(dispatch_get_main_queue(), ^{
              [SVProgressHUD showSuccessWithStatus: @"Registered Successfully! Proceeding to app."];
              [APPDELEGATE presentSWController];
            });

            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:IsLoggedIn];

            [[NSUserDefaults standardUserDefaults] setObject:self.firstNameField.text
                                                      forKey:@"fname"];
            [[NSUserDefaults standardUserDefaults] setObject:self.lastNameField.text
                                                      forKey:@"lname"];
            [[NSUserDefaults standardUserDefaults] setObject:self.DOBField.text forKey:@"dob"];
            [[NSUserDefaults standardUserDefaults] setObject:self.addressField.text
                                                      forKey:@"address"];
            [[NSUserDefaults standardUserDefaults] setObject:self.zipCodeNumberField.text
                                                      forKey:@"zip"];
            [[NSUserDefaults standardUserDefaults] setObject:hashValue forKey:@"hash"];
          }
        }];
  [dataTask resume];
}

- (void)noLogin {
    [APPDELEGATE presentSWController];
}

@end
