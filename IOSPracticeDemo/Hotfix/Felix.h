//
//  Felix.h
//  IOSPracticeDemo
//
//  Created by kevin on 2019/3/7.
//  Copyright © 2019 kent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Aspects.h"
#import <objc/runtime.h>
#import <JavaScriptCore/JavaScriptCore.h>




//原始资料 https://limboy.me/tech/2018/03/04/ios-lightweight-hotfix.html
//改进资料 https://www.jianshu.com/p/d4574a4268b3
//https://github.com/zhouxing5311/AspectsHotFixDemo

//后续会继续扩展

NS_ASSUME_NONNULL_BEGIN



@interface Felix: NSObject
+ (void)fixIt;
+ (void)evalString:(NSString *)javascriptString;
@end


NS_ASSUME_NONNULL_END
