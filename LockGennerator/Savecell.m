//
//  Savecell.m
//  LockGennerator
//
//  Created by cncsoft on 3/12/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import "Savecell.h"

@implementation Savecell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_picture release];
    [_nametext release];
    [_dateText release];
    [_timeText release];
    [_sizeText release];
    [super dealloc];
}
@end
