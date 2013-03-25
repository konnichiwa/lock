//
//  SocialActivity.m
//  LinkDenity
//
//  Created by cncsoft on 2/2/13.
//  Copyright (c) 2013 cncsoft. All rights reserved.
//

#import "SocialActivity.h"
#import "AppDelegate.h"
#define FACEBOOK_APP_ID @"343988909045979"
#define FACEBOOK_APP_SECRET @"a661312f93dcc5c0b5a761ee03adacd0"
#define kOAuthConsumerKey @"YkmYEAHkTwDaNyLS95xjBg"		//REPLACE ME
#define kOAuthConsumerSecret @"6W7ZjU4FxMu0TAj4dH0dhxyMGJFZwSWsnuCRkoL0h7A"		//REPLACE ME

@implementation SocialActivity
@synthesize delegate;
@synthesize _facebook;
@synthesize viewcontroller;

-(int) fb_init{
    if(!_facebook){
        _facebook = [[Facebook alloc] initWithAppId:FACEBOOK_APP_ID andDelegate:(id)self];
    }
    NSLog(@"fb not login, try login now");
    [self fb_login];
    return 1;
    alert = [[AlertManager alloc] init:self];
    strTemp=@"";
    
    
    
}
-(id)init
{
    self.twitterEngine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self] ;
    self.twitterEngine.consumerKey =kOAuthConsumerKey;
    self.twitterEngine.consumerSecret = kOAuthConsumerSecret;
    [self.twitterEngine setClearsCookies:YES];
    [self.twitterEngine requestRequestToken];
    return self;
}
-(void)twitterInit
{
    self.twitterEngine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate:self] ;
    self.twitterEngine.consumerKey =kOAuthConsumerKey;
    self.twitterEngine.consumerSecret = kOAuthConsumerSecret;
    [self.twitterEngine setClearsCookies:YES];
    [self.twitterEngine requestRequestToken];
}
- (void)fb_login {
    _fb_permissions = [[NSArray alloc] initWithObjects:@"read_stream", @"publish_stream", @"offline_access",nil];
    [_facebook authorize:_fb_permissions];
}
- (void) signupFacebook{
    int result = [self fb_init];
    if(!result) {
        if ([delegate respondsToSelector:@selector(facebookSignInSuccess)]) {
            [delegate facebookSignInSuccess];
        }
    }
}
#pragma mark-get user info facebook
- (void)getUserInfo:(id)sender {
    [_facebook requestWithGraphPath:@"me/?fields=picture.type(large),email,first_name,last_name,id" andDelegate:(id)self];
    
    
}
#pragma mark - facebook delegate
- (void) fbDidLogin {
    
    NSLog(@"Login success");
    [[AppDelegate shareAppDelegate].alert1 showAlertLoading:@"Processing..Please wait!"];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [NSString stringWithFormat:@"%@ \n %@",strTemp,[NSDate date]], @"message"
                                   ,nil];
    
    [_facebook requestWithGraphPath:[NSString stringWithFormat:@"me/feed?access_token=%@",_facebook.accessToken] andParams:params andHttpMethod:@"POST" andDelegate:(id)self];
}
- (void)fbDidNotLogin:(BOOL)cancelled
{
    NSLog(@"Login error");
}
#pragma FbRequest Delegate
- (void) request:(FBRequest *)request didLoad:(id)result{
    NSLog(@"Request FaceBook Successful: %@",result);
    [[AppDelegate shareAppDelegate].alert1 dismissCurrentAlert];
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Sharing"
                              message:@"Facebook sharing is success!"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    
    [alertView show];
    [alertView release];
    
    
}
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    [[AppDelegate shareAppDelegate].alert1 dismissCurrentAlert];
    NSLog(@"Err message: %@", [[error userInfo] objectForKey:@"error_msg"]);
    NSLog(@"Err code: %d", [error code]);
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Sharing"
                              message:@"Facebook sharing is error!"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    
    [alertView show];
    [alertView release];
}
- (void)postToFacebookWithTitle:(NSString*)title{
    strTemp=title;
    
    if ([_facebook isSessionValid]) {
        [[AppDelegate shareAppDelegate].alert1 showAlertLoading:@"Processing..Please wait!"];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       [NSString stringWithFormat:@"%@ \n %@",title,[NSDate date]], @"message"
                                       ,nil];
        
        [_facebook requestWithGraphPath:[NSString stringWithFormat:@"me/feed?access_token=%@",_facebook.accessToken] andParams:params andHttpMethod:@"POST" andDelegate:(id)self];
        
    }
    else{
        [self signupFacebook];
    }
    
}
#pragma mark SA_OAuthTwitterEngineDelegate
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
    
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}


//=============================================================================================================================
- (void)shareTwitterText:(NSString*)text{
    
    
    
    Class TWTweetComposeViewControllerClass = NSClassFromString(@"TWTweetComposeViewController");
    
    if (TWTweetComposeViewControllerClass != nil) {
        if([TWTweetComposeViewControllerClass respondsToSelector:@selector(canSendTweet)]) {
            UIViewController *twitterViewController = [[TWTweetComposeViewControllerClass alloc] init];
            
            [twitterViewController performSelector:@selector(setInitialText:)
                                        withObject:text];
            [self.viewcontroller presentModalViewController:twitterViewController animated:YES];
            [twitterViewController release];
        }
        else {
        }
        
    }else{
        if (![self.twitterEngine isAuthorized]) {
            [alert dismissCurrentAlert];
            UIViewController *twitterAuth = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine:self.twitterEngine
                                                                                                            delegate:(id)self];
            [viewcontroller presentModalViewController:twitterAuth animated:YES];
        }
        else {
            strTemp=text;
            [[AppDelegate shareAppDelegate].alert1 showAlertLoading:@"Processing..Please wait!"];
            [self.twitterEngine sendUpdate:[NSString stringWithFormat:@"%@ %@",text,[NSDate date]]];
        }

    }
}
#pragma mark SA_OAuthTwitterControllerDelegate
- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
    [[AppDelegate shareAppDelegate].alert1 showAlertLoading:@"Processing..Please wait!"];
    [self.twitterEngine sendUpdate:[NSString stringWithFormat:@"%@ %@",strTemp,[NSDate date]]];
}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
	NSLog(@"Authentication Failed!");
}

- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
	NSLog(@"Authentication Canceled.");
}

//=============================================================================================================================
#pragma mark TwitterEngineDelegate
- (void) requestSucceeded: (NSString *) requestIdentifier {
    [[AppDelegate shareAppDelegate].alert1 dismissCurrentAlert];
    UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"Twitter" message:@"Share success!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert1 show];
    [alert1 release];
	NSLog(@"Request %@ succeeded", requestIdentifier);
}

- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error {
    [[AppDelegate shareAppDelegate].alert1 dismissCurrentAlert];
    UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"Twitter" message:@"Share Failed!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert1 show];
    [alert1 release];
	NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
    
}

#pragma mark-SMSViewcontroller
-(void)sendSMSWithNumber:(NSString*)number WithBody:(NSString*)body
{
    MFMessageComposeViewController*  SMSController = [[[MFMessageComposeViewController alloc] init] autorelease];
	if([MFMessageComposeViewController canSendText])
	{
		SMSController.body = body;
		SMSController.recipients = [NSArray arrayWithObjects: nil];
		SMSController.messageComposeDelegate = (id)self;
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [self.viewcontroller presentModalViewController:SMSController animated:YES];
    }
    
    
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    
	switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MessageComposeResultFailed:
			break;
		case MessageComposeResultSent:
            
			break;
		default:
			break;
	}
    
    [self.viewcontroller dismissModalViewControllerAnimated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
#pragma mark-mailViewcontroller
-(void)displayComposerSheetwithtext:(NSString*)text
{
    MFMailComposeViewController  *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = (id)self;
    [picker setSubject:@"IntelliLock"];
    // Fill out the email body text
    NSString *emailBody = text;
    [picker setMessageBody:emailBody isHTML:NO];
    
    [self.viewcontroller presentModalViewController:picker animated:YES];
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: canceled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Result: saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Result: sent");
            [[[UIAlertView alloc] initWithTitle:@"IntelliLock" message:@"success!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Result: failed");
            [[[UIAlertView alloc] initWithTitle:@"IntelliLock" message:@"Failed!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            break;
        default:
            NSLog(@"Result: not sent");
            break;
    }
    [self.viewcontroller dismissModalViewControllerAnimated:YES];
}
@end
