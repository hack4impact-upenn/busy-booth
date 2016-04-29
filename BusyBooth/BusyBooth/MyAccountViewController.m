//
//  MyAccountViewController.m
//  BusyBooth
//
//  Created by Krishna Bharathala on 2/20/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import "MyAccountViewController.h"

@interface MyAccountViewController ()

@property (nonatomic, strong) UITextField* firstNameField;
@property (nonatomic, strong) UITextField* lastNameField;
@property (nonatomic, strong) UITextField* phoneField;
@property (nonatomic, strong) UITextField* zipField;

@end

@implementation MyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"My Account";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
    setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = mainColor;
    
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = mainColor;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.minimumLineHeight = 50.f;
    style.maximumLineHeight = 50.f;
    
    NSDictionary* attrs = @{
                             NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:18.0f],
                             NSForegroundColorAttributeName:[UIColor blackColor],
                             NSParagraphStyleAttributeName: style
                             };
    NSMutableAttributedString * line1 = [[NSMutableAttributedString alloc] initWithString: @"First Name\n" attributes:attrs];
    NSMutableAttributedString * line2 = [[NSMutableAttributedString alloc] initWithString: @"Last Name\n" attributes:attrs];
    NSMutableAttributedString * line3 = [[NSMutableAttributedString alloc] initWithString: @"Zip Code\n" attributes:attrs];
    NSMutableAttributedString * line4 = [[NSMutableAttributedString alloc] initWithString: @"Phone\n" attributes:attrs];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    NSMutableAttributedString* allLines = [[NSMutableAttributedString alloc] init];
    [allLines appendAttributedString: line1];
    [allLines appendAttributedString: line2];
    [allLines appendAttributedString: line3];
    [allLines appendAttributedString: line4];
    
    UILabel *settingsLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/25, height/7, 200, 200)];
    settingsLabel.attributedText = allLines;
    //addressLabel.font = customFont;
    settingsLabel.numberOfLines = 6;
    settingsLabel.adjustsFontSizeToFitWidth = YES;
    settingsLabel.minimumScaleFactor = 10.0f/12.0f;
    settingsLabel.clipsToBounds = YES;
    settingsLabel.textColor = [UIColor blackColor];
    settingsLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:settingsLabel];
    
    UIColor *borderColor = [UIColor colorWithRed:240.0/256 green:240.0/256 blue:242.0/256 alpha:1.0];
    
    self.firstNameField = [[UITextField alloc] initWithFrame:CGRectMake(0.7*width/2, 1.25*height/7, 200, 40)];
    self.firstNameField.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    self.firstNameField.backgroundColor = [UIColor whiteColor];
    //firstNameField.layer.borderColor = (__bridge CGColorRef _Nullable)borderColor;
    self.firstNameField.layer.borderColor = [borderColor CGColor];
    self.firstNameField.layer.borderWidth = 1.0f;
    self.firstNameField.layer.cornerRadius = 8.0f;
    //self.firstNameField.text = @"First Name";
    self.firstNameField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.firstNameField];
    
    self.lastNameField = [[UITextField alloc] initWithFrame:CGRectMake(0.7*width/2, 1.85*height/7, 200, 40)];
    self.lastNameField.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    self.lastNameField.backgroundColor = [UIColor whiteColor];
    //firstNameField.layer.borderColor = (__bridge CGColorRef _Nullable)borderColor;
    self.lastNameField.layer.borderColor = [borderColor CGColor];
    self.lastNameField.layer.borderWidth = 1.0f;
    self.lastNameField.layer.cornerRadius = 8.0f;
    //self.lastNameField.text = @"Last Name";
    self.lastNameField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.lastNameField];
    
    self.zipField = [[UITextField alloc] initWithFrame:CGRectMake(0.7*width/2, 2.45*height/7, 200, 40)];
    self.zipField.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    self.zipField.backgroundColor = [UIColor whiteColor];
    //firstNameField.layer.borderColor = (__bridge CGColorRef _Nullable)borderColor;
    self.zipField.layer.borderColor = [borderColor CGColor];
    self.zipField.layer.borderWidth = 1.0f;
    self.zipField.layer.cornerRadius = 8.0f;
    //self.zipField.text = @"Zip Code";
    self.zipField.textAlignment = NSTextAlignmentCenter;
    
    self.phoneField = [[UITextField alloc] initWithFrame:CGRectMake(0.7*width/2, 3.05*height/7, 200, 40)];
    self.phoneField.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    self.phoneField.backgroundColor = [UIColor whiteColor];
    //firstNameField.layer.borderColor = (__bridge CGColorRef _Nullable)borderColor;
    self.phoneField.layer.borderColor = [borderColor CGColor];
    self.phoneField.layer.borderWidth = 1.0f;
    self.phoneField.layer.cornerRadius = 8.0f;
    NSMutableString* phoneNumberString = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"curr-number"]]];
    if ([phoneNumberString length] == 10) {
        [phoneNumberString insertString:@"(" atIndex:0];
        [phoneNumberString insertString:@")" atIndex:4];
        [phoneNumberString insertString:@"-" atIndex:5];
        [phoneNumberString insertString:@"-" atIndex:9];
    }
    self.phoneField.text = phoneNumberString;
    self.phoneField.textAlignment = NSTextAlignmentCenter;
    self.phoneField.enabled = NO;
    
    [self.view addSubview:self.phoneField];
    
    [self getInformation];
    
    [self.view addSubview:self.zipField];

    
}

-(void) back {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) save {
    [self.firstNameField resignFirstResponder];
    [self.lastNameField resignFirstResponder];
    [self.phoneField resignFirstResponder];
    [self.zipField resignFirstResponder];
    NSString *post = [NSString stringWithFormat:@"fname=%@&lname=%@&address=%@", self.firstNameField.text, self.lastNameField.text, self.zipField.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:5000/update/%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"curr-number"]]]];
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
    }];
    [dataTask resume];
}

-(void) getInformation {
    
    NSString *post = [NSString stringWithFormat:@"phone=%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"curr-number"]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:5000/lookup/%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"curr-number"]]]];
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
        NSString *zipcode = [loginSuccessful objectForKey: @"address"];
        NSString *firstName = [loginSuccessful objectForKey:@"first_name"];
        NSString *lastName = [loginSuccessful objectForKey:@"last_name"];
        NSLog(@"%@ %@ %@", firstName, lastName, zipcode);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.firstNameField setText:firstName];
            [self.lastNameField setText:lastName];
            [self.zipField setText:zipcode];
        });
    }];
    [dataTask resume];
}

@end
