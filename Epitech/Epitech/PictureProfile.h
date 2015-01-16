//
//  PictureProfile.h
//  Epitech
//
//  Created by Remi Robert on 16/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat defaultSizePictureDashboard = 120;

@interface PictureProfile : UIView

- (instancetype) initWithFrame:(CGRect)frame;
- (void) setImage:(UIImage *)image;

@end
