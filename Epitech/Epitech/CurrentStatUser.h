//
//  CurrentStatUser.h
//  Epitech
//
//  Created by Remi Robert on 16/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentStatUser : NSObject <NSCoding>

@property (nonatomic, assign) CGFloat activeLog;
@property (nonatomic, assign) CGFloat logMin;
@property (nonatomic, assign) CGFloat logNormal;
@property (nonatomic, assign) NSInteger minimumCredits;
@property (nonatomic, assign) NSInteger progressCredits;
@property (nonatomic, assign) NSInteger achivedCredits;

- (instancetype) initWithJSONDate:(NSDictionary *)jsonData;

@end
