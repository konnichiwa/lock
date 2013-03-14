//
//  Savecell.h
//  LockGennerator
//
//  Created by cncsoft on 3/12/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Savecell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *picture;
@property (retain, nonatomic) IBOutlet UILabel *nametext;
@property (retain, nonatomic) IBOutlet UILabel *dateText;
@property (retain, nonatomic) IBOutlet UILabel *timeText;
@property (retain, nonatomic) IBOutlet UILabel *sizeText;
@end
