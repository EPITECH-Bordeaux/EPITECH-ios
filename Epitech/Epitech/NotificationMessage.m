//
//  NotificationMessage.m
//  Epitech
//
//  Created by Remi Robert on 16/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "NotificationMessage.h"

@implementation NotificationMessage

- (instancetype) initWithJSONDate:(NSDictionary *)jsonData {
    self = [super init];
    
    if (self) {
        self.title = [jsonData objectForKey:@"title"];
        self.content = [jsonData objectForKey:@"content"];
        self.date = [jsonData objectForKey:@"date"];
        self.user = [[jsonData objectForKey:@"user"] objectForKey:@"title"];
        self.pictureUser = [[jsonData objectForKey:@"user"] objectForKey:@"picture"];
    }
    return (self);
}

@end