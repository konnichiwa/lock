//
//  DrawPatternLockView.m
//  AndroidLock
//
//  Created by Purnama Santo on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DrawPatternLockView.h"

@implementation DrawPatternLockView


- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }

  return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  NSLog(@"drawrect...");
  
  if (!_trackPointValue)
    return;

  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetLineWidth(context, 25.0);
  CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
  CGFloat components[] = {0.5, 0.5, 0.5, 0.8};
  CGColorRef color = CGColorCreate(colorspace, components);
  CGContextSetStrokeColorWithColor(context, color);

  CGPoint from;
  CGPoint from1;
    for (int i=0; i<[_dotViews count]; i++) {
        if (i<[_dotViews count]-1) {
            UIView *dotView=[_dotViews objectAtIndex:i];
            UIView *dotView1=[_dotViews objectAtIndex:i+1];
            from=dotView.center;
            from1=dotView1.center;
            CGContextMoveToPoint(context, from.x, from.y);
            CGContextAddLineToPoint(context, from1.x, from1.y);
        }
        else{
             UIView *dotView=[_dotViews objectAtIndex:i];
             from=dotView.center;
             CGContextMoveToPoint(context, from.x, from.y);
        }
    }
  CGPoint pt = [_trackPointValue CGPointValue];
  NSLog(@"\t cgpoint to: %f, %f", pt.x, pt.y);
  CGContextAddLineToPoint(context, pt.x, pt.y);
  
    
  CGContextStrokePath(context);
  CGColorSpaceRelease(colorspace);
  CGColorRelease(color);

  _trackPointValue = nil;
}


- (void)clearDotViews {
  [_dotViews removeAllObjects];
}


- (void)addDotView:(UIView *)view {
  if (!_dotViews)
    _dotViews = [[NSMutableArray alloc] init];

  [_dotViews addObject:view];
}


- (void)drawLineFromLastDotTo:(CGPoint)pt {
  _trackPointValue = [[NSValue valueWithCGPoint:pt] retain];
  [self setNeedsDisplay];
}


@end
