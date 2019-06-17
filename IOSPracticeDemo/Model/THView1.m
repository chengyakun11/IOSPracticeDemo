//
//  THView1.m
//  IOSPracticeDemo
//
//  Created by kent on 2019/4/23.
//  Copyright © 2019 kent. All rights reserved.
//

#import "THView1.h"

@implementation THView1

-(void)setProduct:(THProduct *)product{
    _product = product;
    
    product.name = @"new name";
//    _product.name = @"new name";
    
    NSLog(@"product.name = %@",product.name);
    NSLog(@"_product name = %@",_product.name);
}
@end
