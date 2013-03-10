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

@implementation AppDelegate
@synthesize tabbarView;
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

    } else {

    }
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
#pragma setup tabbar
-(void)setupTabbarDidLogin
{
    GTabTabItem *tabItem1 = [[GTabTabItem alloc] initWithFrame:CGRectMake(0, 0, 80, 46) normalState:@"" toggledState:@"btn_4_digit_h"];
	GTabTabItem *tabItem2 = [[GTabTabItem alloc] initWithFrame:CGRectMake(80-1, 0, 80, 46) normalState:@"" toggledState:@"btn_4_paternt_h"];
	GTabTabItem *tabItem3 = [[GTabTabItem alloc] initWithFrame:CGRectMake(80+80-1, 0, 80, 46) normalState:@"" toggledState:@"btn_4_alphanum_h"];
	GTabTabItem *tabItem4 = [[GTabTabItem alloc] initWithFrame:CGRectMake(80+80+80-1, 0, 80+1, 46) normalState:@"" toggledState:@"btn_4_padlock_h"];
    
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
@end
