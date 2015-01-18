//
//  CalendarEvent.m
//  Epitech
//
//  Created by Remi Robert on 16/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "CalendarEvent.h"

@implementation CalendarEvent

- (instancetype) initWithJSONDate:(NSDictionary *)jsonData {
    self = [super init];
    
    if (self) {
        self.title = [jsonData objectForKey:@"acti_title"];
        self.moduleEvent = [jsonData objectForKey:@"titlemodule"];
        self.end = [jsonData objectForKey:@"end"];
        self.start = [jsonData objectForKey:@"start"];
        self.studentRegistered = [[jsonData objectForKey:@"total_students_registered"] integerValue];
    }
    return (self);
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.title = [decoder decodeObjectForKey:@"title"];
    self.moduleEvent = [decoder decodeObjectForKey:@"moduleEvent"];
    self.end = [decoder decodeObjectForKey:@"end"];
    self.start = [decoder decodeObjectForKey:@"start"];
    self.studentRegistered = [decoder decodeIntegerForKey:@"studentRegistered"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.moduleEvent forKey:@"moduleEvent"];
    [encoder encodeObject:self.end forKey:@"end"];
    [encoder encodeObject:self.start forKey:@"start"];
    [encoder encodeInteger:self.studentRegistered forKey:@"studentRegistered"];
}


@end
