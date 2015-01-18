//
//  MarkController.m
//  Epitech
//
//  Created by Remi Robert on 18/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "MarkController.h"
#import "NetworkRequest.h"
#import "Header.h"

@interface MarkController ()

@end

@implementation MarkController

- (void) makeRequestMark {
    [NetworkRequest GET:MARK_ROUTE parameters:@{@"token":self.token}
         blockCompletion:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSDictionary *jsonDict = (NSDictionary *)responseObject;
             NSLog(@"%@", jsonDict);
         } andErrorCompletion:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@", operation.responseString);
             NSLog(@"Error: %@", error);
         }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self makeRequestMark];
}

@end
