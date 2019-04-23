//
//  MightyCrash.m
//  IOSPracticeDemo
//
//  Created by kevin on 2019/3/7.
//  Copyright © 2019 kent. All rights reserved.
//

#import "MightyCrash.h"

@implementation MightyCrash

// 传一个 0 就 gg 了
- (float)divideUsingDenominator:(NSInteger)denominator
{
    
    if(denominator ==0){
        NSArray *array = [[NSArray alloc] initWithObjects:@"1",@"2",nil];
        NSString *aa = array[3];
        return 0;
    }
    return 1.f/denominator;
}

@end
