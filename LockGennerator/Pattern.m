//
//  Pattern.m
//  LockGennerator
//
//  Created by luan on 3/6/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import "Pattern.h"
#import "NSArray+sortBy.h"
@interface Pattern ()

@end

@implementation Pattern

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
    self.imageDot = [self.imageDot sortByObjectTag];
    matrixNum=3;
    for (UIImageView *image in _imageDot) {
        [image setImage:[UIImage imageNamed:@"pad_off"]];
        [image setHighlightedImage:[UIImage imageNamed:@"pad_on"]];
    }
    // Do any additional setup after loading the view from its nib.
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
    [super dealloc];
}
- (void)viewDidUnload {
    [self setImageDot:nil];
    [self setPad9:nil];
    [super viewDidUnload];
}

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
    CGPoint pt = [[touches anyObject] locationInView:self.pad9];
    UIView *touched = [[self.pad9 hitTest:pt withEvent:event] retain];
    
    DrawPatternLockView *v = (DrawPatternLockView*)_pad9;
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
                for (UIImageView *imageView in _imageDot) {
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
                NSLog(@"corner:%f",corner);
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
    if (_target && _action)
        [_target performSelector:_action withObject:[self getKey]];
}


// get key from the pattern drawn
// replace this method with your own key-generation algorithm
- (NSString*)getKey {
    NSMutableString *key;
    key = [NSMutableString string];
    
    // simple way to generate a key
    for (NSNumber *tag in _paths) {
        [key appendFormat:@"%02d", tag.integerValue];
    }
    return key;
}


- (void)setTarget:(id)target withAction:(SEL)action {
    _target = target;
    _action = action;
}

-(void)clearScreen
{
    [_pad9 clearDotViews];
    for (UIImageView *imageview in _imageDot) {
        [imageview setHighlightedImage:[UIImage imageNamed:@"pad_on"]];
        [imageview setHighlighted:NO];
         imageview.transform = CGAffineTransformMakeRotation(0);
    }
    [self.pad9 setNeedsDisplay];

}
-(void)writeaPattern:(NSArray*)arrdot{
    [self clearScreen];
    DrawPatternLockView *v = (DrawPatternLockView*)_pad9;
    for (int i=0; i<[arrdot count]; i++) {
        NSString *strTag=[arrdot objectAtIndex:i];
        [v addDotView:[_imageDot objectAtIndex:[strTag integerValue]-1]];
        UIImageView *dotFrom=[_imageDot objectAtIndex:[strTag integerValue]-1];
        if (i<[arrdot count]-1) {
            NSString *strTag1=[arrdot objectAtIndex:i+1];
            UIImageView *dotTo=[_imageDot objectAtIndex:[strTag1 integerValue]-1];
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
            
            NSLog(@"corner:%f",corner);
            [dotFrom setHighlightedImage:[UIImage imageNamed:@"pad_indicator"]];
            dotFrom.transform = CGAffineTransformMakeRotation(corner);
            dotFrom.highlighted=YES;

        }
        else
        {
        dotFrom.highlighted=YES;
        }
    
    }
[_pad9 setNeedsDisplay];
    isDisable=YES;
}

- (IBAction)clearPress:(id)sender
{
    NSArray *arr=[[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    [self writeaPattern:arr];
}
@end
