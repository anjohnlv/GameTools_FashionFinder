//
//  FashionCardViewController.m
//  FashionFinder
//
//  Created by wdwk on 2017/6/7.
//  Copyright © 2017年 eastedu. All rights reserved.
//

#import "FashionCardViewController.h"
#import "Masonry.h"

@interface FashionCardViewController ()

@property(nonatomic, strong)Fashion *fashion;

@end

@implementation FashionCardViewController

-(instancetype)initWithFashion:(Fashion *)fashion {
    self = [super init];
    if (self) {
        _fashion = fashion;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
}

-(void)makeUI {

}


@end
