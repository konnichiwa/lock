//
//  AppDelegate.h
//  LockGennerator
//
//  Created by luan on 3/6/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTabBar.h"
#import "Setting.h"
#import <MessageUI/MFMailComposeViewController.h>
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GTabBar *tabbarView;
@property (strong, nonatomic) MFMailComposeViewController *picker;
@property (strong, nonatomic) UIImage *screenShot1;
@property (strong, nonatomic) UIImage *screenShot2;
@property (strong, nonatomic) UIImage *screenShot3;
@property (strong, nonatomic) UIImage *screenShot4;

@property (assign, nonatomic) BOOL isIpad;
@property (assign, nonatomic) NSInteger index;
+ (AppDelegate *)shareAppDelegate;
- (BOOL)isTall;
-(void)addSetting;
-(void)addActionSheet;
-(void)takeScreenShotWithView:(UIView*)view;
@end
