//
//  PadLock.m
//  LockGennerator
//
//  Created by luan on 3/6/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import "PadLock.h"

@interface PadLock ()

@end

@implementation PadLock

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_mypicker1 selectRow:500 inComponent:0 animated:YES];
    [_mypicker2 selectRow:500 inComponent:0 animated:YES];
    [_mypicker3 selectRow:500 inComponent:0 animated:YES];
    [_mypicker4 selectRow:500 inComponent:0 animated:YES];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-picker delegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    [(UIView*)[[pickerView subviews] objectAtIndex:0] setAlpha:0.0f];
    [(UIView*)[[pickerView subviews] objectAtIndex:4] setAlpha:0.0f];
    [(UIView*)[[pickerView subviews] objectAtIndex:1] setAlpha:0.0f];
    [(UIView*)[[pickerView subviews] objectAtIndex:3] setAlpha:0.0f];
    UIImageView *imageView=[[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"padNum%d",row%10]]] autorelease];
    return imageView;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50.0;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSUInteger)row inComponent:(NSUInteger)component {

	[self pickerViewLoaded:pickerView.tag];
    [self checkResult];

}
- (NSUInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSUInteger)component {
	return 20000;
}

- (NSUInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
	return 1;
}

#pragma mark-other
-(void)checkResult
{
    NSString *num = @"";
    num=[num stringByAppendingFormat:@"%d",[_mypicker1 selectedRowInComponent:0]%10];
    num=[num stringByAppendingFormat:@"%d",[_mypicker2 selectedRowInComponent:0]%10];
    num=[num stringByAppendingFormat:@"%d",[_mypicker3 selectedRowInComponent:0]%10];
    num=[num stringByAppendingFormat:@"%d",[_mypicker4 selectedRowInComponent:0]%10];
    _labelText.text=num;
    
    if ([num isEqualToString:randomNum]) {
         [[[UIAlertView alloc] initWithTitle:@"IntelliLock" message:@"You got it right!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else{
          [[[UIAlertView alloc] initWithTitle:@"IntelliLock" message:@"You got it wrong. Please try again or generate a different passcode." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}
-(void)pickerViewLoaded: (int)blah {
    switch (blah) {
        case 1:
            	[_mypicker1 selectRow:[_mypicker1 selectedRowInComponent:0]%10+10000 inComponent:0 animated:false];
            break;
        case 2:
            [_mypicker2 selectRow:[_mypicker2 selectedRowInComponent:0]%10+10000 inComponent:0 animated:false];
            break;
        case 3:
            	[_mypicker3 selectRow:[_mypicker3 selectedRowInComponent:0]%10+10000 inComponent:0 animated:false];
            break;
        case 4:
            [_mypicker4 selectRow:[_mypicker4 selectedRowInComponent:0]%10+10000 inComponent:0 animated:false];
            break;
            
        default:
            break;
    }
}

-(void)autoscroll
{
    [self pickerViewLoaded:1];
    [self pickerViewLoaded:2];
    [self pickerViewLoaded:3];
    [self pickerViewLoaded:4];
    [_mypicker1 selectRow:[_mypicker1 selectedRowInComponent:0]+500+[self getRandomNumber:0 to:9] inComponent:0 animated:YES];
    [_mypicker2 selectRow:[_mypicker2 selectedRowInComponent:0]+500+[self getRandomNumber:0 to:9] inComponent:0 animated:YES];
    [_mypicker3 selectRow:[_mypicker3 selectedRowInComponent:0]+500+[self getRandomNumber:0 to:9] inComponent:0 animated:YES];
    [_mypicker4 selectRow:[_mypicker4 selectedRowInComponent:0]+500+[self getRandomNumber:0 to:9] inComponent:0 animated:YES];
    [self performSelector:@selector(setMyLabel)  // setMyLabel - my function
               withObject:nil
               afterDelay:0.4];

}
-(void)setMyLabel
{
    NSString *num = @"";
    num=[num stringByAppendingFormat:@"%d",[_mypicker1 selectedRowInComponent:0]%10];
    num=[num stringByAppendingFormat:@"%d",[_mypicker2 selectedRowInComponent:0]%10];
    num=[num stringByAppendingFormat:@"%d",[_mypicker3 selectedRowInComponent:0]%10];
    num=[num stringByAppendingFormat:@"%d",[_mypicker4 selectedRowInComponent:0]%10];
    randomNum=num;
    _labelText.text=num;
}
-(int)getRandomNumber:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}
- (void)dealloc {
    [_mypicker1 release];
    [_mypicker2 release];
    [_mypicker3 release];
    [_mypicker4 release];
    [_labelText release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMypicker1:nil];
    [self setMypicker2:nil];
    [self setMypicker3:nil];
    [self setMypicker4:nil];
    [self setLabelText:nil];
    [super viewDidUnload];
}
#pragma mark -action
- (IBAction)genePress:(id)sender {
    [self autoscroll];
    
}

@end
