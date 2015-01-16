//
//  NotificationMessage.h
//  Epitech
//
//  Created by Remi Robert on 16/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationMessage : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *pictureUser;

- (instancetype) initWithJSONDate:(NSDictionary *)jsonData;

@end
