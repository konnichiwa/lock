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
}
@property (retain, nonatomic) IBOutlet DrawPatternLockView *pad9;
@property (retain, nonatomic) IBOutletCollection(UIImageView) NSArray *imageDot;
@end
