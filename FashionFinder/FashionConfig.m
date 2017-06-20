//
//  FashionConfig.m
//  FashionFinder
//
//  Created by wdwk on 2017/6/7.
//  Copyright © 2017年 eastedu. All rights reserved.
//

#import "FashionConfig.h"

@implementation FashionConfig

+(instancetype)shareConfig {
    static FashionConfig *fashionConfig = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        fashionConfig = [[self alloc] init];
    });
    return fashionConfig;
}

@end
