//
//  MessageCell.m
//  Epitech
//
//  Created by Remi Robert on 16/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "MessageCell.h"
#import "Epitech-swift.h"
#import "PictureProfile.h"

@interface MessageCell()
@property (nonatomic, strong) PictureProfile *pictureProfile;
@property (nonatomic, strong) UILabel *loginUser;
@property (nonatomic, strong) UITextView *title;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UIWebView *contentWeb;
@property (nonatomic, strong) UILabel *date;
@end

@implementation MessageCell

+ (CGFloat) calcHeightContentCell:(NotificationMessage *)message {
    CGFloat heightCell = 28;
    
    NSDictionary *attributesTitle = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13]};
    NSDictionary *attributesContent = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:12]};
    CGRect rectTitle = [message.title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 70, MAXFLOAT)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:attributesTitle
                                                   context:nil];

    CGRect rectContent = [message.title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:attributesContent
                                                     context:nil];

    heightCell += rectTitle.size.height;
    heightCell += rectContent.size.height;
    heightCell += 30;
    return (heightCell);
}

- (void) initContentCell:(NotificationMessage *)message {
    self.pictureProfile = [[PictureProfile alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    
    self.loginUser = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, [UIScreen mainScreen].bounds.size.width / 2, 15)];
    self.loginUser.text = message.user;
    self.loginUser.textColor = [UIColor grayColor];
    self.loginUser.font = [UIFont boldSystemFontOfSize:14];
    
    self.title = [[UITextView alloc] initWithFrame:CGRectMake(70, 28, [UIScreen mainScreen].bounds.size.width - 70, 10)];
    self.title.font = [UIFont boldSystemFontOfSize:13];
    self.title.text = message.title;
    self.title.editable = false;
    self.title.scrollEnabled = false;
    [self.title sizeToFit];
    
    self.date = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2, 10,
                                                          [UIScreen mainScreen].bounds.size.width / 2- 10, 15)];
    self.date.textColor = [UIColor grayColor];
    self.date.textAlignment = NSTextAlignmentRight;
    self.date.font = [UIFont boldSystemFontOfSize:12];
    
    self.contentWeb = [[UIWebView alloc] initWithFrame:CGRectMake(10, 80, [UIScreen mainScreen].bounds.size.width - 20, 30)];
    [self.contentWeb loadHTMLString:message.content baseURL:nil];
    [self.contentWeb sizeToFit];
    
    [self.contentView addSubview:self.date];
    [self.contentView addSubview:self.loginUser];
    [self.contentView addSubview:self.pictureProfile];
    [self.contentView addSubview:self.contentTextView];
    [self.contentView addSubview:self.title];
}

- (void) setContent:(NotificationMessage *)message {
    [self.pictureProfile setImage:nil];
    if ([message.pictureUser isKindOfClass:[NSString class]]) {
        [ImageDownloader downloadImageWithSizeWithUrlImage:message.pictureUser
                                                 sizeImage:CGSizeMake(20, 20) completionBlock:^(UIImage *image) {
            [self.pictureProfile setImage:image];
        }];        
    }
    else {
        [self.pictureProfile setImage:[UIImage imageNamed:@"defaultUserPicture"]];
    }
    self.loginUser.text = message.user;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:message.date];

    Tempo *currentDate = [[Tempo alloc] init];
    
    self.date.text = [[[Tempo alloc] initWithDate:dateFromString] timeAgoFrom:currentDate];
    self.title.text = message.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
