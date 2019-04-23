//
//  TestNullSafe.m
//  IOSPracticeDemo
//
//  Created by kevin on 2019/3/6.
//  Copyright © 2019 kent. All rights reserved.
//

#import "TestNullSafe.h"

@implementation TestNullSafe

- (void)testAll
{
    [self testStringValue];
    NSLog(@"\n");
    [self testFloatValue];
    NSLog(@"\n");
    [self testIntValue];
    NSLog(@"\n");
    [self testPointerValue];
    NSLog(@"\n");
    [self testClass];
    NSLog(@"\n");
    [self testDescription];
    NSLog(@"\n");
    [self testRange];
    NSLog(@"\n");
    [self testCategory];
}


- (void)testStringValue
{
    @try{
        id nullValue = [NSNull null];
        NSString *result = [nullValue stringValue];
        NSLog(@"testStringValue ============ %@ ",result);
    }@catch(NSException *e){
        NSLog(@"testStringValue eee = %@",e);
    }
}

- (void)testFloatValue
{
    @try{
        id nullValue = [NSNull null];
        __unused float x = floorf(123.456f);
        float result = [nullValue floatValue];
        NSLog(@"testFloatValue ============ %f ",result);
    }@catch(NSException *e){
        NSLog(@"testFloatValue eee = %@",e);
    }
}

- (void)testIntValue
{
    @try{
        id nullValue = [NSNull null];
        int result = [nullValue intValue];
        NSLog(@"testIntValue ============ %d ",result);
        
    }@catch(NSException *e){
        NSLog(@"testIntValue eee = %@",e);
    }
}

- (void)testPointerValue
{
    @try{
        id nullValue = [NSNull null];
        const void *result = [nullValue bytes];
        NSLog(@"testPointerValue ============ %p ",result);
    }@catch(NSException *e){
        NSLog(@"testPointerValue eee = %@",e);
    }
}

- (void)testClass
{
    @try{
        id nullValue = [NSNull null];
        NSString *result = NSStringFromClass([nullValue class]);
        NSLog(@"testClass ============ %@ ",result);
    }@catch(NSException *e){
        NSLog(@"testClass eee = %@",e);
    }
}

- (void)testDescription
{
    @try{
        id nullValue = [NSNull null];
        NSString *result = [nullValue description];
        NSLog(@"testDescription ============ %@ ",result);
    }@catch(NSException *e){
        NSLog(@"testClass eee = %@",e);
    }
}

- (void)testRange
{
    @try{
        id nullValue = [NSNull null];
        NSRange result = [nullValue range];
        NSLog(@"testRange ============ %ld,%ld ",result.length,result.location);
    }@catch(NSException *e){
        NSLog(@"testClass eee = %@",e);
    }
}

- (void)testCategory
{
    //    @try{
    //        id nullValue = [NSNull null];
    //        __unused double x = floor(123.456);
    //        double result = [nullValue NullTestMethod];
    //        NSLog(@"testCategory ============ %lf ",result);
    //    }@catch(NSException *e){
    //        NSLog(@"testClass eee = %@",e);
    //    }
}



@end
