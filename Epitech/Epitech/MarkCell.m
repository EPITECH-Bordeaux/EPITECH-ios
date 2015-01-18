//
//  MarkCell.m
//  Epitech
//
//  Created by Remi Robert on 18/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "MarkCell.h"

@interface MarkCell()
@property (nonatomic, strong) UIView *markView;
@property (nonatomic, strong) UILabel *note;
@end

@implementation MarkCell

- (void) initContentCell:(Mark *)mark {
    self.markView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    self.markView.backgroundColor = [UIColor colorWithRed:0 green:118 / 255.0 blue:255 / 255.0 alpha:1];
    self.markView.layer.cornerRadius = 25;
    
    self.note = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    self.note.textColor = [UIColor whiteColor];
    self.note.textAlignment = NSTextAlignmentCenter;
    self.note.font = [UIFont boldSystemFontOfSize:10];
    
    [self.markView addSubview:self.note];
    [self.contentView addSubview:self.markView];
}

- (void) setContent:(Mark *)mark {
    self.note.text = [NSString stringWithFormat:@"%d", mark.note];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
