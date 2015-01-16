//
//  CalendarEvent.h
//  Epitech
//
//  Created by Remi Robert on 16/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarEvent : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *moduleEvent;
@property (nonatomic, strong) NSString *end;
@property (nonatomic, strong) NSString *start;
@property (nonatomic, assign) NSInteger studentRegistered;

- (instancetype) initWithJSONDate:(NSDictionary *)jsonData;

@end
