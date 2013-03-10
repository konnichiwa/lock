//
//  Pattern.h
//  LockGennerator
//
//  Created by luan on 3/6/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawPatternLockView.h"
@interface Pattern : UIViewController
{
      NSMutableArray* _paths;
    id _target;
    SEL _action;
    NSInteger matrixNum;
    BOOL isDisable;
    NSMutableArray *imageDotTemp;
    DrawPatternLockView *v;
    BOOL isPad9;
    NSString *result;
    NSString *randomPatern;
}
@property (retain, nonatomic) IBOutlet DrawPatternLockView *pad9;
@property (retain, nonatomic) IBOutlet DrawPatternLockView *pad16;
@property (retain, nonatomic) IBOutletCollection(UIImageView) NSArray *imageDot;
@property (retain, nonatomic) IBOutletCollection(UIImageView) NSArray *imageDot9;

@property (retain, nonatomic) IBOutlet UIButton *practiseBtn;
@property (retain, nonatomic) IBOutlet UIButton *clearBtn;

- (IBAction)chooseStyle:(id)sender;
- (IBAction)genePress:(id)sender;
- (IBAction)practisePress:(id)sender;
- (IBAction)clearPress:(id)sender;

@end
