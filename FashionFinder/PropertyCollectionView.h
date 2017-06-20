//
//  PropertyCollectionView.h
//  FashionFinder
//
//  Created by wdwk on 2017/6/5.
//  Copyright © 2017年 eastedu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PropertyCellState)
{
    PropertyCellStateNormal = 0,
    PropertyCellStateSelected,
};

static NSString *CollectionCellID = @"PropertyCell";
static const CGFloat kItemHeight = 30.f;

@interface PropertyCollectionViewCell : UICollectionViewCell

@property(nonatomic)PropertyCellState itemState;
@property(nonatomic,strong)NSString *title;

@end

@interface PropertyCollectionView : UICollectionView

@property(nonatomic, strong)NSMutableArray<NSIndexPath *> *selectedIndexPaths;

@end
