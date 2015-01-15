//
//  UITextFieldForm.m
//  Epitech
//
//  Created by Remi Robert on 15/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "UITextFieldForm.h"

@implementation UITextFieldForm

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.font = [UIFont systemFontOfSize:kJVFieldFontSize];
        self.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
        self.floatingLabelTextColor = [UIColor grayColor];
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return (self);
}

@end
