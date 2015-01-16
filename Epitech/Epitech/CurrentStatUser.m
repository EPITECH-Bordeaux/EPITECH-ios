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

@end
