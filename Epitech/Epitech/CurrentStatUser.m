//
//  CurrentStatUser.m
//  Epitech
//
//  Created by Remi Robert on 16/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "CurrentStatUser.h"

@implementation CurrentStatUser

- (instancetype) initWithJSONDate:(NSDictionary *)jsonData {
    self = [super init];
    
    if (self) {
        self.activeLog = (CGFloat)[[jsonData objectForKey:@"active_log"] floatValue];
        self.logMin = (CGFloat)[[jsonData objectForKey:@"nslog_min"] floatValue];
        self.logNormal = (CGFloat)[[jsonData objectForKey:@"nslog_norm"] floatValue];
        self.minimumCredits = [[jsonData objectForKey:@"credits_min"] integerValue];
        self.progressCredits = (CGFloat)[[jsonData objectForKey:@"inprogress"] floatValue];
        self.achivedCredits = (CGFloat)[[jsonData objectForKey:@"achieved"] floatValue];
    }
    return (self);
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.activeLog = [decoder decodeFloatForKey:@"activeLog"];
    self.logMin = [decoder decodeFloatForKey:@"logMin"];
    self.logNormal = [decoder decodeFloatForKey:@"logNormal"];
    self.minimumCredits = [decoder decodeIntegerForKey:@"minimumCredits"];
    self.progressCredits = [decoder decodeIntegerForKey:@"progressCredits"];
    self.achivedCredits = [decoder decodeIntegerForKey:@"achivedCredits"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeFloat:self.activeLog forKey:@"activeLog"];
    [encoder encodeFloat:self.logMin forKey:@"logMin"];
    [encoder encodeFloat:self.logNormal forKey:@"logNormal"];
    [encoder encodeInteger:self.minimumCredits forKey:@"minimumCredits"];
    [encoder encodeInteger:self.progressCredits forKey:@"progressCredits"];
    [encoder encodeInteger:self.achivedCredits forKey:@"achivedCredits"];
}

@end
