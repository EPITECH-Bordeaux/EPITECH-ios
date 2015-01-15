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

@interface DashBoardController ()
@property (nonatomic, strong) UITableView *listCalendar;
@property (nonatomic, strong) UITableView *listMessages;
@property (nonatomic, strong) UISegmentedControl *segmentControlList;
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

- (void) makeRequestDashBoardInfos {
    NSDictionary *params = @{@"token":self.token};
    
    [NetworkRequest POST:INFOS_ROUTE parameters:params
         blockCompletion:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSDictionary *jsonDict = (NSDictionary *) responseObject;
             NSLog(@"%@", responseObject);
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
    self.segmentControlList.frame = CGRectMake(0, 275, self.view.frame.size.width, 25);
    self.segmentControlList.selectedSegmentIndex = 0;
    [self.segmentControlList addTarget:self action:@selector(changeSegment) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentControlList];
    
    
    [self.view addSubview:self.listMessages];
    [self.view addSubview:self.listCalendar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeRequestDashBoardInfos];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableViewDashBoard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
