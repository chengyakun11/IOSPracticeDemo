//
//  ViewController.m
//  IOSPracticeDemo
//
//  Created by kevin on 2019/3/6.
//  Copyright © 2019 kent. All rights reserved.
//

#import "ViewController.h"
#import "TestNullSafe.h"
#import "MightyCrash.h"

#import "Felix.h"
#import "THView1.h"
#import "THView2.h"
#import "THProduct.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    TestNullSafe *nullSafe = [[TestNullSafe alloc] init];
//    [nullSafe testAll];
    
    
    
//    [Felix fixIt];
//
//    NSString *fixScriptString = @" \
//    fixInstanceMethodReplace('MightyCrash', 'divideUsingDenominator:', function(instance, originInvocation, originArguments){ \
//    if (originArguments[0] == 0) { \
//    console.log('zero goes here'); \
//    } else { \
//    runInvocation(originInvocation); \
//    } \
//    }); \
//    \
//    ";
//
//    [Felix evalString:fixScriptString];
//
//
//
//    MightyCrash *mc = [[MightyCrash alloc] init];
//    float result = [mc divideUsingDenominator:3];
//    NSLog(@"result: %.3f", result);
//    result = [mc divideUsingDenominator:0];
//    NSLog(@"won't crash");
//
    
    
    // output
    // result: 0.333
    // Javascript log: zero goes here
    // won't crash
    
    
    
    
    
//    1、参数的生命周期
//
//    值传递、引用传递
//    局部变量
//
//    函数参数传值。
//
//    赋值
//
//    浅谈NSString*做为形参传值
//    https://www.jianshu.com/p/482f7328fce3
    
    
    
    THProduct *p1 = [[THProduct alloc] init];
    p1.name = @"name";
    p1.en_name = @"en_name";
    NSLog(@"p1.name : %@",p1.name);


    THView1 *view1 = [[THView1 alloc] init];
    view1.product = p1;
    NSLog(@"p1.name : %@",p1.name);

    NSLog(@"eqweqweqw");
    
    
    
    
    
    
    
//    THProduct *p2 = [[THProduct alloc] init];
//    p2.name = @"name";
//    NSLog(@"p2.name :%@",p2.name);
//
//
//    p2.en_name = @"en_name";
//    NSLog(@"p2.en_name :%@",p2.en_name);
}











@end
