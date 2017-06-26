//
//  PropertyCollectionView.m
//  FashionFinder
//
//  Created by wdwk on 2017/6/5.
//  Copyright © 2017年 eastedu. All rights reserved.
//

#import "PropertyCollectionView.h"
#import "Masonry.h"

@interface PropertyCollectionViewCell()

@property(nonatomic, strong)UIButton *titleButton;

@end
@implementation PropertyCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [[_titleButton titleLabel]setFont:[UIFont systemFontOfSize:12]];
        _titleButton.layer.masksToBounds = YES;
        _titleButton.layer.cornerRadius = 5;
        _titleButton.layer.borderWidth = 0.5;
        [_titleButton setUserInteractionEnabled:NO];
        UIColor *color = [[_titleButton titleLabel]textColor];
        _titleButton.layer.borderColor = [color CGColor];
        [self.contentView addSubview:_titleButton];
        [_titleButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.center.equalTo(self.contentView);
            make.size.equalTo(self.contentView);
        }];
        
        
    }
    return self;
}

-(void)setItemState:(PropertyCellState)itemState {
    _itemState = itemState;
    UIColor *color = [UIColor colorWithCGColor:[[_titleButton layer] borderColor]];
    if (_itemState == PropertyCellStateSelected) {
        [_titleButton setBackgroundColor:color];
        [_titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        [_titleButton setBackgroundColor:[UIColor whiteColor]];
        [_titleButton setTitleColor:color forState:UIControlStateNormal];
    }
}

-(void)setTitle:(NSString *)title {
    _title = title;
    NSLog(@"title:%@",_title);
    [_titleButton setTitle:_title forState:UIControlStateNormal];
}

@end

@implementation PropertyCollectionView

-(instancetype)init {
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize=CGSizeMake(44,26);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.sectionInset = UIEdgeInsetsMake(2, 10, 2, 10);
    self = [super initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    if (self) {
        [self setShowsHorizontalScrollIndicator:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self registerClass:[PropertyCollectionViewCell class] forCellWithReuseIdentifier:CollectionCellID];
        [self setMultipleTouchEnabled:YES];
        _selectedIndexPaths = [NSMutableArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    return self;
}

-(void)setSelectedIndexPaths:(NSMutableArray<NSIndexPath *> *)selectedIndexPaths {
    NSLog(@"set");
    _selectedIndexPaths = selectedIndexPaths;
}

@end
