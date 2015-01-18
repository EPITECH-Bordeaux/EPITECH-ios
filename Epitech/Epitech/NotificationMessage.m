//
//  NotificationMessage.m
//  Epitech
//
//  Created by Remi Robert on 16/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "NotificationMessage.h"

@implementation NotificationMessage

- (void) removeHtmlCode {
    if ([self.title componentsSeparatedByString:@"<a"].count == 0) return;
    self.title = [NSString stringWithFormat:@"%@%@", [[self.title componentsSeparatedByString:@"<a"] firstObject],
                  [[[[self.title componentsSeparatedByString:@"\">"] lastObject] componentsSeparatedByString:@"</a>"] firstObject]];
}

- (instancetype) initWithJSONDate:(NSDictionary *)jsonData {
    self = [super init];
    
    if (self) {
        self.title = [jsonData objectForKey:@"title"];
        [self removeHtmlCode];
        self.content = [jsonData objectForKey:@"content"];
        self.date = [jsonData objectForKey:@"date"];
        self.user = [[jsonData objectForKey:@"user"] objectForKey:@"title"];
        self.pictureUser = [[jsonData objectForKey:@"user"] objectForKey:@"picture"];
    }
    return (self);
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.title = [decoder decodeObjectForKey:@"title"];
    self.content = [decoder decodeObjectForKey:@"content"];
    self.date = [decoder decodeObjectForKey:@"date"];
    self.user = [decoder decodeObjectForKey:@"user"];
    self.pictureUser = [decoder decodeObjectForKey:@"pictureUser"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.content forKey:@"content"];
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeObject:self.user forKey:@"user"];
    [encoder encodeObject:self.pictureUser forKey:@"pictureUser"];
}

@end
