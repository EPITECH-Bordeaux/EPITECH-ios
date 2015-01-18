//
//  CalendarEventCell.m
//  Epitech
//
//  Created by Remi Robert on 16/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "CalendarEventCell.h"
#import "Epitech-swift.h"

@interface CalendarEventCell()
@property (nonatomic, strong) UIView *separator;
@property (nonatomic, strong) UITextView *titleEvent;
@property (nonatomic, strong) UITextView *module;
@property (nonatomic, strong) UIView *clock;
@property (nonatomic, strong) UILabel *date;
@property (nonatomic, strong) UILabel *hour;
@end

@implementation CalendarEventCell

+ (CGFloat) calcHeightContentCell:(CalendarEvent *)message {
    CGFloat heightCell = 10;
    
    NSDictionary *attributesTitle = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:14]};
    NSDictionary *attributesModule = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:12]};
    CGRect rectTitle = [message.title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 70, MAXFLOAT)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:attributesTitle
                                                   context:nil];
    
    CGRect rectModule = [message.title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 70, MAXFLOAT)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:attributesModule
                                                     context:nil];
    
    heightCell += rectTitle.size.height;
    heightCell += rectModule.size.height;
    heightCell += 30;
    return (heightCell);
}

- (void) initContentCell:(CalendarEvent *)event {
    self.titleEvent = [[UITextView alloc] initWithFrame:CGRectMake(70, 10, [UIScreen mainScreen].bounds.size.width - 80, 15)];
    self.titleEvent.font = [UIFont boldSystemFontOfSize:14];
    self.titleEvent.textColor = [UIColor grayColor];
    self.titleEvent.text = event.title;
    self.titleEvent.scrollEnabled = false;
    self.titleEvent.editable = false;
    [self.titleEvent sizeToFit];
    
    self.separator = [[UIView alloc] initWithFrame:CGRectMake(34, 0, 3, [CalendarEventCell calcHeightContentCell:event])];
    self.separator.backgroundColor = [UIColor grayColor];
    
    self.clock = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    self.clock.backgroundColor = [UIColor grayColor];
    self.clock.layer.cornerRadius = 25;
    
    self.module = [[UITextView alloc] initWithFrame:CGRectMake(70, self.titleEvent.frame.size.height + 10, self.titleEvent.frame.size.width, 20)];
    self.module.text = event.moduleEvent;
    self.module.editable = false;
    self.module.scrollEnabled = false;
    self.module.font = [UIFont boldSystemFontOfSize:12];
    [self.module sizeToFit];
    
    self.hour = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    self.hour.textColor = [UIColor whiteColor];
    self.hour.textAlignment = NSTextAlignmentCenter;
    self.hour.font = [UIFont boldSystemFontOfSize:10];
    
    [self.clock addSubview:self.hour];
    [self.contentView addSubview:self.separator];
    [self.contentView addSubview:self.clock];
    [self.contentView addSubview:self.titleEvent];
    [self.contentView addSubview:self.module];
    self.backgroundColor = [UIColor clearColor];
}

- (void) setContent:(CalendarEvent *)event {
    self.titleEvent.text = event.title;
    self.module.text = event.moduleEvent;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateStart = [dateFormatter dateFromString:event.start];
    NSDate *dateEnd = [dateFormatter dateFromString:event.end];
    
    Tempo *dateStartTempo = [[Tempo alloc] initWithDate:dateStart];
    Tempo *dateEndTempo = [[Tempo alloc] initWithDate:dateEnd];
    self.hour.text = [dateStartTempo formatDate:@"HH::mm"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
