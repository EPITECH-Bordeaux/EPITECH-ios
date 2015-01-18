//
//  MarkCell.h
//  Epitech
//
//  Created by Remi Robert on 18/01/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mark.h"

# define REUSE_IDENTIFIER_MARK_CELL         @"mark_cell_identifier"

@interface MarkCell : UITableViewCell

- (void) initContentCell:(Mark *)mark;
- (void) setContent:(Mark *)mark;

@end
