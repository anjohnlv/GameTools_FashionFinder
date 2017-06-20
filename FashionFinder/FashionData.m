//
//  FashionData.m
//  FashionFinder
//
//  Created by wdwk on 2017/3/30.
//  Copyright © 2017年 eastedu. All rights reserved.
//

#import "FashionData.h"
#import "Sandbox.h"

@implementation FashionData

+(instancetype)shareFashion {
    static FashionData *fashionData = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        fashionData = [[self alloc] init];
        [fashionData loadAllFashions];
    });
    return fashionData;
}

-(void)loadAllFashions {
    _allFashionsInfo = [Sandbox fashionsInfo];
    _allFashions = [NSMutableArray new];
    for (int i=0; i<[_allFashionsInfo count]; i++) {
        Fashion *fashion = [[Fashion alloc]initWithInfo:_allFashionsInfo[i]];
        fashion.index = i;
        [_allFashions addObject:fashion];
    }
}

-(BOOL)saveNewFashion:(Fashion *)fashion {
    NSDictionary *fashionInfo = [fashion dictionaryValue];
    [_allFashionsInfo addObject:fashionInfo];
    [_allFashions addObject:fashion];
    return [Sandbox saveFashions:_allFashionsInfo];
}

-(void)updateAllFashions {
    [self loadAllFashions];
}

-(BOOL)deleteFashion:(Fashion *)fashion {
    [_allFashions removeObjectAtIndex:fashion.index];
    [_allFashionsInfo removeObjectAtIndex:fashion.index];
    return [Sandbox saveFashions:_allFashionsInfo];
}

@end
