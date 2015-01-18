//
//  UserInformations.m
//  Epitech
//
//  Created by Remi Robert on 16/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "UserInformations.h"

@implementation UserInformations

- (instancetype) initWithJSONDate:(NSDictionary *)jsonData currentInformationStat:(NSDictionary *)statInformations {
    self = [super init];
    
    if (self) {
        self.login = [jsonData objectForKey:@"login"];
        self.title = [jsonData objectForKey:@"title"];
        self.urlPicture = [jsonData objectForKey:@"picture"];
        self.schoolYear = [[jsonData objectForKey:@"studentyear"] integerValue];
        self.statUser = [[CurrentStatUser alloc] initWithJSONDate:statInformations];
    }
    return (self);
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.title = [decoder decodeObjectForKey:@"title"];
    self.login = [decoder decodeObjectForKey:@"login"];
    self.urlPicture = [decoder decodeObjectForKey:@"urlPicture"];
    self.schoolYear = [decoder decodeIntegerForKey:@"schoolYear"];
    //self.statUser = [decoder decodeObjectForKey:@"statUser"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.login forKey:@"login"];
    [encoder encodeObject:self.urlPicture forKey:@"urlPicture"];
    [encoder encodeInteger:self.schoolYear forKey:@"schoolYear"];
    //[encoder encodeObject:self.statUser forKey:@"statUser"];
}


@end
