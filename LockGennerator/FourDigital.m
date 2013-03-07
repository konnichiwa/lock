//
//  FourDigital.m
//  LockGennerator
//
//  Created by luan on 3/6/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import "FourDigital.h"
#import "AppDelegate.h"
@interface FourDigital ()

@end

@implementation FourDigital

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([[AppDelegate shareAppDelegate] isTall]) {
            self = [super initWithNibName:[NSString stringWithFormat:@"%@_iphone5",nibNameOrNil] bundle:nibBundleOrNil];
        }else{
       self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        }
    } else {
        
    }
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    [self showRandum];
    r=99999;
    resutlStr=@"";
    enableInput=NO;
    [self disableWhenHasNotCode];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)numPress:(id)sender {
    UIButton *btn=(UIButton*)sender;
    if ([resutlStr length]<4) {
        resutlStr=[resutlStr stringByAppendingFormat:@"%d",btn.tag];
        _numText.text=resutlStr;
    }
    if ([resutlStr length]==4) {
        _numText.text=resutlStr;
        
        if (r==[resutlStr intValue]) {
            [[[UIAlertView alloc] initWithTitle:@"IntelliLock" message:@"You got it right!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"IntelliLock" message:@"You got it wrong. Please try again or generate a different passcode." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    resutlStr=@"";
    _numText.text=resutlStr;
}
- (IBAction)generatePress:(id)sender {
    [self showRandum];
}
- (void)dealloc {
    [_practisePress release];
    [_numText release];
    [_numBtn release];
    [_praBtn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setPractisePress:nil];
    [self setNumText:nil];
    [self setNumBtn:nil];
    [self setPraBtn:nil];
    [super viewDidUnload];
}
- (IBAction)practisePress:(id)sender {
    enableInput=YES;
    resutlStr=@"";
    _numText.text=@"";
    for (UIButton *btn in _numBtn) {
        btn.enabled=YES;
    }
}

- (IBAction)clearPress:(id)sender {
    resutlStr=@"";
    _numText.text=@"";
}

-(void)showRandum
{
    
    r = arc4random() % 10000;
    _numText.text=[NSString stringWithFormat:@"%4.4d",r];
    _practisePress.enabled=YES;
}
-(void)disableWhenHasNotCode
{
    for (UIButton *btn in _numBtn) {
        btn.enabled=NO;
    }
    _praBtn.enabled=NO;
}
@end
