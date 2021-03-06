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
#import "DashBoardController.h"

@interface ConnectionController()
@property (nonatomic, strong) UITextFieldForm *loginTextField;
@property (nonatomic, strong) UITextFieldForm *passwordTextField;
@end

@implementation ConnectionController

- (void) makeRequestConnection {
    DashBoardController *dashBoardController = [[DashBoardController alloc] init];
    
    if ([self.loginTextField.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"login"]] &&
        [self.passwordTextField.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]] &&
        [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]) {
        dashBoardController.token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        [self presentViewController:dashBoardController animated:true completion:nil];
        return ;
    }
    
//    DashBoardController *dashBoardController = [[DashBoardController alloc] init];
//    dashBoardController.token = @"salut";
//    [self presentViewController:dashBoardController animated:true completion:nil];
//    return ;
    NSDictionary *params = @{@"login":self.loginTextField.text, @"password":self.passwordTextField.text};
    //NSDictionary *params = @{@"login":@"robert_r", @"password":@"fl5>[dWn"};

    [NetworkRequest POST:LOGIN_ROUTE parameters:params
         blockCompletion:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSDictionary *jsonDict = (NSDictionary *)responseObject;
             
             [[NSUserDefaults standardUserDefaults] setObject:self.loginTextField.text forKey:@"login"];
             [[NSUserDefaults standardUserDefaults] setObject:self.passwordTextField.text forKey:@"password"];
             [[NSUserDefaults standardUserDefaults] setObject:[jsonDict objectForKey:@"token"] forKey:@"token"];
             
             dashBoardController.token = [jsonDict objectForKey:@"token"];
             [self presentViewController:dashBoardController animated:true completion:nil];
         } andErrorCompletion:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@", operation.responseString);
             NSLog(@"Error: %@", error);
    }];
}

- (void) initForm {
    self.loginTextField = [[UITextFieldForm alloc] initWithFrame:CGRectMake(kJVFieldHMargin, self.view.frame.size.height / 2 - kJVFieldHeight / 2 - 100,
                                                                           self.view.frame.size.width - 2 * kJVFieldHMargin,
                                                                           kJVFieldHeight)];
    self.loginTextField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Login", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.passwordTextField = [[UITextFieldForm alloc] initWithFrame:CGRectMake(kJVFieldHMargin, self.view.frame.size.height / 2 - kJVFieldHeight / 2 - 50,
                                                                              self.view.frame.size.width - 2 * kJVFieldHMargin,
                                                                               kJVFieldHeight)];
    
    self.passwordTextField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Password Unix", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.passwordTextField.secureTextEntry = true;
    
    ZFRippleButton *buttonConnect = [[ZFRippleButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 100,
                                                                                        self.view.frame.size.height / 2 - kJVFieldHeight / 2, 200, 40)];
    [buttonConnect setTitle:@"Connection" forState:UIControlStateNormal];
    buttonConnect.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:118 / 255.0 blue:255 / 255.0 alpha:1];
    [buttonConnect setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonConnect.trackTouchLocation = true;
    buttonConnect.buttonCornerRadius = 4;
    buttonConnect.rippleBackgroundColor = buttonConnect.backgroundColor;
    buttonConnect.rippleColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    [buttonConnect addTarget:self action:@selector(makeRequestConnection) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.loginTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:buttonConnect];
}

- (void) initUIDesign {
    UIImageView *imageTitle = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 35, 25, 70, 70)];
    imageTitle.image = [UIImage imageNamed:@"title"];
    [self.view addSubview:imageTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initForm];
    [self initUIDesign];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"login"]) {
        self.loginTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"login"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"password"]) {
        self.passwordTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
