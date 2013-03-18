//
//  Save.h
//  LockGennerator
//
//  Created by cncsoft on 3/12/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface Save : UIViewController

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) IBOutlet UIView *popupView;
- (IBAction)backPress:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@end
