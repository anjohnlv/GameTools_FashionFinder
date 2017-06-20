//
//  FashionCardViewController.h
//  FashionFinder
//
//  Created by wdwk on 2017/6/7.
//  Copyright © 2017年 eastedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fashion.h"

@interface FashionCardViewController : UIViewController

+(instancetype)new NS_UNAVAILABLE;
-(instancetype)init NS_UNAVAILABLE;
-(instancetype)initWithFashion:(Fashion *)fashion;

@end
