//	GTabBar.m
//	Custom UITabBar with Images
//  Created by Daniel Hollis on 27/09/2010
//  Copyright Daniel Hollis 2010. All rights reserved.
//	Author's Personal Email vibrazy@hotmail.com
//	Author's Work Email dhollis@guerrilla.co.uk
//	Company Guerrilla Digital Media
//	Company's website: http://www.guerrillawebsitedesign.co.uk
//
//  You may use this code within your own projects.  If
//  you provide credit somewhere in your project to myself and Guerrilla Digital Media 
//  You may not use it in any tutorials, books wikis etc without asking me first.

#import "GTabBar.h"
#import "GTabTabItem.h"
#import "AppDelegate.h"
#define kSelectedTab	@"SelectedTAB"
@implementation GTabBar
@synthesize tabViewControllers;
@synthesize tabItemsArray;
@synthesize tabBarHolder;
@synthesize initTab;
@synthesize delegate;

- (void)dealloc {
	[tabBarHolder release];
	[tabViewControllers release];
	[tabItemsArray release];
	[super dealloc];
}
//we are creating a view with the same bounds as the window, so it covers the whole area.
//also we are initializing the arrays that will hold the UIViewControllers and the TabBarItems
- (id)initWithTabViewControllers:(NSMutableArray *)tbControllers tabItems:(NSMutableArray *)tbItems initialTab:(int)iTab WithBackground:(UIImage*)imageBacground{
	if ((self = [super init])) {
		self.view.frame = [UIScreen mainScreen].bounds;
		initTab = iTab;
		tabViewControllers = [[NSMutableArray alloc] initWithArray:tbControllers];
		tabItemsArray = [[NSMutableArray alloc] initWithArray:tbItems];
        CGRect frame=self.view.frame;
        frame.origin.y=frame.size.height-imageBacground.size.height;
        UIImageView *imageview=[[UIImageView alloc] initWithImage:imageBacground];
        tabBarHolder = [[UIView alloc] initWithFrame:frame];
        tabBarHolder.backgroundColor = [UIColor clearColor];
        [tabBarHolder addSubview:imageview];
	}
    return self;
}
-(void)initialTab:(int)tabIndex {
	[self activateController:tabIndex];
	[self activateTabItem:tabIndex];
}
- (void)viewWillAppear:(BOOL)animated {
    if ([AppDelegate shareAppDelegate].isDismissModalView) {
        [AppDelegate shareAppDelegate].isDismissModalView=NO;
        return;
    }
}
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    
	//Create a view holder to store the tabbar items
	//add it as a subview
	[self.view addSubview:tabBarHolder];
	//loop thru all the view controllers and add their views to self
	for (int i = [tabViewControllers count]-1; i >= 0; i--) {
        NSLog(@"tabbar:%@",NSStringFromCGRect([[tabViewControllers objectAtIndex:i] view].frame));
		[self.view addSubview:[[tabViewControllers objectAtIndex:i] view]];
	}
	
	//loop thru all the tabbar items and add them to the tabBarHolder
	
	for (int i = [tabItemsArray count]-1; i >= 0; i--) {
		[[tabItemsArray objectAtIndex:i] setDelegate:self];
		[self.tabBarHolder addSubview:[tabItemsArray objectAtIndex:i]];
		//initTab is the index of the tabbar and viewcontroller that you decide to start the app with
		if (i == initTab) {
			[[tabItemsArray objectAtIndex:i] toggleOn:YES];
		}
	}
	[self.view bringSubviewToFront:tabBarHolder];
	//show/hide tabbars and controllers with a particular index
	[self initialTab:initTab];
}
//loop thru all tab bar items and set their toogle State to YES/NO
-(void)activateTabItem:(int)index {
	for (int i = 0; i < [tabItemsArray count]; i++) {
		if (i == index) {
			[[tabItemsArray objectAtIndex:i] toggleOn:YES];
		} else {
			[[tabItemsArray objectAtIndex:i] toggleOn:NO];
		}
	}
}
//loop thru all UIViewControllers items and set their toogle State to YES/NO
-(void)activateController:(int)index {
	for (int i = 0; i < [tabViewControllers count]; i++) {
		if (i == index) {
			[[tabViewControllers objectAtIndex:i] view].hidden = NO;
            [[tabViewControllers objectAtIndex:i] viewWillAppear:YES];
            [[tabViewControllers objectAtIndex:i] viewDidAppear:YES];
		} else {
			[[tabViewControllers objectAtIndex:i] view].hidden = YES;
            [[tabViewControllers objectAtIndex:i] viewWillDisappear:YES];
            [[tabViewControllers objectAtIndex:i] viewDidDisappear:YES];
		}
	}
}
//protocol used to communicate between the buttons and the tabbar
#pragma mark -
#pragma mark GTabTabItemDelegate action
- (void)selectedItem:(GTabTabItem *)button {
	int indexC = 0;
//	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSUInteger tabIndex=0;
	for (GTabTabItem *tb in tabItemsArray) {
		if (tb == button) {
			[tb toggleOn:YES];
			[self activateController:indexC];
//			tabIndex = indexC;
//			[defaults setInteger:tabIndex forKey:kSelectedTab];
		} else {
			[tb toggleOn:NO];
		}
		indexC++;
	}	 
}
@end
