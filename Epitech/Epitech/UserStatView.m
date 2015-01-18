//
//  UserStatView.m
//  Epitech
//
//  Created by Remi Robert on 18/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "UserStatView.h"

@interface UserStatView()
@property (nonatomic, strong) UIImageView *logImage;
@property (nonatomic, strong) UIImageView *creditsImage;
@property (nonatomic, strong) UILabel *labelLog;
@property (nonatomic, strong) UILabel *labelCredits;
@property (nonatomic, strong) UILabel *titleLog;
@property (nonatomic, strong) UILabel *titleCredits;
@end

@implementation UserStatView

- (void) setLog:(NSInteger)log {
    self.labelLog.text = [NSString stringWithFormat:@"%dh", log];
    [self.labelLog sizeToFit];
}

- (void) setCredits:(NSInteger)credits {
    self.labelCredits.text = [NSString stringWithFormat:@"%d", credits];
    [self.labelCredits sizeToFit];
}

- (void) initImageStat:(CGRect)frame {
    self.labelLog = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 35, frame.size.width / 2, 20)];
    self.labelLog.textAlignment = NSTextAlignmentLeft;
    self.labelLog.textColor = [UIColor blackColor];
    self.labelLog.font = [UIFont boldSystemFontOfSize:15];
    self.labelLog.text = @"";
    [self.labelLog sizeToFit];

    self.titleLog = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 20, frame.size.width / 2, 20)];
    self.titleLog.textAlignment = NSTextAlignmentLeft;
    self.titleLog.textColor = [UIColor grayColor];
    self.titleLog.font = [UIFont boldSystemFontOfSize:15];
    self.titleLog.text = @"Log actifs";
    [self.titleLog sizeToFit];
    
    self.labelCredits = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width / 3, frame.size.height - 35, frame.size.width / 2, 20)];
    self.labelCredits.textAlignment = NSTextAlignmentLeft;
    self.labelCredits.textColor = [UIColor blackColor];
    self.labelCredits.font = [UIFont boldSystemFontOfSize:14];
    self.labelCredits.text = @"w";
    [self.labelCredits sizeToFit];
    
    self.titleCredits = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width / 3, frame.size.height - 20, frame.size.width / 2, 20)];
    self.titleCredits.textAlignment = NSTextAlignmentLeft;
    self.titleCredits.textColor = [UIColor grayColor];
    self.titleCredits.font = [UIFont boldSystemFontOfSize:15];
    self.titleCredits.text = @"Credits en cours";
    [self.titleCredits sizeToFit];

    
    self.labelLog.frame = CGRectMake(10, self.labelLog.frame.origin.y, self.labelLog.frame.size.width, self.labelLog.frame.size.height);
    self.titleLog.frame = CGRectMake(10, self.titleLog.frame.origin.y, self.titleLog.frame.size.width, self.titleLog.frame.size.height);
    
    self.labelCredits.frame = CGRectMake(frame.size.width / 3, self.labelCredits.frame.origin.y, self.labelCredits.frame.size.width, self.labelCredits.frame.size.height);
    self.titleCredits.frame = CGRectMake(frame.size.width / 3, self.titleCredits.frame.origin.y, self.titleCredits.frame.size.width, self.titleCredits.frame.size.height);
    
    
    [self addSubview:self.logImage];
    [self addSubview:self.creditsImage];
    [self addSubview:self.labelLog];
    [self addSubview:self.titleLog];
    [self addSubview:self.labelCredits];
    [self addSubview:self.titleCredits];
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self initImageStat:frame];
    }
    return (self);
}

@end
