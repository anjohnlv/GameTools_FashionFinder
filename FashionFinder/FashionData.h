//
//  FashionData.h
//  FashionFinder
//
//  Created by wdwk on 2017/3/30.
//  Copyright © 2017年 eastedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fashion.h"
@interface FashionData : NSObject
@property(nonatomic, strong)NSMutableArray *allFashionsInfo;
@property(nonatomic, strong)NSMutableArray *allFashions;
+(instancetype)shareFashion;
-(BOOL)saveNewFashion:(Fashion *)fashion;
-(void)updateAllFashions;
-(BOOL)deleteFashion:(Fashion *)fashion;
@end
