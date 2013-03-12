//
//  Pattern.m
//  LockGennerator
//
//  Created by luan on 3/6/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import "Pattern.h"
#import "NSArray+sortBy.h"
#import "AppDelegate.h"
@interface Pattern ()

@end

@implementation Pattern

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
    randomPatern=@"";
    result=@"";
    self.imageDot = [self.imageDot sortByObjectTag];
    self.imageDot9 = [self.imageDot9 sortByObjectTag];
    imageDotTemp=[[[NSMutableArray alloc] initWithArray:_imageDot] retain];
    matrixNum=4;
    self.pad9.hidden=YES;
    isPad9=NO;
    v=_pad16;
    isDisable=YES;
    _practiseBtn.enabled=NO;
    _clearBtn.enabled=NO;
    _saveBtn.enabled=NO;
    for (UIImageView *image in imageDotTemp) {
        [image setImage:[UIImage imageNamed:@"pad_off"]];
        [image setHighlightedImage:[UIImage imageNamed:@"pad_on"]];
    }
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [AppDelegate shareAppDelegate].index=2;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadView {
    [super loadView];
    
    //    self.view = [[DrawPatternLockView alloc] init];
}
- (void)dealloc {
    [_imageDot release];
    [_pad9 release];
    [_pad16 release];
    [_imageDot9 release];
    [_practiseBtn release];
    [_clearBtn release];
    [_saveBtn release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setImageDot:nil];
    [self setPad9:nil];
    [self setPad16:nil];
    [self setImageDot9:nil];
    [self setPractiseBtn:nil];
    [self setClearBtn:nil];
    [self setSaveBtn:nil];
    [super viewDidUnload];
}
#pragma mark- touch even
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isDisable) {
        return;
    }
    _paths = [[NSMutableArray alloc] init];
}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (isDisable) {
        return;
    }
    CGPoint pt = [[touches anyObject] locationInView:v];
    UIView *touched = [[v hitTest:pt withEvent:event] retain];
    [v drawLineFromLastDotTo:pt];
    
    if (touched.tag!=0) {
        if (touched.tag==5) {
            NSLog(@"touched 5: %d", touched.tag);
        }
        NSLog(@"touched view tag: %d", touched.tag);
        NSLog(@"pt point: %@", NSStringFromCGPoint(pt));
        BOOL found = NO;
        for (NSNumber *tag in _paths) {
            found = tag.integerValue==touched.tag;
            if (found)
                break;
        }
        if (found)
            return;
        NSInteger   preTag=[[_paths lastObject] integerValue];
        
        if (preTag!=0) {
            NSLog(@"tag preview:%d",preTag);
            int xp=(preTag-1)/matrixNum;
            int yp=(preTag-1)%matrixNum;
            int xn=(touched.tag-1)/matrixNum;
            int yn=(touched.tag-1)%matrixNum;
            NSLog(@"cooNow:(%d,%d) after:(%d,%d)",xn,yn,xp,yp);
            if (((xn==xp)&&((yn==yp+1)||(yn==yp-1)))||((yn==yp)&&((xn==xp+1)||(xn==xp-1)))||((xn==xp-1)&&(yn==yp-1))||((xn==xp+1)&&(yn==yp+1))||((xn==xp+1)&&(yn==yp-1))||((xn==xp-1)&&(yn==yp+1))) {
                CGPoint from;
                UIImageView *lastDot;
                for (UIImageView *imageView in imageDotTemp) {
                    if (imageView.tag==preTag) {
                        lastDot=imageView;
                        from=imageView.center;
                    }
                }
        
                CGPoint to=touched.center;
                
            double sincorner=(to.y -from.y)/(sqrt((to.x-from.x)*(to.x-from.x)+(to.y-from.y)*(to.y-from.y)));
            double corner;
                if (to.x<=from.x) {
                    corner=3.14- asin(sincorner);
                }
                else{
                    corner=asin(sincorner);
                }
                        [lastDot setHighlightedImage:[UIImage imageNamed:@"pad_indicator"]];
            lastDot.transform = CGAffineTransformMakeRotation(corner);
    }
            else return;
}
[_paths addObject:[NSNumber numberWithInt:touched.tag]];
[v addDotView:touched];

UIImageView* iv = (UIImageView*)touched;
iv.highlighted = YES;
}

}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // clear up hilite
    if (isDisable) {
        return;
    }
    [self clearScreen];
      // pass the output to target action...
    if ([_paths count]!=0){
        result=@"";
       result=[[self getKey] retain];
        NSLog(@"result string:%@",result);
        if ([result isEqualToString:randomPatern]) {
            [[[UIAlertView alloc] initWithTitle:@"IntelliLock" message:@"You got it right!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"IntelliLock" message:@"You got it wrong. Please try again or generate a different passcode." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }
}


// get key from the pattern drawn
// replace this method with your own key-generation algorithm
- (NSString*)getKey {
    NSMutableString *key;
    key = [NSMutableString string];
    // simple way to generate a key
    for (NSNumber *tag in _paths) {
        [key appendFormat:@"%d", tag.integerValue];
    }
    return key;
}


- (void)setTarget:(id)target withAction:(SEL)action {
    _target = target;
    _action = action;
}

-(void)clearScreen
{
    [v clearDotViews];
    for (UIImageView *imageview in imageDotTemp) {
        [imageview setHighlightedImage:[UIImage imageNamed:@"pad_on"]];
        [imageview setHighlighted:NO];
         imageview.transform = CGAffineTransformMakeRotation(0);
    }
    [v setNeedsDisplay];
}
-(void)writeaPattern:(NSArray*)arrdot{
    [self clearScreen];
    for (int i=0; i<[arrdot count]; i++) {
        NSString *strTag=[arrdot objectAtIndex:i];
        [v addDotView:[imageDotTemp objectAtIndex:[strTag integerValue]-1]];
        UIImageView *dotFrom=[imageDotTemp objectAtIndex:[strTag integerValue]-1];
        if (i<[arrdot count]-1) {
            NSString *strTag1=[arrdot objectAtIndex:i+1];
            UIImageView *dotTo=[imageDotTemp objectAtIndex:[strTag1 integerValue]-1];
            CGPoint from=dotFrom.center;
            CGPoint to=dotTo.center;
            double sincorner=(to.y -from.y)/(sqrt((to.x-from.x)*(to.x-from.x)+(to.y-from.y)*(to.y-from.y)));
            double corner;
            
            if (to.x<=from.x) {
                corner=3.14- asin(sincorner);
            }
            else{
                corner=asin(sincorner);
            }
            [dotFrom setHighlightedImage:[UIImage imageNamed:@"pad_indicator"]];
            dotFrom.transform = CGAffineTransformMakeRotation(corner);
            dotFrom.highlighted=YES;

        }
        else
        {
        dotFrom.highlighted=YES;
        }
    
    }
[v setNeedsDisplay];
    isDisable=YES;
}

-(int)getRandomNumber:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}
-(BOOL)checkVailidRandomNum:(NSArray*)arrdot
{
    for (int i=0; i<[arrdot count]-1; i++) {
        int firstNum=[[arrdot objectAtIndex:i] integerValue];
        int secondNum=[[arrdot objectAtIndex:i+1] integerValue];
        if (firstNum==secondNum) {
            return NO;
        }
        int xp=(firstNum-1)/matrixNum;
        int yp=(firstNum-1)%matrixNum;
        int xn=(secondNum-1)/matrixNum;
        int yn=(secondNum-1)%matrixNum;
        if (((xn==xp)&&((yn==yp+1)||(yn==yp-1)))||((yn==yp)&&((xn==xp+1)||(xn==xp-1)))||((xn==xp-1)&&(yn==yp-1))||((xn==xp+1)&&(yn==yp+1))||((xn==xp+1)&&(yn==yp-1))||((xn==xp-1)&&(yn==yp+1))) {
            
        }
        else{
            return NO;
        }
    }
    return YES;
}
-(NSMutableArray*)createRandom
{
tt:;
    
    int length;
    if (isPad9) {
        length=[self getRandomNumber:5 to:7];
    }
    else{
       length=[self getRandomNumber:5 to:9];
    }

tt1:;
    NSMutableArray *arrdot=[[NSMutableArray alloc] initWithCapacity:length];
    for (int i=0; i<length; i++) {
        int numtoadd=[self getRandomNumber:1 to:matrixNum*matrixNum];
        for (NSString *str in arrdot) {
            if (numtoadd==[str integerValue]) {
                goto tt1;
            }
        }
        [arrdot addObject:[NSString stringWithFormat:@"%d",numtoadd]];
    }
    if (![self checkVailidRandomNum:arrdot]) {
        goto tt;
    }
    NSLog(@"random dot:%@",arrdot);
    return arrdot;
}

#pragma mark-action
- (IBAction)chooseStyle:(id)sender {
    [self clearScreen];
        isDisable=YES;
    _practiseBtn.enabled=NO;
    _clearBtn.enabled=NO;
    UISegmentedControl *segment=(UISegmentedControl*)sender;
    if (segment.selectedSegmentIndex==0) {
        imageDotTemp=[[[NSMutableArray alloc] initWithArray:_imageDot9] retain];
        matrixNum=3;
        self.pad9.hidden=NO;
        self.pad16.hidden=YES;
        v=_pad9;
        isPad9=YES;
    }
    else{
        isPad9=NO;
        imageDotTemp=[[[NSMutableArray alloc] initWithArray:_imageDot] retain];
        matrixNum=4;
        self.pad9.hidden=YES;
        self.pad16.hidden=NO;
        v=_pad16;
    }
}

- (IBAction)genePress:(id)sender {
    randomPatern=@"";
    _practiseBtn.enabled=YES;
    _clearBtn.enabled=NO;
    _saveBtn.enabled=YES;
    NSMutableArray *randomarr=[[NSMutableArray alloc] initWithArray:[self createRandom]];
        [self writeaPattern:randomarr];
    for (NSString *str in randomarr) {
        randomPatern=[randomPatern stringByAppendingString:str];
    }
    [randomPatern retain];
    NSLog(@"random stringggggg :%@",randomPatern);
    [randomarr release];
    [[AppDelegate shareAppDelegate] takeScreenShotWithView:self.view];
}

- (IBAction)practisePress:(id)sender {
    _clearBtn.enabled=YES;
    [self clearScreen];
    isDisable=NO;
}

- (IBAction)clearPress:(id)sender
{
//    NSArray *arr=[[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];

    
}
- (IBAction)settingPress:(id)sender {
    
    [[AppDelegate shareAppDelegate] addSetting];
}
- (IBAction)savePress:(id)sender {
    
    [[AppDelegate shareAppDelegate]addActionSheet];
}
@end
