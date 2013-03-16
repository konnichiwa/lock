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
#import "SocialActivity.h"
#import "AlertManager.h"
#import <MessageUI/MessageUI.h>
#define ALERT_TAG_SEND_IMAGE 1234
@class ViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    MFMessageComposeViewController *SMSController;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GTabBar *tabbarView;
@property (strong, nonatomic) MFMailComposeViewController *picker;
@property (strong, nonatomic) UIImage *screenShot1;
@property (strong, nonatomic) UIImage *screenShot2;
@property (strong, nonatomic) UIImage *screenShot3;
@property (strong, nonatomic) UIImage *screenShot4;
@property (strong, nonatomic) UIImage *currentImage;
@property (nonatomic, retain) SocialActivity *socialActivity;
@property (retain, nonatomic) AlertManager *alert1;
@property (assign, nonatomic) BOOL isIpad;
@property (assign, nonatomic) NSInteger numImage;
@property (strong, nonatomic) NSMutableArray *listImage;
@property (assign, nonatomic) NSInteger index;
@property(assign,nonatomic) BOOL isDismissModalView;
+ (AppDelegate *)shareAppDelegate;
- (BOOL)isTall;
-(void)addSetting;
-(void)addActionSheet;
-(void)takeScreenShotWithView:(UIView*)view;
-(NSMutableArray *)findFiles:(NSString *)extension;
-(void)sendSMSWithNumber:(NSString*)number WithBody:(NSString*)body;
@end
