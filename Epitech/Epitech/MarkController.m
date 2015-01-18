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
#import "Mark.h"
#import "MarkCell.h"

@interface MarkController ()
@property (nonatomic, strong) NSMutableArray *marks;
@property (nonatomic, strong) UITableView *listMark;
@end

@implementation MarkController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.marks.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MarkCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSE_IDENTIFIER_MARK_CELL];
    
    if (!cell) {
        cell = [[MarkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSE_IDENTIFIER_MARK_CELL];
        [cell initContentCell:[self.marks objectAtIndex:indexPath.row]];
    }
    [cell setContent:[self.marks objectAtIndex:indexPath.row]];
    return (cell);
}

- (void) makeRequestMark {
    [NetworkRequest GET:MARK_ROUTE parameters:@{@"token":self.token}
         blockCompletion:^(AFHTTPRequestOperation *operation, id responseObject) {
             self.marks = [[NSMutableArray alloc] init];
             for (NSDictionary *currentMark in (NSArray *)responseObject) {
                 [self.marks addObject:[[Mark alloc] initWithJSONDate:currentMark]];
             }
             NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.marks];
             [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"marks"];
             [self.listMark reloadData];
             NSLog(@"%@", self.listMark);
         } andErrorCompletion:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@", operation.responseString);
             NSLog(@"Error: %@", error);
         }];
}

- (void) initMarkList {
    self.listMark = [[UITableView alloc] initWithFrame:self.view.frame];
    self.listMark.backgroundColor = [UIColor clearColor];
    self.listMark.delegate = self;
    self.listMark.dataSource = self;
    [self.view addSubview:self.listMark];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initMarkList];
    [self makeRequestMark];
}

@end
