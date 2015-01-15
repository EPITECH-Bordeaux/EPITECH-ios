//
//  DashBoardController.h
//  Epitech
//
//  Created by Remi Robert on 15/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <POP.h>

@interface DashBoardController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *token;

@end
