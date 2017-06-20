//
//  Sandbox.m
//  BaseDemo
//
//  Created by webseat2 on 13-8-5.
//  Copyright (c) 2013年 WebSeat. All rights reserved.
//

#import "Sandbox.h"
#import "FashionConfig.h"

@implementation Sandbox

+(NSMutableArray *)fashionsInfo {
    BOOL isMale = [FashionConfig shareConfig].isMale;
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:isMale?@"fashions_male.plist":@"fashions_female.plist"];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    if (!arr) {
        arr = [NSMutableArray new];
    }
    return arr;
}

+(BOOL)saveFashions:(NSMutableArray *)fashions
{
    BOOL isMale = [FashionConfig shareConfig].isMale;
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:isMale?@"fashions_male.plist":@"fashions_female.plist"];
    BOOL b = [fashions writeToFile:filePath atomically:NO];
    if (!b) {
        NSLog(@"%@写入失败",fashions);
    }
    return b;
}

@end
