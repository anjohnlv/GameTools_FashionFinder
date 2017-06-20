//
//  FashionQueryViewController.m
//  FashionFinder
//
//  Created by wdwk on 2017/6/5.
//  Copyright © 2017年 eastedu. All rights reserved.
//

#import "FashionQueryViewController.h"
#import "PropertyCollectionView.h"
#import "Masonry.h"
#import "Fashion.h"
#import "FashionInsertViewController.h"
#import "FashionData.h"
#import "FashionTableView.h"
#import "FashionConfig.h"

@interface FashionQueryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)PropertyCollectionView *ageCollectionView,*styleCollectionView,*materialCollectionView,*temperatureCollectionView,*extensionCollectionView;
@property(nonatomic, strong)FashionTableView *fashionTableView;
@property(nonatomic, strong)Fashion *fashion;
@property(nonatomic, strong)NSMutableArray<Fashion *> *allFashions, *fashionBiographys;
@end

@implementation FashionQueryViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_allFashions) {
        [self findFashion];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"查询时装";
    self.fashion = [Fashion new];
    [FashionConfig shareConfig].isMale = YES;
    _allFashions = [FashionData shareFashion].allFashions;
    UIButton *genderButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [genderButton setFrame:CGRectMake(0, 0, 100, 30)];
    [genderButton setContentHorizontalAlignment : UIControlContentHorizontalAlignmentLeft];
    [genderButton setTitle:@"男" forState:UIControlStateNormal];
    [genderButton addTarget:self action:@selector(changeGender:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * btnLeft = [[UIBarButtonItem alloc]initWithCustomView:genderButton];
    self.navigationItem.leftBarButtonItem = btnLeft;
    
    UIButton *insertButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [insertButton setFrame:CGRectMake(0, 0, 100, 30)];
    [insertButton setContentHorizontalAlignment : UIControlContentHorizontalAlignmentRight];
    [insertButton setTitle:@"新时装" forState:UIControlStateNormal];
    [insertButton addTarget:self action:@selector(insertFashion) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * btnRight = [[UIBarButtonItem alloc]initWithCustomView:insertButton];
    self.navigationItem.rightBarButtonItem = btnRight;

    _ageCollectionView = [self makeFashionPropertyView];
    [self.view addSubview:_ageCollectionView];
    [_ageCollectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.mas_equalTo(kItemHeight);
    }];
    _styleCollectionView = [self makeFashionPropertyView];
    [self.view addSubview:_styleCollectionView];
    [_styleCollectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(_ageCollectionView.mas_bottom).offset(1);
        make.height.mas_equalTo(kItemHeight);
    }];
    _materialCollectionView = [self makeFashionPropertyView];
    [self.view addSubview:_materialCollectionView];
    [_materialCollectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(_styleCollectionView.mas_bottom).offset(1);
        make.height.mas_equalTo(kItemHeight);
    }];
    _temperatureCollectionView = [self makeFashionPropertyView];
    [self.view addSubview:_temperatureCollectionView];
    [_temperatureCollectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(_materialCollectionView.mas_bottom).offset(1);
        make.height.mas_equalTo(kItemHeight);
    }];
    _extensionCollectionView = [self makeFashionPropertyView];
    [self.view addSubview:_extensionCollectionView];
    [_extensionCollectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(_temperatureCollectionView.mas_bottom).offset(1);
        make.height.mas_equalTo(kItemHeight*3);
    }];
    
    _fashionTableView = [FashionTableView new];
    _fashionTableView.fashions = _allFashions;
    [self.view addSubview:_fashionTableView];
    [_fashionTableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.and.right.and.bottom.equalTo(self.view);
        make.top.equalTo(_extensionCollectionView.mas_bottom).offset(40);
    }];
    [_fashionTableView reloadData];
    
    for (int i=0; i<12; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        NSString *title;
        switch (i) {
            case 0:
                title = @"蔡文\n姬传";
                break;
            case 1:
                title = @"窦漪\n房传";
                break;
            case 2:
                title = @"荆轲传";
                break;
            case 3:
                title = @"狄仁\n杰传";
                break;
            case 4:
                title = @"杨玉\n环传";
                break;
            case 5:
                title = @"婉儿传";
                break;
            case 6:
                title = @"寻龙\n传壹";
                break;
            case 7:
                title = @"寻龙\n传贰";
                break;
            case 8:
                title = @"寻龙\n传叁";
                break;
            case 9:
                title = @"寻龙\n传肆";
                break;
            case 10:
                title = @"寻龙\n传伍";
                break;
            case 11:
                title = @"寻龙\n传陆";
                break;
        }
        [button setTitle:title forState:UIControlStateNormal];
        [[button titleLabel]setFont:[UIFont systemFontOfSize:10]];
        [[button titleLabel]setNumberOfLines:2];
        [button addTarget:self action:@selector(fashionBiography:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.equalTo(_extensionCollectionView.mas_bottom);
            make.bottom.equalTo(_fashionTableView.mas_top);
            make.width.equalTo(self.view).multipliedBy(1.0/12);
            make.centerX.equalTo(self.view).multipliedBy((1.0+i*2)/12);
        }];
    }
}

-(PropertyCollectionView *)makeFashionPropertyView {
    PropertyCollectionView *collectionView = [PropertyCollectionView new];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    return collectionView;
}

#pragma mark - find
-(void)findFashion {
    for (int i=0; i<[_allFashions count]; i++) {
        Fashion *fashion = _allFashions[i];
        fashion.satisfyCount = 0;
        if (self.fashion.age.type==fashion.age.type) {
            fashion.satisfyCount++;
        }
        if (self.fashion.style.type==fashion.style.type) {
            fashion.satisfyCount++;
        }
        if (self.fashion.material.type==fashion.material.type) {
            fashion.satisfyCount++;
        }
        if (self.fashion.temperature.type==fashion.temperature.type) {
            fashion.satisfyCount++;
        }
        for (int j=0; j<[self.fashion.extensions count]; j++) {
            FashionExtension *targetExtension = self.fashion.extensions[j];
            for (int k=0; k<[fashion.extensions count]; k++) {
                FashionExtension *extension = fashion.extensions[k];
                if (extension.type == targetExtension.type) {
                    fashion.satisfyCount++;
                    break;
                }
            }
        }
    }
    [_fashionTableView reloadData];
}

#pragma mark - create
-(void)insertFashion {
    FashionInsertViewController *insertVC = [FashionInsertViewController new];
    [self.navigationController pushViewController:insertVC animated:YES];
}

#pragma mark - change gender
-(void)changeGender:(UIButton *)sender {
    FashionConfig *config = [FashionConfig shareConfig];
    config.isMale = !config.isMale;
    [sender setTitle:config.isMale?@"男":@"女" forState:UIControlStateNormal];
    [_styleCollectionView reloadData];
    [[FashionData shareFashion] updateAllFashions];
    _allFashions = [FashionData shareFashion].allFashions;
    _fashionTableView.fashions = _allFashions;
    [self findFashion];
}

#pragma mark - collectionView delegate &datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == _ageCollectionView) {
        return FashionAgeCount;
    }else if (collectionView == _styleCollectionView){
        return FashionStyleCount;
    }else if (collectionView == _materialCollectionView){
        return FashionMaterialCount;
    }else if (collectionView == _temperatureCollectionView){
        return FashionTemperatureCount;
    }else if (collectionView == _extensionCollectionView){
        return FashionExtensionCount;
    }
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PropertyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [PropertyCollectionViewCell new];
    }
    BOOL selected = NO;
    NSInteger row = [indexPath row];
    if (collectionView == _ageCollectionView) {
        FashionAge *age = [[FashionAge alloc]initWithType:row];
        cell.title = age.name;
        selected = (_fashion.age.type == row);
    }else if (collectionView == _styleCollectionView) {
        FashionStyle *style = [[FashionStyle alloc]initWithType:row];
        cell.title = style.name;
        selected = (_fashion.style.type == row);
    }else if (collectionView == _materialCollectionView) {
        FashionMaterial *material = [[FashionMaterial alloc]initWithType:row];
        cell.title = material.name;
        selected = (_fashion.material.type == row);
    }else if (collectionView == _temperatureCollectionView) {
        FashionTemperature *temperature = [[FashionTemperature alloc]initWithType:row];
        cell.title = temperature.name;
        selected = (_fashion.temperature.type == row);
    }else if (collectionView == _extensionCollectionView) {
        FashionExtension *extension = [[FashionExtension alloc]initWithType:row];
        cell.title = extension.name;
        if ([_fashion.extensions count]>0) {
            for (FashionExtension *extension in _fashion.extensions) {
                if (extension.type == row) {
                    selected = YES;
                    break;
                }
            }
        }else if (row == 0) {
            selected = YES;
        }
        
    }
    cell.itemState = selected?PropertyCellStateSelected:PropertyCellStateNormal;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    NSString *title;
    if (collectionView == _ageCollectionView) {
        FashionAge *age = [[FashionAge alloc]initWithType:row];
        title = age.name;
    }else if (collectionView == _styleCollectionView) {
        FashionStyle *style = [[FashionStyle alloc]initWithType:row];
        title = style.name;
    }else if (collectionView == _materialCollectionView) {
        FashionMaterial *material = [[FashionMaterial alloc]initWithType:row];
        title = material.name;
    }else if (collectionView == _temperatureCollectionView) {
        FashionTemperature *temperature = [[FashionTemperature alloc]initWithType:row];
        title = temperature.name;
    }else if (collectionView == _extensionCollectionView) {
        FashionExtension *extension = [[FashionExtension alloc]initWithType:row];
        title = extension.name;
    }
    CGSize sizeToFit = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    return CGSizeMake(sizeToFit.width+20, 26);
}

-(void)collectionView:(PropertyCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    NSMutableArray *reloadIndexPaths;
    if (collectionView == _ageCollectionView) {
        if (row == collectionView.selectedIndexPaths[0].row) {
            return;
        }
        [collectionView.selectedIndexPaths addObject:indexPath];
        reloadIndexPaths = [NSMutableArray arrayWithArray:collectionView.selectedIndexPaths];
        collectionView.selectedIndexPaths = [NSMutableArray arrayWithObject:indexPath];
        _fashion.age = [[FashionAge alloc]initWithType:row];
    }else if (collectionView == _styleCollectionView) {
        if (row == collectionView.selectedIndexPaths[0].row) {
            return;
        }
        [collectionView.selectedIndexPaths addObject:indexPath];
        reloadIndexPaths = [NSMutableArray arrayWithArray:collectionView.selectedIndexPaths];
        collectionView.selectedIndexPaths = [NSMutableArray arrayWithObject:indexPath];
        _fashion.style = [[FashionStyle alloc]initWithType:row];
    }else if (collectionView == _materialCollectionView) {
        if (row == collectionView.selectedIndexPaths[0].row) {
            return;
        }
        [collectionView.selectedIndexPaths addObject:indexPath];
        reloadIndexPaths = [NSMutableArray arrayWithArray:collectionView.selectedIndexPaths];
        collectionView.selectedIndexPaths = [NSMutableArray arrayWithObject:indexPath];
        _fashion.material = [[FashionMaterial alloc]initWithType:row];
    }else if (collectionView == _temperatureCollectionView) {
        if (row == collectionView.selectedIndexPaths[0].row) {
            return;
        }
        [collectionView.selectedIndexPaths addObject:indexPath];
        reloadIndexPaths = [NSMutableArray arrayWithArray:collectionView.selectedIndexPaths];
        collectionView.selectedIndexPaths = [NSMutableArray arrayWithObject:indexPath];
        _fashion.temperature = [[FashionTemperature alloc]initWithType:row];
    }else if (collectionView == _extensionCollectionView) {
        if (row == 0) {
            _fashion.extensions = [NSMutableArray new];
            if (row == collectionView.selectedIndexPaths[0].row) {
                return;
            }
            [collectionView.selectedIndexPaths addObject:indexPath];
            reloadIndexPaths = [NSMutableArray arrayWithArray:collectionView.selectedIndexPaths];
            collectionView.selectedIndexPaths = [NSMutableArray arrayWithObject:indexPath];
        }else{
            if (collectionView.selectedIndexPaths[0].row == 0) {
                [_fashion.extensions addObject:[[FashionExtension alloc]initWithType:row]];
                [collectionView.selectedIndexPaths addObject:indexPath];
                reloadIndexPaths = [NSMutableArray arrayWithArray:collectionView.selectedIndexPaths];
                collectionView.selectedIndexPaths = [NSMutableArray arrayWithObject:indexPath];
            }else{
                if (collectionView.selectedIndexPaths[0].row == 0) {
                    [collectionView.selectedIndexPaths addObject:indexPath];
                    reloadIndexPaths = [NSMutableArray arrayWithArray:collectionView.selectedIndexPaths];
                    collectionView.selectedIndexPaths = [NSMutableArray arrayWithObject:indexPath];
                }else{
                    BOOL selected = NO;
                    for (int i=0; i<[_fashion.extensions count]; i++) {
                        if (_fashion.extensions[i].type == row) {
                            selected = YES;
                            [_fashion.extensions removeObjectAtIndex:i];
                        }
                    }
                    if (!selected) {
                        [_fashion.extensions addObject:[[FashionExtension alloc]initWithType:row]];
                        [collectionView.selectedIndexPaths addObject:indexPath];
                        reloadIndexPaths = [NSMutableArray arrayWithArray:collectionView.selectedIndexPaths];
                    }else {
                        reloadIndexPaths = [NSMutableArray arrayWithArray:collectionView.selectedIndexPaths];
                        [collectionView.selectedIndexPaths removeObject:indexPath];
                        if ([collectionView.selectedIndexPaths count]==0) {
                            NSIndexPath *defaultIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                            collectionView.selectedIndexPaths = [NSMutableArray arrayWithObject:defaultIndexPath];
                            [reloadIndexPaths addObject:defaultIndexPath];
                        }
                    }
                }
            }
        }
    }
    [collectionView reloadItemsAtIndexPaths:reloadIndexPaths];
    [self findFashion];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (collectionView == _extensionCollectionView) {
        return 0;
    }
    return 6;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 6;
}

#pragma mark - 时装传记
-(void)fashionBiography:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            [self biography:@"蔡文姬传" sender:sender levels:9];
            break;
        case 1:
            [self biography:@"窦漪房传" sender:sender levels:10];
            break;
        case 2:
            [self biography:@"荆轲传" sender:sender levels:10];
            break;
        case 8:
            [self biography:@"寻龙传叁" sender:sender levels:10];
            break;
        case 9:
            [self biography:@"寻龙传肆" sender:sender levels:10];
            break;
        case 10:
            [self biography:@"寻龙传伍" sender:sender levels:10];
            break;
        case 11:
            [self biography:@"寻龙传陆" sender:sender levels:10];
            break;
        default:
            break;
    }
}

-(void)biography:(NSString *)title sender:(UIButton *)sender levels:(NSInteger)count {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i<count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"第%d关",i+1] style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action){
            _fashion = [[Fashion alloc]initByBiography:sender.tag level:i];
            [self showFashion];
        }];
        [alertController addAction:action];
    }
    alertController.popoverPresentationController.sourceView = sender;
    alertController.popoverPresentationController.sourceRect = sender.bounds;
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)showFashion {
    [_ageCollectionView reloadData];
    [_styleCollectionView reloadData];
    [_materialCollectionView reloadData];
    [_temperatureCollectionView reloadData];
    [_extensionCollectionView reloadData];
    [self findFashion];
}

-(void)fashionBiography:(UIButton *)sender numberOfAction:(NSInteger)count {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"蔡文姬传" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i<9; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"第%d关",i+1] style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action){
            _fashion = [[Fashion alloc]initByBiography:sender.tag level:i];
        }];
        [alertController addAction:action];
    }
    alertController.popoverPresentationController.sourceView = sender;
    alertController.popoverPresentationController.sourceRect = sender.bounds;
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
