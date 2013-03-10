//
//  NSArray+sortBy.m
//  LockGennerator
//
//  Created by luan on 3/10/13.
//  Copyright (c) 2013 Luan. All rights reserved.
//

#import "NSArray+sortBy.h"

@implementation NSArray (sortBy)
- (NSArray*) sortByObjectTag
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id objA, id objB){
        return(
               ([objA tag] < [objB tag]) ? NSOrderedAscending  :
               ([objA tag] > [objB tag]) ? NSOrderedDescending :
               NSOrderedSame);
    }];
}

- (NSArray*) sortByUIViewOriginX
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id objA, id objB){
        return(
               ([objA frame].origin.x < [objB frame].origin.x) ? NSOrderedAscending  :
               ([objA frame].origin.x > [objB frame].origin.x) ? NSOrderedDescending :
               NSOrderedSame);
    }];
}

- (NSArray*) sortByUIViewOriginY
{
    return [self sortedArrayUsingComparator:^NSComparisonResult(id objA, id objB){
        return(
               ([objA frame].origin.y < [objB frame].origin.y) ? NSOrderedAscending  :
               ([objA frame].origin.y > [objB frame].origin.y) ? NSOrderedDescending :
               NSOrderedSame);
    }];
}

@end
