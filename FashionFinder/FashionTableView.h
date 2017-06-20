//
//  FashionTableView.h
//  FashionFinder
//
//  Created by wdwk on 2017/4/7.
//  Copyright © 2017年 eastedu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fashion.h"

@interface FashionTableView : UITableView<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)NSMutableArray<Fashion *> *fashions;

@end
