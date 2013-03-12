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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_scrollView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setScrollView:nil];
    [super viewDidUnload];
}
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
@end
