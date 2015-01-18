//
//  Mark.h
//  Epitech
//
//  Created by Remi Robert on 18/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mark : NSObject <NSCoding>

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *module;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, assign) NSInteger note;

- (instancetype) initWithJSONDate:(NSDictionary *)jsonData;

@end
