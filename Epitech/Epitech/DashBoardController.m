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
#import "CalendarEvent.h"
#import "CalendarEventCell.h"
#import "NotificationMessage.h"
#import "MessageCell.h"

@interface DashBoardController ()
@property (nonatomic, strong) UITableView *listCalendar;
@property (nonatomic, strong) UITableView *listMessages;
@property (nonatomic, strong) UISegmentedControl *segmentControlList;
@property (nonatomic, strong) UserInformations *userInformations;
@property (nonatomic, strong) PictureProfile *pictureProfile;

@property (nonatomic, strong) NSMutableArray *calendarEvent;
@property (nonatomic, strong) NSMutableArray *messages;
@end

# define TAG_LIST_CALENDAR_EVENT        1
# define TAG_LIST_MESSAGES              2

@implementation DashBoardController

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == TAG_LIST_MESSAGES) {
        return ([MessageCell calcHeightContentCell:(NotificationMessage *)[self.messages objectAtIndex:indexPath.row]]);
    }
    else if (tableView.tag == TAG_LIST_CALENDAR_EVENT) {
        return ([CalendarEventCell calcHeightContentCell:(CalendarEvent *)[self.calendarEvent objectAtIndex:indexPath.row]]);
    }
    return (50);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == TAG_LIST_CALENDAR_EVENT) {
        return (self.calendarEvent.count);
    }
    else if (tableView.tag == TAG_LIST_MESSAGES) {
        return (self.messages.count);
    }
    return (0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == TAG_LIST_CALENDAR_EVENT) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSE_IDENTIFIER_CALENDAR_CELL];
        if (!cell) {
            cell = [[CalendarEventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSE_IDENTIFIER_CALENDAR_CELL];
            [((CalendarEventCell *)cell) initContentCell:((CalendarEvent *)[self.calendarEvent objectAtIndex:indexPath.row])];
        }
        [((CalendarEventCell *)cell) setContent:((CalendarEvent *)[self.calendarEvent objectAtIndex:indexPath.row])];
        return (cell);
    }
    else if (tableView.tag == TAG_LIST_MESSAGES) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSE_IDENTIFIER_MESSAGE_CELL];
        if (!cell) {
            cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSE_IDENTIFIER_MESSAGE_CELL];
            [((MessageCell *)cell) initContentCell:((NotificationMessage *)[self.messages objectAtIndex:indexPath.row])];
        }
        [((MessageCell *)cell) setContent:((NotificationMessage *)[self.messages objectAtIndex:indexPath.row])];
        return (cell);
    }
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
    CGFloat sizePictureProfile = ([UIScreen mainScreen].bounds.size.height / 2 - 94) / 2;
    self.pictureProfile = [[PictureProfile alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - sizePictureProfile / 2, 74,
                                                                           sizePictureProfile, sizePictureProfile)];
    [self.view addSubview:self.pictureProfile];
}

- (void) makeRequestDashBoardInfos {
    NSDictionary *params = @{@"token":self.token};
    
    [NetworkRequest POST:INFOS_ROUTE parameters:params
         blockCompletion:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSDictionary *jsonDict = (NSDictionary *) responseObject;
             self.userInformations = [[UserInformations alloc] initWithJSONDate:[jsonDict objectForKey:@"infos"]
                                                         currentInformationStat:[jsonDict objectForKey:@"current"]];
             NSLog(@"picture : %@", self.userInformations.urlPicture);
             NSLog(@"current log %f", self.userInformations.statUser.activeLog);
             
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

- (void) makeRequestMessages {
    NSDictionary *params = @{@"token":self.token};
    
    [NetworkRequest GET:MESSAGES_ROUTE parameters:params
        blockCompletion:^(AFHTTPRequestOperation *operation, id responseObject) {
            self.messages = [[NSMutableArray alloc] init];
            for (NSDictionary *currentMessage in (NSArray *)responseObject) {
                NSLog(@"current event %@", currentMessage);
                [self.messages addObject:[[NotificationMessage alloc] initWithJSONDate:currentMessage]];
            }
            [self.listMessages reloadData];
        } andErrorCompletion:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", operation.responseString);
            NSLog(@"Error: %@", error);
        }];

}

- (void) makeRequestCalendar {
//    NSDate *currentDate = [[NSDate alloc]init];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY-MM-DD"];
//    NSString *stringFromDate = [formatter stringFromDate:currentDate];
    NSDictionary *params = @{@"token":self.token, @"start":@"2015-01-19", @"end":@"2015-01-19"};
    
    [NetworkRequest GET:PLANNING_ROUTE parameters:params
         blockCompletion:^(AFHTTPRequestOperation *operation, id responseObject) {
             self.calendarEvent = [[NSMutableArray alloc] init];
             for (NSDictionary *currentEvent in (NSArray *)responseObject) {
                 if ([[currentEvent objectForKey:@"event_registered"] isKindOfClass:[NSString class]]) {
                     [self.calendarEvent addObject:[[CalendarEvent alloc] initWithJSONDate:currentEvent]];
                 }
             }
             [self.listCalendar reloadData];
         } andErrorCompletion:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@", operation.responseString);
             NSLog(@"Error: %@", error);
         }];
}

- (void) initTableViewDashBoard {
    self.listCalendar = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 2, self.view.frame.size.width,
                                                                      self.view.frame.size.height / 2)];
    self.listMessages = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, self.view.frame.size.height / 2,
                                                                      self.view.frame.size.width, self.view.frame.size.height / 2)];

    
    self.listCalendar.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listCalendar.dataSource = self;
    self.listCalendar.delegate = self;
    self.listMessages.dataSource = self;
    self.listMessages.delegate = self;
    self.listCalendar.tag = TAG_LIST_CALENDAR_EVENT;
    self.listMessages.tag = TAG_LIST_MESSAGES;
    self.segmentControlList = [[UISegmentedControl alloc] initWithItems:@[@"Ma journée", @"Messages"]];
    self.segmentControlList.frame = CGRectMake(10, self.view.frame.size.height / 2 - 35, self.view.frame.size.width - 20, 25);
    self.segmentControlList.selectedSegmentIndex = 0;
    [self.segmentControlList addTarget:self action:@selector(changeSegment) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentControlList];
    
    
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    navigationBar.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:navigationBar];
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
    [self makeRequestMessages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
