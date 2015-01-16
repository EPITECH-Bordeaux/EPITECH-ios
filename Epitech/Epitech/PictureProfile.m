//
//  PictureProfile.m
//  Epitech
//
//  Created by Remi Robert on 16/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "PictureProfile.h"

@interface PictureProfile()
@property (nonatomic, strong) UIImageView *pictureView;
@end

@implementation PictureProfile

- (void) setImage:(UIImage *)image {
    self.pictureView.image = image;
}

- (void) initPictureView:(CGRect)frame {
    self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width - 10,
                                                                     frame.size.height - 10)];
    self.pictureView.clipsToBounds = true;
    self.pictureView.layer.cornerRadius = (frame.size.width - 10) / 2;
    self.pictureView.contentMode = UIViewContentModeScaleAspectFill;
    self.pictureView.backgroundColor = [UIColor redColor];
    [self addSubview:self.pictureView];
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.layer.cornerRadius = frame.size.width / 2;
        self.backgroundColor = [UIColor whiteColor];
        [self initPictureView:frame];
        
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.4;
    }
    return (self);
}

@end
