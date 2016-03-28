//
//  MyAccountViewController.m
//  BusyBooth
//
//  Created by Krishna Bharathala on 2/20/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import "MyAccountViewController.h"

@interface MyAccountViewController ()

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
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.minimumLineHeight = 50.f;
    style.maximumLineHeight = 50.f;
    
    NSDictionary* attrs = @{
                             NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:18.0f],
                             NSForegroundColorAttributeName:[UIColor blackColor],
                             NSParagraphStyleAttributeName: style
                             };
    NSMutableAttributedString * line1 = [[NSMutableAttributedString alloc] initWithString: @"Username\n" attributes:attrs];
    NSMutableAttributedString * line2 = [[NSMutableAttributedString alloc] initWithString: @"Password\n" attributes:attrs];
    NSMutableAttributedString * line3 = [[NSMutableAttributedString alloc] initWithString: @"Phone\n" attributes:attrs];
    NSMutableAttributedString * line4 = [[NSMutableAttributedString alloc] initWithString: @"Zip Code\n" attributes:attrs];
    
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
    
    UITextField *usernameField = [[UITextField alloc] initWithFrame:CGRectMake(0.7*width/2, 1.25*height/7, 200, 40)];
    usernameField.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    usernameField.backgroundColor = [UIColor whiteColor];
    //usernameField.layer.borderColor = (__bridge CGColorRef _Nullable)borderColor;
    usernameField.layer.borderColor = [borderColor CGColor];
    usernameField.layer.borderWidth = 1.0f;
    usernameField.layer.cornerRadius = 8.0f;
    usernameField.text = @"Username";
    usernameField.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:usernameField];
    
    UITextField *passwordField = [[UITextField alloc] initWithFrame:CGRectMake(0.7*width/2, 1.85*height/7, 200, 40)];
    passwordField.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    passwordField.backgroundColor = [UIColor whiteColor];
    //usernameField.layer.borderColor = (__bridge CGColorRef _Nullable)borderColor;
    passwordField.layer.borderColor = [borderColor CGColor];
    passwordField.layer.borderWidth = 1.0f;
    passwordField.layer.cornerRadius = 8.0f;
    passwordField.text = @"Password";
    passwordField.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:passwordField];
    
    UITextField *phoneField = [[UITextField alloc] initWithFrame:CGRectMake(0.7*width/2, 2.45*height/7, 200, 40)];
    phoneField.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    phoneField.backgroundColor = [UIColor whiteColor];
    //usernameField.layer.borderColor = (__bridge CGColorRef _Nullable)borderColor;
    phoneField.layer.borderColor = [borderColor CGColor];
    phoneField.layer.borderWidth = 1.0f;
    phoneField.layer.cornerRadius = 8.0f;
    phoneField.text = @"000-000-0000";
    phoneField.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:phoneField];
    
    UITextField *zipField = [[UITextField alloc] initWithFrame:CGRectMake(0.7*width/2, 3.05*height/7, 200, 40)];
    zipField.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    zipField.backgroundColor = [UIColor whiteColor];
    //usernameField.layer.borderColor = (__bridge CGColorRef _Nullable)borderColor;
    zipField.layer.borderColor = [borderColor CGColor];
    zipField.layer.borderWidth = 1.0f;
    zipField.layer.cornerRadius = 8.0f;
    zipField.text = @"Zip Code";
    zipField.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:zipField];

    
}

-(void) back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
