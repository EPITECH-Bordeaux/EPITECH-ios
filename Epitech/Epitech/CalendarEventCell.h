//
//  CalendarEventCell.h
//  Epitech
//
//  Created by Remi Robert on 16/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarEvent.h"

# define REUSE_IDENTIFIER_CALENDAR_CELL         @"calendar_cell_identifier"

@interface CalendarEventCell : UITableViewCell

- (void) initContentCell:(CalendarEvent *)event;
- (void) setContent:(CalendarEvent *)event;
+ (CGFloat) calcHeightContentCell:(CalendarEvent *)message;

@end
