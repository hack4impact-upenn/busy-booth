//
//  MyAccountViewController.m
//  BusyBooth
//
//  Created by Krishna Bharathala on 2/20/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import "MyAccountViewController.h"

@interface MyAccountViewController ()

@property (nonatomic, strong) UITextField* usernameField;
@property (nonatomic, strong) UITextField* passwordField;
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
    
    self.usernameField = [[UITextField alloc] initWithFrame:CGRectMake(0.7*width/2, 1.25*height/7, 200, 40)];
    self.usernameField.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    self.usernameField.backgroundColor = [UIColor whiteColor];
    //usernameField.layer.borderColor = (__bridge CGColorRef _Nullable)borderColor;
    self.usernameField.layer.borderColor = [borderColor CGColor];
    self.usernameField.layer.borderWidth = 1.0f;
    self.usernameField.layer.cornerRadius = 8.0f;
    self.usernameField.text = @"Username";
    self.usernameField.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:self.usernameField];
    
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(0.7*width/2, 1.85*height/7, 200, 40)];
    self.passwordField.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    self.passwordField.backgroundColor = [UIColor whiteColor];
    //usernameField.layer.borderColor = (__bridge CGColorRef _Nullable)borderColor;
    self.passwordField.layer.borderColor = [borderColor CGColor];
    self.passwordField.layer.borderWidth = 1.0f;
    self.passwordField.layer.cornerRadius = 8.0f;
    self.passwordField.text = @"Password";
    self.passwordField.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:self.passwordField];
    
    self.phoneField = [[UITextField alloc] initWithFrame:CGRectMake(0.7*width/2, 2.45*height/7, 200, 40)];
    self.phoneField.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    self.phoneField.backgroundColor = [UIColor whiteColor];
    //usernameField.layer.borderColor = (__bridge CGColorRef _Nullable)borderColor;
    self.phoneField.layer.borderColor = [borderColor CGColor];
    self.phoneField.layer.borderWidth = 1.0f;
    self.phoneField.layer.cornerRadius = 8.0f;
    self.phoneField.text = @"000-000-0000";
    self.phoneField.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:self.phoneField];
    
    self.zipField = [[UITextField alloc] initWithFrame:CGRectMake(0.7*width/2, 3.05*height/7, 200, 40)];
    self.zipField.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
    self.zipField.backgroundColor = [UIColor whiteColor];
    //usernameField.layer.borderColor = (__bridge CGColorRef _Nullable)borderColor;
    self.zipField.layer.borderColor = [borderColor CGColor];
    self.zipField.layer.borderWidth = 1.0f;
    self.zipField.layer.cornerRadius = 8.0f;
    self.zipField.text = @"Zip Code";
    self.zipField.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:self.zipField];

    
}

-(void) back {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) save {
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.phoneField resignFirstResponder];
    [self.zipField resignFirstResponder];
}

@end
