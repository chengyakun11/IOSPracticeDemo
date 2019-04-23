//
//  NullSafe.m
//
//  Version 2.0
//
//  Created by Nick Lockwood on 19/12/2012.
//  Copyright 2012 Charcoal Design
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/NullSafe
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import <objc/runtime.h>
#import <Foundation/Foundation.h>


#ifndef NULLSAFE_ENABLED
#define NULLSAFE_ENABLED 1
#endif


#pragma clang diagnostic ignored "-Wgnu-conditional-omitted-operand"



//////////////////////NSNull/////////////////////////////////////
@implementation NSNull (NullSafe)
#if NULLSAFE_ENABLED
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    //look up method signature
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if (!signature)
    {
        for (Class someClass in @[
            [NSMutableArray class],
            [NSMutableDictionary class],
            [NSMutableString class],
            [NSNumber class],
            [NSDate class],
            [NSData class]
        ])
        {
            @try
            {
                if ([someClass instancesRespondToSelector:selector])
                {
                    signature = [someClass instanceMethodSignatureForSelector:selector];
                    break;
                }
            }
            @catch (__unused NSException *unused) {}
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    invocation.target = nil;
    [invocation invoke];
}
#endif
@end




//////////////////////NSArray、NSMutableArray、NSMutableDictionary、NSMutableSet/////////////////////////////////////


//NSArray    index不能大于count、object非空判断 containsObject
//    objectAtIndex -> safeObjectAtIndex
//    indexOfObject -> safeIndexOfObject
//NSMutableArray   object非空判断、index不能大于count
//    addObject -> safeAddObject
//    insertObject:atIndex: -> safeInsertObject:atIndex:
//    removeObjectAtIndex: -> safeRemoveObjectAtIndex:
//NSMutableDictionary
//    setObject:forKey: -> safeSetObject:forKey:    object、key非空判断
//NSMutableSet
//    addObject -> safeAddObject      object非空判断


@interface NSArray (YCBStability)
@end

@implementation NSArray (YCBStability)

+ (void)load
{
    array_method_exchangeClass(objc_getClass("__NSArrayI"));
}

void array_method_exchangeClass(Class cls)
{
    array_method_exchangeImplementations(cls,@selector(objectAtIndex:), @selector(safeObjectAtIndex:));
    array_method_exchangeImplementations(cls,@selector(indexOfObject:), @selector(safeIndexOfObject:));
}

void array_method_exchangeImplementations(Class cls, SEL name, SEL name2)
{
    Method fromMethod = class_getInstanceMethod(cls, name);
    Method toMethod = class_getInstanceMethod(cls, name2);
    method_exchangeImplementations(fromMethod, toMethod);
}


- (NSUInteger)safeIndexOfObject:(id)anObject
{
    if (anObject && [self containsObject:anObject]) {
        return [self safeIndexOfObject:anObject];
    } else {
        return 0;
    }
}

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if (index < self.count){
        return [self safeObjectAtIndex:index];
    }else{
        return nil;
    }
}

@end

///////////////////////////////////////////////////////////

@interface NSMutableArray (YCBStability)
@end

@implementation NSMutableArray (YCBStability)

+ (void)load
{
    mutArray_method_exchangeImplementations(@selector(addObject:), @selector(safeAddObject:));
    mutArray_method_exchangeImplementations(@selector(insertObject:atIndex:),@selector(safeInsertObject:atIndex:));
 mutArray_method_exchangeImplementations(@selector(removeObjectAtIndex:),@selector(safeRemoveObjectAtIndex:));
}

- (void)safeAddObject:(id)anObject
{
    if (anObject) {
        [self safeAddObject:anObject];
    }
}

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject) {
        [self safeInsertObject:anObject atIndex:index];
    }
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        [self safeRemoveObjectAtIndex:index];
    }
}

Class objc_NSMutArrayClass()
{
    return objc_getClass("__NSArrayM");
}

void mutArray_method_exchangeImplementations(SEL name, SEL name2)
{
    Method fromMethod = class_getInstanceMethod(objc_NSMutArrayClass(), name);
    Method toMethod = class_getInstanceMethod(objc_NSMutArrayClass(), name2);
    method_exchangeImplementations(fromMethod, toMethod);
}

@end

///////////////////////////////////////////////////////

@interface NSMutableDictionary (YCBStability)
@end

@implementation NSMutableDictionary (YCBStability)

+ (void)load
{
    Method fromMethod = class_getInstanceMethod(objc_NSMutDictionaryClass(), @selector(setObject:forKey:));
    Method toMethod = class_getInstanceMethod(objc_NSMutDictionaryClass(), @selector(safeSetObject:forKey:));
    method_exchangeImplementations(fromMethod, toMethod);
}

- (void)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey;
{
    if (anObject && aKey) {
        [self safeSetObject:anObject forKey:aKey];
    }
}

Class objc_NSMutDictionaryClass() {
    
    return objc_getClass("__NSDictionaryM");
}

@end


///////////////////////////////////////////////////////

@interface NSMutableSet (YCBStability)
@end

@implementation NSMutableSet (YCBStability)

+ (void)load
{
    mutSet_method_exchangeImplementations(@selector(addObject:), @selector(safeAddObject:));
}

- (void)safeAddObject:(id)anObject
{
    if (anObject) {
        [self safeAddObject:anObject];
    }
}

Class objc_NSMutSetClass()
{
    return objc_getClass("__NSSetM");
}

void mutSet_method_exchangeImplementations(SEL name, SEL name2) {
    
    Method fromMethod = class_getInstanceMethod(objc_NSMutSetClass(), name);
    Method toMethod = class_getInstanceMethod(objc_NSMutSetClass(), name2);
    method_exchangeImplementations(fromMethod, toMethod);
}

@end

///////////////////////////////////////////////////////
