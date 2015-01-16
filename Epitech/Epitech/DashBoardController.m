//
//  DashBoardController.m
//  Epitech
//
//  Created by Remi Robert on 15/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "DashBoardController.h"
#import "NetworkRequest.h"
#import "Header.h"
#import "UserInformations.h"
#import "UITextFieldForm.h"
#import "PictureProfile.h"
#import "Epitech-swift.h"

@interface DashBoardController ()
@property (nonatomic, strong) UITableView *listCalendar;
@property (nonatomic, strong) UITableView *listMessages;
@property (nonatomic, strong) UISegmentedControl *segmentControlList;
@property (nonatomic, strong) UserInformations *userInformations;
@property (nonatomic, strong) PictureProfile *pictureProfile;
@end

@implementation DashBoardController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (nil);
}

- (void) changeSegment {
    POPSpringAnimation *springAnimationCalendar = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    POPSpringAnimation *springAnimationMessages = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];

    springAnimationCalendar.springBounciness = 10.f;
    springAnimationMessages.springBounciness = 10.f;
    springAnimationCalendar.dynamicsFriction = 20;
    springAnimationMessages.dynamicsFriction = 20;
    if (self.segmentControlList.selectedSegmentIndex == 0) {
        springAnimationCalendar.toValue = @(self.view.frame.size.width / 2);
        springAnimationMessages.toValue = @(self.view.frame.size.width / 2 + self.view.frame.size.width);
    }
    else {
        springAnimationCalendar.toValue = @(-(self.view.frame.size.width / 2));
        springAnimationMessages.toValue = @(self.view.frame.size.width / 2);
    }
    [self.listMessages.layer pop_addAnimation:springAnimationMessages forKey:@"springMessage1"];
    [self.listCalendar.layer pop_addAnimation:springAnimationCalendar forKey:@"springMessage2"];
}

- (void) initDashboardInformationUI {
    self.pictureProfile = [[PictureProfile alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - defaultSizePictureDashboard / 2, 60,
                                                                           defaultSizePictureDashboard, defaultSizePictureDashboard)];
    [self.view addSubview:self.pictureProfile];
}

- (void) makeRequestDashBoardInfos {
    NSDictionary *params = @{@"token":self.token};
    
    [NetworkRequest POST:INFOS_ROUTE parameters:params
         blockCompletion:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSDictionary *jsonDict = (NSDictionary *) responseObject;
             self.userInformations = [[UserInformations alloc] initWithJSONDate:[jsonDict objectForKey:@"infos"]];
             NSLog(@"picture : %@", self.userInformations.urlPicture);
             
            [ImageDownloader downloadImageWithSizeWithUrlImage:[NSString stringWithFormat:@"https://cdn.local.epitech.eu/userprofil/%@",
                                                                self.userInformations.urlPicture]
                                                     sizeImage:self.pictureProfile.frame.size completionBlock:^(UIImage *image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.pictureProfile setImage:image];
                });
            }];
         } andErrorCompletion:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@", operation.responseString);
             NSLog(@"Error: %@", error);
         }];
}

- (void) makeRequestCalendar {
    NSDate *currentDate = [[NSDate alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-DD"];
    NSString *stringFromDate = [formatter stringFromDate:currentDate];
    NSDictionary *params = @{@"token":self.token, @"start":@"2015-01-19", @"end":@"2015-01-19"};
    
    [NetworkRequest GET:PLANNING_ROUTE parameters:params
         blockCompletion:^(AFHTTPRequestOperation *operation, id responseObject) {
//             NSDictionary *jsonDict = (NSDictionary *) responseObject;
//             NSLog(@"%@", responseObject);
             
             for (NSDictionary *currentEvent in (NSArray *)responseObject) {
                 NSLog(@"current EVENT : %@", currentDate);
             }
             
         } andErrorCompletion:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@", operation.responseString);
             NSLog(@"Error: %@", error);
         }];
}

- (void) initTableViewDashBoard {
    self.listCalendar = [[UITableView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width,
                                                                      self.view.frame.size.height - 300)];
    
    self.listCalendar.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
    
    self.listMessages = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 300, self.view.frame.size.width,
                                                                      self.view.frame.size.height - 300)];
    self.listMessages.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
    
    self.segmentControlList = [[UISegmentedControl alloc] initWithItems:@[@"Ma journée", @"Messages"]];
    self.segmentControlList.frame = CGRectMake(10, 275, self.view.frame.size.width - 20, 25);
    self.segmentControlList.selectedSegmentIndex = 0;
    [self.segmentControlList addTarget:self action:@selector(changeSegment) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentControlList];
    
    
    [self.view addSubview:self.listMessages];
    [self.view addSubview:self.listCalendar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initDashboardInformationUI];
    [self initTableViewDashBoard];
    [self makeRequestDashBoardInfos];
    [self makeRequestCalendar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
