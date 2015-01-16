//
//  UserInformations.m
//  Epitech
//
//  Created by Remi Robert on 16/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "UserInformations.h"

@implementation UserInformations

- (instancetype) initWithJSONDate:(NSDictionary *)jsonData {
    self = [super init];
    
    if (self) {
        self.login = [jsonData objectForKey:@"login"];
        self.title = [jsonData objectForKey:@"title"];
        self.urlPicture = [jsonData objectForKey:@"picture"];
        self.schoolYear = [[jsonData objectForKey:@"studentyear"] integerValue];
        self.statUser = [[CurrentStatUser alloc] initWithJSONDate:[jsonData objectForKey:@"current"]];
    }
    return (self);
}

@end
