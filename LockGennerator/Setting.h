//
//  Setting.h
//  LockGennerator
//
//  Created by luan on 3/11/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Setting : UIViewController

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)savePress:(id)sender;
- (IBAction)backPress:(id)sender;
- (IBAction)shareFBPress:(id)sender;
- (IBAction)shareTwitterPress:(id)sender;
- (IBAction)shareSMSPress:(id)sender;
- (IBAction)shareEmailPress:(id)sender;
- (IBAction)ratePress:(id)sender;
- (IBAction)giftAppPress:(id)sender;
@end
