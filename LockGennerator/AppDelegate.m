//
//  AppDelegate.m
//  LockGennerator
//
//  Created by luan on 3/6/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import "AppDelegate.h"
#import "FourDigital.h"
#import "PadLock.h"
#import "Pattern.h"
#import "AlphaNum.h"
#include <QuartzCore/QuartzCore.h>

@implementation AppDelegate
@synthesize tabbarView;
@synthesize isIpad;
@synthesize screenShot1;
@synthesize screenShot2;
@synthesize screenShot3;
@synthesize screenShot4;
@synthesize index;
@synthesize picker;
@synthesize socialActivity;
@synthesize alert1;
@synthesize listImage,numImage;
@synthesize currentImage;
- (void)dealloc
{
    [_window release];
    [super dealloc];
}
//check iphone 4 oriphone5
- (BOOL)isTall
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat height = bounds.size.height;
    CGFloat scale = [[UIScreen mainScreen] scale];
    return ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && ((height * scale) >= 1000));
}

+ (AppDelegate *)shareAppDelegate
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [application setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        isIpad=NO;
        
    } else {
        isIpad=YES;
    }
    socialActivity=[[SocialActivity alloc] init];
    alert1 = [[AlertManager alloc] init:self];
    
    self.listImage=[self findFiles:@"png"];
    numImage=[listImage count];
    [self setupTabbarDidLogin];
    CGRect frame=tabbarView.view.frame;
    frame.origin.y=-20;
    tabbarView.view.frame=frame;
    self.window.rootViewController=tabbarView;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [socialActivity._facebook handleOpenURL:url];
}
#pragma mark - image history
-(NSMutableArray *)findFiles:(NSString *)extension{
    
    NSMutableArray *matches = [[NSMutableArray alloc]init];
    NSFileManager *fManager = [NSFileManager defaultManager];
    NSString *item;
    NSArray *contents = [fManager contentsOfDirectoryAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] error:nil];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // >>> this section here adds all files with the chosen extension to an array
    for (item in contents){
        if ([[item pathExtension] isEqualToString:extension]) {
            [matches addObject:[documentsDirectory stringByAppendingPathComponent:
                                item]];
        }
    }
    return matches;
}
#pragma mark-setup tabbar
-(void)setupTabbarDidLogin
{
    GTabTabItem *tabItem1;
	GTabTabItem *tabItem2;
	GTabTabItem *tabItem3;
	GTabTabItem *tabItem4;
    if (!isIpad) {
        tabItem1 = [[GTabTabItem alloc] initWithFrame:CGRectMake(0, 0, 80, 46) normalState:@"" toggledState:@"btn_4_digit_h"];
        tabItem2 = [[GTabTabItem alloc] initWithFrame:CGRectMake(80-1, 0, 80, 46) normalState:@"" toggledState:@"btn_4_paternt_h"];
        tabItem3 = [[GTabTabItem alloc] initWithFrame:CGRectMake(80+80-1, 0, 80, 46) normalState:@"" toggledState:@"btn_4_alphanum_h"];
        tabItem4 = [[GTabTabItem alloc] initWithFrame:CGRectMake(80+80+80-1, 0, 80+1, 46) normalState:@"" toggledState:@"btn_4_padlock_h"];
    }
    else{
        tabItem1 = [[GTabTabItem alloc] initWithFrame:CGRectMake(0, 0, 191, 100) normalState:@"" toggledState:@"btn_4_digit_h~ipad"];
        tabItem2 = [[GTabTabItem alloc] initWithFrame:CGRectMake(191, 0, 191+2, 100) normalState:@"" toggledState:@"btn_4_paternt_h~ipad"];
        tabItem3 = [[GTabTabItem alloc] initWithFrame:CGRectMake(191+191, 0, 191+5, 100) normalState:@"" toggledState:@"btn_4_alphanum_h~ipad"];
        tabItem4 = [[GTabTabItem alloc] initWithFrame:CGRectMake(191+191+191, 0, 191+5, 100) normalState:@"" toggledState:@"btn_4_padlock_h~ipad"];
    }
    FourDigital *fourDigital = [[[FourDigital alloc] initWithNibName:@"FourDigital" bundle:nil] autorelease];
    Pattern *pattern= [[[Pattern alloc] initWithNibName:@"Pattern" bundle:nil] autorelease];
    AlphaNum *alphaNum = [[[AlphaNum alloc] initWithNibName:@"AlphaNum" bundle:nil] autorelease];
    PadLock *padLock= [[[PadLock alloc] initWithNibName:@"PadLock" bundle:nil] autorelease];
    
    NSMutableArray *viewControllersArray = [[NSMutableArray alloc] init];
	[viewControllersArray addObject:fourDigital];
	[viewControllersArray addObject:pattern];
	[viewControllersArray addObject:alphaNum];
	[viewControllersArray addObject:padLock];
    NSMutableArray *tabItemsArray = [[NSMutableArray alloc] init];
	[tabItemsArray addObject:tabItem1];
	[tabItemsArray addObject:tabItem2];
	[tabItemsArray addObject:tabItem3];
	[tabItemsArray addObject:tabItem4];
    
    [tabItem1 release];
    [tabItem2 release];
    [tabItem3 release];
    [tabItem4 release];
    UIImage *image=[UIImage imageNamed:@"bg_tabbar"];
	tabbarView = [[GTabBar alloc] initWithTabViewControllers:viewControllersArray tabItems:tabItemsArray initialTab:0 WithBackground:image];
    [viewControllersArray release];
    [tabItemsArray release];
    
    
}
#pragma mark -add view
-(void)addSetting
{
    Setting *setting=[[[Setting alloc] initWithNibName:@"Setting" bundle:nil] autorelease];
    UINavigationController *ncSetting=[[UINavigationController alloc] initWithRootViewController:setting];
    ncSetting.navigationBarHidden=YES;
    [self.window addSubview:ncSetting.view];
    CGRect frame=ncSetting.topViewController.view.frame;
    frame.origin.x=frame.size.width;
    frame.origin.y=0;
    ncSetting.topViewController.view.frame=frame;
    frame.origin.x=0;
    [UIView animateWithDuration:0.5
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         ncSetting.topViewController.view.frame=frame;
                         NSLog(@"frame:%@",NSStringFromCGRect(ncSetting.topViewController.view.frame));
                     }
                     completion:^(BOOL finished){
                     }];
}
-(void)addActionSheet{
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"" delegate:(id)self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Save to album" otherButtonTitles:@"SMS",@"Email", nil];
    [actionSheet showInView:self.tabbarView.view];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSLog(@"action button index:%d",buttonIndex);
    UIImage *image=[[UIImage alloc] init];
    switch (index) {
        case 1:
            image=self.screenShot1;
            break;
        case 2:
            image= self.screenShot2;
            break;
        case 3:
            image= self.screenShot3;
            break;
        case 4:
            image= self.screenShot4 ;
            break;
        default:
            break;
    }
    currentImage=image;
switch (buttonIndex) {
    case 0:
        [self saveImage:image];
        break;
    case 2:
        [self displayComposerSheetwithImage:image];
                break;
    case 1:
    { UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Send Image" message:@"Choosing Ok will open your Messages App. After selecting your contact, tap the text box once and select paste." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
        alerView.tag = ALERT_TAG_SEND_IMAGE;
        [alerView show];
        [alerView release];
    }
        break;
    default:
        break;
        

}
}
#pragma mark - UIAlerviewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag==ALERT_TAG_SEND_IMAGE) {
        if (buttonIndex==0) {
            [self sendSMSWithImage:currentImage];
        }
    }
}
-(void)takeScreenShotWithView:(UIView*)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
	[self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    switch (index) {
        case 1:
            self.screenShot1 = UIGraphicsGetImageFromCurrentImageContext();
            break;
        case 2:
            self.screenShot2 = UIGraphicsGetImageFromCurrentImageContext();
            break;
        case 3:
            self.screenShot3 = UIGraphicsGetImageFromCurrentImageContext();
            break;
        case 4:
            self.screenShot4 = UIGraphicsGetImageFromCurrentImageContext();
            break;
        default:
            break;
    }
	UIGraphicsEndImageContext();
}

#pragma mark-mailViewcontroller
-(void)displayComposerSheetwithImage:(UIImage*)image
{
    picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = (id)self;
    [picker setSubject:@"IntelliLock"];
    
    // Attach an image to the email
    NSData *myData = UIImagePNGRepresentation(image);
    [picker addAttachmentData:myData mimeType:@"image/png" fileName:@"coolImage.png"];
    
    // Fill out the email body text
    NSString *emailBody = @"IntelliLock";
    [picker setMessageBody:emailBody isHTML:NO];
    
    [self.tabbarView.view addSubview:picker.view];
    CGRect frame=picker.view.frame;
    frame.origin.y=self.tabbarView.view.frame.size.height;
    picker.view.frame=frame;
    frame.origin.y=0;
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         picker.view.frame=frame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
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
    CGRect frame=picker.view.frame;
    frame.origin.y=self.tabbarView.view.frame.size.height;
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         picker.view.frame=frame;
                     }
                     completion:^(BOOL finished){
                         [picker.view removeFromSuperview];
                         
                     }];
}
- (void)saveImage: (UIImage*)image
{
    if (image != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          [NSString stringWithFormat:@"Picture_%d.png",numImage]];
        numImage++;
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
    }
}
- (void)sendSMSWithImage:(UIImage*)image {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.persistent = YES;
    pasteboard.image = image;
    
    
    NSString *phoneToCall = @"sms:";
    NSString *phoneToCallEncoded = [phoneToCall stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSURL *url = [[NSURL alloc] initWithString:phoneToCallEncoded];
    [[UIApplication sharedApplication] openURL:url];
}
@end
