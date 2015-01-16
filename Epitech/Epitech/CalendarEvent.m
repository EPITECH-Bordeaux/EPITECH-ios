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

@end
