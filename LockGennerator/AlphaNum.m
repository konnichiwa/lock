//
//  AlphaNum.m
//  LockGennerator
//
//  Created by luan on 3/6/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import "AlphaNum.h"
#import "AppDelegate.h"
@interface AlphaNum ()

@end

@implementation AlphaNum

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
    letters = @"abcdefghijklmnopqrstuvwxyz0123456789";
    resutlStr=@"";
    for (UIButton *btn in _btnNum) {
        btn.enabled=NO;
    }
    _pracBtn.enabled=NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-create randum
-(NSString *) genRandStringLength: (int) len {
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    return randomString;
}
-(int)getRandomNumber:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    resutlStr=@"";
    _textLabel.text=resutlStr;
}
#pragma mark-action
- (IBAction)btnPress:(id)sender {
    UIButton *btn=(UIButton*)sender;
    NSString *acciiTostr=[NSString stringWithFormat:@"%c",btn.tag];
    resutlStr=[resutlStr stringByAppendingFormat:@"%@",acciiTostr];
    NSLog(@"result text:%@ and r:%@",resutlStr,rcode);
    _textLabel.text=resutlStr;
    if (([resutlStr length]>=6)&&([resutlStr length]<=12)) {
        if ([rcode isEqualToString:resutlStr]) {
            [[[UIAlertView alloc] initWithTitle:@"IntelliLock" message:@"You got it right!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }
    
    if ([resutlStr length]>=12) {
        if (![rcode isEqualToString:resutlStr]) {
            [[[UIAlertView alloc] initWithTitle:@"IntelliLock" message:@"You got it wrong. Please try again or generate a different passcode." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }
}

- (IBAction)geneCode:(id)sender {
    
    
    rcode=[[self genRandStringLength:[self getRandomNumber:6 to:12]] retain];
    _textLabel.text=rcode;
    _pracBtn.enabled=YES;
    for (UIButton *btn in _btnNum) {
        btn.enabled=NO;
    }
}


- (IBAction)practisePress:(id)sender {
    _textLabel.text=@"";
    resutlStr=@"";
    
    for (UIButton *btn in _btnNum) {
        btn.enabled=YES;
    }
}

- (IBAction)clearPress:(id)sender {
    resutlStr=@"";
    _textLabel.text=@"";

}
- (void)dealloc {
    [_textLabel release];
    [_btnNum release];
    [_geneBtn release];
    [_pracBtn release];
    [_clearBtn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTextLabel:nil];
    [self setBtnNum:nil];
    [self setGeneBtn:nil];
    [self setPracBtn:nil];
    [self setClearBtn:nil];
    [super viewDidUnload];
}
@end
