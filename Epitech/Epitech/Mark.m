//
//  Mark.m
//  Epitech
//
//  Created by Remi Robert on 18/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "Mark.h"

@implementation Mark

- (instancetype) initWithJSONDate:(NSDictionary *)jsonData {
    self = [super init];
    
    if (self) {
        self.title = [jsonData objectForKey:@"title"];
        self.date = [jsonData objectForKey:@"date"];
        self.comment = [jsonData objectForKey:@"comment"];
        self.module = [jsonData objectForKey:@"module"];
        self.from = [jsonData objectForKey:@"from"];
        self.note = [[jsonData objectForKey:@"final_note"] integerValue];
    }
    return (self);
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.date = [aDecoder decodeObjectForKey:@"date"];
    self.comment = [aDecoder decodeObjectForKey:@"comment"];
    self.module = [aDecoder decodeObjectForKey:@"module"];
    self.from = [aDecoder decodeObjectForKey:@"from"];
    self.note = [aDecoder decodeIntegerForKey:@"final_note"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.comment forKey:@"comment"];
    [aCoder encodeObject:self.module forKey:@"module"];
    [aCoder encodeObject:self.from forKey:@"from"];
    [aCoder encodeInteger:self.note forKey:@"final_note"];
}

@end
