//
//  Setting.m
//  LockGennerator
//
//  Created by luan on 3/11/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import "Setting.h"
#import "AppDelegate.h"
#import "Save.h"
#define APP_ID_ITUNE @"569494971" //it will be replaced when self app invalid appstore
@interface Setting ()

@end

@implementation Setting

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[AppDelegate shareAppDelegate] isTall]) {
            self = [super initWithNibName:[NSString stringWithFormat:@"%@_iphone5",nibNameOrNil] bundle:nibBundleOrNil];
        }else{
            self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        }
    } else {
              self = [super initWithNibName:[NSString stringWithFormat:@"%@_ipad",nibNameOrNil] bundle:nibBundleOrNil];  
    }
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _scrollView.contentSize=CGSizeMake(320, 568);

    self.wantsFullScreenLayout = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
      [[AppDelegate shareAppDelegate].socialActivity twitterInit]; 
}
- (void)dealloc {
    [_scrollView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setScrollView:nil];
    [super viewDidUnload];
}
-(void)rateWithAppId:(NSString*)appId
{
    NSString* url = [NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", appId];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
}

#pragma mark-action
- (IBAction)savePress:(id)sender {
    Save *save=[[[Save alloc] initWithNibName:@"Save" bundle:nil] autorelease];
    [self.navigationController pushViewController:save animated:YES];
}

- (IBAction)backPress:(id)sender {
    CGRect frame=self.view.frame;
    frame.origin.x=self.view.frame.size.width;
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         self.view.frame=frame;
                     }
                     completion:^(BOOL finished){
                         [self.navigationController.view removeFromSuperview];
                     }];
}

- (IBAction)shareFBPress:(id)sender {
    
    [[AppDelegate shareAppDelegate].socialActivity  postToFacebookWithTitle:@"lock gennerator test"];
}

- (IBAction)shareTwitterPress:(id)sender {
    [AppDelegate shareAppDelegate].socialActivity.viewcontroller=self;
        [[AppDelegate shareAppDelegate].socialActivity  shareTwitterText:@"lock gennerator test"];
}

- (IBAction)shareSMSPress:(id)sender {
    [AppDelegate shareAppDelegate].socialActivity.viewcontroller=self;
    [[AppDelegate shareAppDelegate].socialActivity  sendSMSWithNumber:@"" WithBody:@"lock gennerator test"];
}

- (IBAction)shareEmailPress:(id)sender {
    [AppDelegate shareAppDelegate].socialActivity.viewcontroller=self;
    [[AppDelegate shareAppDelegate].socialActivity displayComposerSheetwithtext:@"lock gennerator test"];
}

- (IBAction)ratePress:(id)sender {
    [self rateWithAppId:APP_ID_ITUNE];
}

- (IBAction)giftAppPress:(id)sender {
    NSString *GiftAppURL = [NSString stringWithFormat:@"itms-appss://buy.itunes.apple.com/WebObjects/MZFinance.woa/wa/giftSongsWizard?gift=1&salableAdamId=%@&productType=C&pricingParameter=STDQ&mt=8&ign-mscache=1",APP_ID_ITUNE];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:GiftAppURL]];
}
@end
