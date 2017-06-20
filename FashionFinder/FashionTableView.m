//
//  FashionTableView.m
//  FashionFinder
//
//  Created by wdwk on 2017/4/7.
//  Copyright © 2017年 eastedu. All rights reserved.
//

#import "FashionTableView.h"
#import "Masonry.h"
#import "FashionConfig.h"
#import "FashionData.h"

static NSString *kCellIdentifier = @"FashionCell";

@interface FashionTableViewCell : UITableViewCell

@property(nonatomic, strong)UIButton *nameButton,*ageButton,*styleButton,*materialButton,*temperaterButton,*satisfyButton,*extensionsButton;
@property(nonatomic, strong)Fashion *fashion;

@end

@implementation FashionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _nameButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [[_nameButton titleLabel] setNumberOfLines:2];
        [[_nameButton titleLabel]setFont:[UIFont boldSystemFontOfSize:12]];
        [self.contentView addSubview:_nameButton];
        [_nameButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.height.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(self.contentView).multipliedBy(1.0/6);
            make.centerX.equalTo(self.contentView).multipliedBy(1.0/6);
            
        }];
        _ageButton = [self makeCustomButton];
        [self.contentView addSubview:_ageButton];
        [_ageButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.height.equalTo(self.contentView).multipliedBy(1.0/2);
            make.centerY.equalTo(self.contentView).multipliedBy(1.0/2);
            make.width.equalTo(self.contentView).multipliedBy(1.0/6);
            make.centerX.equalTo(self.contentView).multipliedBy(3.0/6);

        }];
        _styleButton = [self makeCustomButton];
        [self.contentView addSubview:_styleButton];
        [_styleButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.height.equalTo(self.contentView).multipliedBy(1.0/2);
            make.centerY.equalTo(self.contentView).multipliedBy(1.0/2);
            make.width.equalTo(self.contentView).multipliedBy(1.0/6);
            make.centerX.equalTo(self.contentView).multipliedBy(5.0/6);
            
        }];
        _materialButton = [self makeCustomButton];
        [self.contentView addSubview:_materialButton];
        [_materialButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.height.equalTo(self.contentView).multipliedBy(1.0/2);
            make.centerY.equalTo(self.contentView).multipliedBy(1.0/2);
            make.width.equalTo(self.contentView).multipliedBy(1.0/6);
            make.centerX.equalTo(self.contentView).multipliedBy(7.0/6);
            
        }];
        _temperaterButton = [self makeCustomButton];
        [self.contentView addSubview:_temperaterButton];
        [_temperaterButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.height.equalTo(self.contentView).multipliedBy(1.0/2);
            make.centerY.equalTo(self.contentView).multipliedBy(1.0/2);
            make.width.equalTo(self.contentView).multipliedBy(1.0/6);
            make.centerX.equalTo(self.contentView).multipliedBy(9.0/6);
            
        }];
        _extensionsButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [[_extensionsButton titleLabel]setTextAlignment:NSTextAlignmentLeft];
        [[_extensionsButton titleLabel]setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:_extensionsButton];
        [_extensionsButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.height.equalTo(self.contentView).multipliedBy(1.0/2);
            make.centerY.equalTo(self.contentView).multipliedBy(3.0/2);
            make.width.equalTo(self.contentView).multipliedBy(4.0/6);
            make.centerX.equalTo(self.contentView).multipliedBy(6.0/6);
            
        }];
        _satisfyButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [[_satisfyButton titleLabel]setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:_satisfyButton];
        [_satisfyButton mas_makeConstraints:^(MASConstraintMaker *make){
            make.height.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(self.contentView).multipliedBy(1.0/6);
            make.centerX.equalTo(self.contentView).multipliedBy(11.0/6);
        }];
    }
    return self;
}

-(UIButton *)makeCustomButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [[button titleLabel]setFont:[UIFont systemFontOfSize:12]];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 10;
    button.layer.borderWidth = 0.5;
    UIColor *color = [[button titleLabel]textColor];
    button.layer.borderColor = [color CGColor];
    return button;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if (_fashion) {
        [_nameButton setTitle:_fashion.name forState:UIControlStateNormal];
        [_ageButton setTitle:_fashion.age.name forState:UIControlStateNormal];
        [_styleButton setTitle:_fashion.style.name forState:UIControlStateNormal];
        [_materialButton setTitle:_fashion.material.name forState:UIControlStateNormal];
        [_temperaterButton setTitle:_fashion.temperature.name forState:UIControlStateNormal];
        NSString *extensions;
        for (int i=0; i<[_fashion.extensions count]; i++) {
            if (i==0) {
                extensions = self.fashion.extensions[i].name;
            }else {
                extensions = [NSString stringWithFormat:@"%@，%@",extensions,self.fashion.extensions[i].name];
            }
        }
        if ([extensions length]==0) {
            extensions = @"无";
        }
        [_extensionsButton setTitle:extensions forState:UIControlStateNormal];
        [_satisfyButton setTitle:@(_fashion.satisfyCount).stringValue forState:UIControlStateNormal];
        [self setKey];
    }
}

-(void)setKey{
    switch (_fashion.key) {
        case FashionKeyAge: {
            _ageButton.layer.borderWidth = 0.5;
            _styleButton.layer.borderWidth = 0;
            _materialButton.layer.borderWidth = 0;
            _temperaterButton.layer.borderWidth = 0;
            break;
        }
        case FashionKeyStyle: {
            _ageButton.layer.borderWidth = 0;
            _styleButton.layer.borderWidth = 0.5;
            _materialButton.layer.borderWidth = 0;
            _temperaterButton.layer.borderWidth = 0;
            break;
        }
        case FashionKeyMaterial: {
            _ageButton.layer.borderWidth = 0;
            _styleButton.layer.borderWidth = 0;
            _materialButton.layer.borderWidth = 0.5;
            _temperaterButton.layer.borderWidth = 0;
            break;
        }
        case FashionKeyTemperature: {
            _ageButton.layer.borderWidth = 0;
            _styleButton.layer.borderWidth = 0;
            _materialButton.layer.borderWidth = 0;
            _temperaterButton.layer.borderWidth = 0.5;
            break;
        }
        default: {
            _ageButton.layer.borderWidth = 0;
            _styleButton.layer.borderWidth = 0;
            _materialButton.layer.borderWidth = 0;
            _temperaterButton.layer.borderWidth = 0;
            break;
        }
    }
}

@end

@implementation FashionTableView {
    NSMutableArray *hairstyleFashions;
    NSMutableArray *headwearFashions;
    NSMutableArray *jewelryFashions;
    NSMutableArray *clothesFashions;
    NSMutableArray *decorateFashions;
}
-(instancetype)init {
    self = [super init];
    if (self) {
        [self setDelegate:self];
        [self setDataSource:self];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self registerClass:[FashionTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
        self.sectionIndexBackgroundColor = [UIColor clearColor];
        self.sectionIndexTrackingBackgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [hairstyleFashions count];
        case 1:
            return [headwearFashions count];
        case 2:
            return [jewelryFashions count];
        case 3:
            return [clothesFashions count];
        case 4:
            return [decorateFashions count];
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [UIView new];
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [[titleButton titleLabel] setTextAlignment:NSTextAlignmentCenter];
    [[titleButton titleLabel] setFont:[UIFont systemFontOfSize:12]];
    UIColor *color = [[titleButton titleLabel]textColor];
    [myView setBackgroundColor:color];
    [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    NSString *title;
    NSInteger count = 0;
    switch (section) {
        case 0:
            title = @"发型";
            count = [hairstyleFashions count];
            break;
        case 1:
            title = @"头饰";
            count = [headwearFashions count];
            break;
        case 2:
            title = @"首饰";
            count = [jewelryFashions count];
            break;
        case 3:
            title = @"服饰";
            count = [clothesFashions count];
            break;
        case 4:
            title = @"装饰物";
            count = [decorateFashions count];
            break;
        default:
            break;
    }
    title = [NSString stringWithFormat:@"%@(%d)",title,(int)count];
    [titleButton setTitle:title forState:UIControlStateNormal];
    [myView addSubview:titleButton];
    [titleButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.equalTo(myView);
        make.center.equalTo(myView);
    }];
    return myView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FashionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        cell = [[FashionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier] ;
    }
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    Fashion *fashion;
    switch (section) {
        case 0:
            fashion = hairstyleFashions[row];
            break;
        case 1:
            fashion = headwearFashions[row];
            break;
        case 2:
            fashion = jewelryFashions[row];
            break;
        case 3:
            fashion = clothesFashions[row];
            break;
        case 4:
            fashion = decorateFashions[row];
            break;
        default:
            break;
    }
    cell.fashion = fashion;
    UIColor *backgroundColor = row%2==0?[UIColor colorWithWhite:0.95 alpha:1]:[UIColor colorWithWhite:0.85 alpha:1];
    [cell setBackgroundColor:backgroundColor];
    return cell;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [NSArray arrayWithObjects:@"发型",@"头饰",@"首饰",@"服饰",@"装饰品",nil];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger row = [indexPath row];
        NSInteger section = [indexPath section];
        Fashion *fashion;
        switch (section) {
            case 0:
                fashion = hairstyleFashions[row];
                break;
            case 1:
                fashion = headwearFashions[row];
                break;
            case 2:
                fashion = jewelryFashions[row];
                break;
            case 3:
                fashion = clothesFashions[row];
                break;
            case 4:
                fashion = decorateFashions[row];
                break;
            default:
                break;
        }
        [[FashionData shareFashion] deleteFashion:fashion];
        [self reloadData];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

-(void)reloadData {
    hairstyleFashions = [NSMutableArray new];
    headwearFashions = [NSMutableArray new];
    jewelryFashions = [NSMutableArray new];
    clothesFashions = [NSMutableArray new];
    decorateFashions = [NSMutableArray new];
    for (Fashion *fashion in _fashions) {
        switch (fashion.category.type) {
            case FashionCategoryTypeHairstyle:
                [self sortFashion:fashion inArray:hairstyleFashions];
                break;
            case FashionCategoryTypeHeadwear:
                [self sortFashion:fashion inArray:headwearFashions];
                break;
            case FashionCategoryTypeJewelry:
                [self sortFashion:fashion inArray:jewelryFashions];
                break;
            case FashionCategoryTypeClothes:
                [self sortFashion:fashion inArray:clothesFashions];
                break;
            case FashionCategoryTypeDecorate:
                [self sortFashion:fashion inArray:decorateFashions];
                break;
            default:
                break;
        }
    }
    [super reloadData];
}

-(void)sortFashion:(Fashion *)fashion inArray:(NSMutableArray <Fashion *> *)array {
    [array addObject:fashion];
    [array sortUsingComparator:^NSComparisonResult(Fashion *fashion1, Fashion *fashion2) {
        NSNumber *number1 = @(fashion1.satisfyCount);
        NSNumber *number2 = @(fashion2.satisfyCount);
        return [number2 compare:number1];
    }];
}

@end
