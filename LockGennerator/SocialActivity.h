//
//  SocialActivity.h
//  LinkDenity
//
//  Created by cncsoft on 2/2/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Facebook.h"
#import "FBConnect.h"
//#import "FbGraph.h"
#import "FBDialog.h"
#import "AlertManager.h"
#import "SA_OAuthTwitterEngine.h"
#import "SA_OAuthTwitterController.h"
#import <MessageUI/MessageUI.h>
@protocol SocialDelegate <NSObject>

@optional
-(void) facebookSignInSuccess;
-(void) getInforSuccess:(NSDictionary*)infoAcc;
-(void) linkedInGetInforSuccess:(NSDictionary*)infoAcc;
@end

@interface SocialActivity : NSObject< FBRequestDelegate, FBDialogDelegate,FBSessionDelegate>
{
    Facebook *_facebook;
    NSArray* _fb_permissions;
    NSInteger fbIndex;
        AlertManager *alert;
    NSString *strTemp;
}
@property (nonatomic, assign) id <SocialDelegate> delegate;
@property (nonatomic, retain)  Facebook *_facebook;
@property (nonatomic, retain)  UIViewController *viewcontroller;
@property (nonatomic, strong) SA_OAuthTwitterEngine* twitterEngine;
-(void)twitterInit;
- (void)postToFacebookWithTitle:(NSString*)title;
-(int) fb_init;
-(void)fb_login;
-(void)signupFacebook;
- (void)loginLinkedInWithViewController:(UIViewController*)viewController;
- (void)shareTwitterText:(NSString*)text;
-(void)sendSMSWithNumber:(NSString*)number WithBody:(NSString*)body;
-(void)displayComposerSheetwithtext:(NSString*)text;
@end
