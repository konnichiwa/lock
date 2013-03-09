//
//  Pattern.m
//  LockGennerator
//
//  Created by luan on 3/6/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import "Pattern.h"

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
    matrixNum=3;
    for (UIImageView *image in _imageDot) {
        [image setImage:[UIImage imageNamed:@"pattern_off_dot"]];
        [image setHighlightedImage:[UIImage imageNamed:@"pattern_on_dot"]];
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
    _paths = [[NSMutableArray alloc] init];
}



- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
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
    NSInteger   preTag=[[_paths lastObject] integerValue];

        if (preTag!=0) {
                    NSLog(@"tag preview:%d",preTag);
            if ((touched.tag==(preTag+1))||(touched.tag==(preTag-1))||(touched.tag==(preTag+matrixNum+1))||(touched.tag==(preTag+matrixNum-1))||(touched.tag==(preTag+matrixNum))||(touched.tag==(preTag-matrixNum))||(touched.tag==(preTag-matrixNum+1))||(touched.tag==(preTag-matrixNum-1))) {
                
            }
            else found=YES;
        }

        if (found)
            return;
        
        [_paths addObject:[NSNumber numberWithInt:touched.tag]];
        [v addDotView:touched];
        
        UIImageView* iv = (UIImageView*)touched;
        iv.highlighted = YES;
    }
    
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // clear up hilite
    [_pad9 clearDotViews];
    for (UIImageView *imageview in _imageDot) {
        [imageview setHighlighted:NO];
    }
    [self.view setNeedsDisplay];
    [self.pad9 setNeedsDisplay];
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
@end
