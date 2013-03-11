//
//  AppDelegate.h
//  LockGennerator
//
//  Created by luan on 3/6/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTabBar.h"
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GTabBar *tabbarView;
@property (assign, nonatomic) BOOL *isIpad;
+ (AppDelegate *)shareAppDelegate;
- (BOOL)isTall;
@end
