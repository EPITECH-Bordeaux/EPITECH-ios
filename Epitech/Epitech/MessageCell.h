//
//  MessageCell.h
//  Epitech
//
//  Created by Remi Robert on 16/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationMessage.h"

# define REUSE_IDENTIFIER_MESSAGE_CELL         @"message_cell_identifier"

@interface MessageCell : UITableViewCell

- (void) initContentCell:(NotificationMessage *)message;
- (void) setContent:(NotificationMessage *)message;
+ (CGFloat) calcHeightContentCell:(NotificationMessage *)message;

@end
