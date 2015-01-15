//
//  ViewController.m
//  Epitech
//
//  Created by Remi Robert on 13/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "ViewController.h"
#import "NetworkRequest.h"
#import "JVFloatLabeledTextField.h"
#import "Epitech-swift.h"
#import "Header.h"

const static CGFloat kJVFieldHeight = 44.0f;
const static CGFloat kJVFieldHMargin = 10.0f;
const static CGFloat kJVFieldFontSize = 16.0f;
const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

@interface ViewController()
@property (nonatomic, strong) JVFloatLabeledTextField *loginTextField;
@property (nonatomic, strong) JVFloatLabeledTextField *passwordTextField;
@end

@implementation ViewController

- (void) makeRequestConnection {
    NSDictionary *params = @{@"login":self.loginTextField.text, @"password":self.passwordTextField.text};

    [NetworkRequest POST:LOGIN_ROUTE parameters:params
         blockCompletion:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
         } andErrorCompletion:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
    }];
}

- (void) initForm {
    self.loginTextField = [[JVFloatLabeledTextField alloc] initWithFrame:
                                               CGRectMake(kJVFieldHMargin, 50,
                                                      self.view.frame.size.width - 2 * kJVFieldHMargin,
                                                      kJVFieldHeight)];
    self.loginTextField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Login", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.loginTextField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    self.loginTextField.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    self.loginTextField.floatingLabelTextColor = [UIColor grayColor];
    self.loginTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _passwordTextField = [[JVFloatLabeledTextField alloc] initWithFrame:
                                               CGRectMake(kJVFieldHMargin, 100,
                                                          self.view.frame.size.width - 2 * kJVFieldHMargin,
                                                          kJVFieldHeight)];
    self.passwordTextField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Password Unix", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.passwordTextField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    self.passwordTextField.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    self.passwordTextField.floatingLabelTextColor = [UIColor grayColor];
    self.passwordTextField.secureTextEntry = true;
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    ZFRippleButton *buttonConnect = [[ZFRippleButton alloc] initWithFrame:CGRectMake(0, 200, 200, 40)];
    [buttonConnect setTitle:@"Connection" forState:UIControlStateNormal];
    buttonConnect.backgroundColor = [UIColor colorWithRed:50 / 255.0 green:141 / 255.0 blue:226 / 255.0 alpha:1];
    [buttonConnect setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonConnect.trackTouchLocation = true;
    buttonConnect.buttonCornerRadius = 4;
    buttonConnect.rippleBackgroundColor = [UIColor colorWithRed:50 / 255.0 green:141 / 255.0 blue:226 / 255.0 alpha:1];
    buttonConnect.rippleColor = [UIColor colorWithRed:40 / 255.0 green:123 / 255.0 blue:207 / 255.0 alpha:1];
    [buttonConnect addTarget:self action:@selector(makeRequestConnection) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.loginTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:buttonConnect];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initForm];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
