//
//  UserInformations.h
//  Epitech
//
//  Created by Remi Robert on 16/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrentStatUser.h"

@interface UserInformations : NSObject

@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *urlPicture;
@property (nonatomic, assign) NSInteger schoolYear;
@property (nonatomic, strong) CurrentStatUser *statUser;

- (instancetype) initWithJSONDate:(NSDictionary *)jsonData;

@end
