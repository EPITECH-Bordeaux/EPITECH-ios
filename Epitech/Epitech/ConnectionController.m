//
//  ViewController.m
//  Epitech
//
//  Created by Remi Robert on 13/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "ConnectionController.h"
#import "NetworkRequest.h"
#import "JVFloatLabeledTextField.h"
#import "Epitech-swift.h"
#import "Header.h"
#import "UITextFieldForm.h"

@interface ConnectionController()
@property (nonatomic, strong) UITextFieldForm *loginTextField;
@property (nonatomic, strong) UITextFieldForm *passwordTextField;
@end

@implementation ConnectionController

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
    self.loginTextField = [[UITextFieldForm alloc] initWithFrame:CGRectMake(kJVFieldHMargin, 50,
                                                                           self.view.frame.size.width - 2 * kJVFieldHMargin,
                                                                           kJVFieldHeight)];
    self.loginTextField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Login", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.passwordTextField = [[UITextFieldForm alloc] initWithFrame:CGRectMake(kJVFieldHMargin, 100,
                                                                              self.view.frame.size.width - 2 * kJVFieldHMargin,
                                                                               kJVFieldHeight)];
    
    self.passwordTextField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Password Unix", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.passwordTextField.secureTextEntry = true;
    
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
    self.view.backgroundColor = [UIColor whiteColor];
    [self initForm];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end