//
//  FashionInsertViewController.m
//  FashionFinder
//
//  Created by wdwk on 2017/6/7.
//  Copyright © 2017年 eastedu. All rights reserved.
//

#import "FashionInsertViewController.h"
#import "Masonry.h"
#import "Fashion.h"
#import "FashionData.h"
#import "PropertyCollectionView.h"
#import "FashionConfig.h"

@interface FashionInsertViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong)UITextField *nameTextField;
@property(nonatomic, strong)PropertyCollectionView *typeCollectionView,*ageCollectionView,*styleCollectionView,*materialCollectionView,*temperatureCollectionView,*extensionCollectionView;
@property(nonatomic, strong)Fashion *fashion;
@end

@implementation FashionInsertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _fashion = [[Fashion alloc]initByCreate];
    [self makeUI];
}

-(void)makeUI {
    self.title = @"新时装";
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [saveButton setFrame:CGRectMake(0, 0, 40, 30)];
    [saveButton setContentHorizontalAlignment : UIControlContentHorizontalAlignmentRight];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveFashion:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * btnRight = [[UIBarButtonItem alloc]initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = btnRight;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _nameTextField = [UITextField new];
    [_nameTextField setFont:[UIFont systemFontOfSize:14]];
    [_nameTextField setPlaceholder:@"输入时装名字"];
    [_nameTextField setBorderStyle:UITextBorderStyleNone];
    [self.view addSubview:_nameTextField];
    [_nameTextField becomeFirstResponder];
    [_nameTextField addTarget:_nameTextField action:@selector(resignFirstResponder) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view).offset(64);
        make.right.equalTo(self.view).offset(-20);
        make.left.equalTo(self.view).offset(20);
        make.height.mas_equalTo(@30);
    }];
    
    _typeCollectionView = [self makeFashionPropertyView];
    [self.view addSubview:_typeCollectionView];
    [_typeCollectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(_nameTextField.mas_bottom);
        make.height.mas_equalTo(kItemHeight);
    }];
    _ageCollectionView = [self makeFashionPropertyView];
    [self.view addSubview:_ageCollectionView];
    [_ageCollectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(_typeCollectionView.mas_bottom).offset(1);
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
    _extensionCollectionView.selectedIndexPaths = [NSMutableArray new];
    [self.view addSubview:_extensionCollectionView];
    [_extensionCollectionView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(_temperatureCollectionView.mas_bottom).offset(1);
        make.height.mas_equalTo(kItemHeight*3);
    }];
}

-(PropertyCollectionView *)makeFashionPropertyView {
    PropertyCollectionView *collectionView = [PropertyCollectionView new];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    return collectionView;
}

-(void)saveFashion:(UIButton *)sender {
    NSString *fashionName = [_nameTextField text];
    _fashion.name = fashionName;
    if (![self checkFashion]) {
        return;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@   %@\n%@   %@\n%@   %@\n%@",_fashion.name,_fashion.category.name,_fashion.age.name,_fashion.style.name,_fashion.material.name,_fashion.temperature.name,[self showExtensions]] message:@"确认新时装,无误后选择超级属性（即比其他属性长的那一个）" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"无超级属性" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action){
        [self saveWithKey:FashionKeyNull];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"超级属性：%@",self.fashion.age.name] style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action){
        [self saveWithKey:FashionKeyAge];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"超级属性：%@",self.fashion.style.name] style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action){
        [self saveWithKey:FashionKeyStyle];
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"超级属性：%@",self.fashion.material.name] style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action){
        [self saveWithKey:FashionKeyMaterial];
    }];
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"超级属性：%@",self.fashion.temperature.name] style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action){
        [self saveWithKey:FashionKeyTemperature];
    }];
    UIAlertAction *action6 = [UIAlertAction actionWithTitle:@"取消保存" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    [alertController addAction:action4];
    [alertController addAction:action5];
    [alertController addAction:action6];
    alertController.popoverPresentationController.sourceView = sender;
    alertController.popoverPresentationController.sourceRect = sender.bounds;
    [self presentViewController:alertController animated:YES completion:nil];
}

-(NSString *)showExtensions {
    NSString *extensions;
    for (int i=0; i<[self.fashion.extensions count]; i++) {
        if (i==0) {
            extensions = self.fashion.extensions[i].name;
        }else {
            extensions = [NSString stringWithFormat:@"%@,%@",extensions,self.fashion.extensions[i].name];
        }
    }
    if ([extensions length]==0) {
        extensions = @"无";
    }
    return extensions;
}

-(void)saveWithKey:(FashionKey)key {
    self.fashion.key = key;
    self.fashion.name = _fashion.name;
    BOOL suc = [[FashionData shareFashion] saveNewFashion:self.fashion];
    if (!suc) {
        [MBProgressHUD showToast:@"哦豁，异常了哒"];
    }else {
        [MBProgressHUD showToast:@"已记录"];
        [self clearUI];
    }
}

-(BOOL)checkFashion {
    if ([_fashion.name length]==0) {
        [MBProgressHUD showToast:@"缺名字"];
        return NO;
    }
    if (_fashion.category.type == FashionCategoryTypeUnknown || _fashion.age.type == FashionAgeTypeNull || _fashion.style.type == FashionStyleTypeNull || _fashion.temperature.type == FashionTemperatureTypeNull || [_fashion.extensions count]==0) {
        [MBProgressHUD showToast:@"缺类别"];
        return NO;
    }
    return YES;
}

-(void)clearUI {
    _fashion = [[Fashion alloc]initByCreate];
    [_nameTextField setText:@""];
    _typeCollectionView.selectedIndexPaths = [NSMutableArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
    _ageCollectionView.selectedIndexPaths = [NSMutableArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
    _styleCollectionView.selectedIndexPaths = [NSMutableArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
    _materialCollectionView.selectedIndexPaths = [NSMutableArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
    _temperatureCollectionView.selectedIndexPaths = [NSMutableArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
    _extensionCollectionView.selectedIndexPaths = [NSMutableArray new];
    [_typeCollectionView reloadData];
    [_ageCollectionView reloadData];
    [_styleCollectionView reloadData];
    [_materialCollectionView reloadData];
    [_temperatureCollectionView reloadData];
    [_extensionCollectionView reloadData];
}

#pragma mark - collectionView delegate &datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == _ageCollectionView) {
        return FashionAgeCount-1;
    }else if (collectionView == _styleCollectionView){
        return FashionStyleCount-1;
    }else if (collectionView == _materialCollectionView){
        return FashionMaterialCount-1;
    }else if (collectionView == _temperatureCollectionView){
        return FashionTemperatureCount-1;
    }else if (collectionView == _extensionCollectionView){
        return FashionExtensionCount-1;
    }else if (collectionView == _typeCollectionView) {
        return FashionCategoryCount-1;
    }
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PropertyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [PropertyCollectionViewCell new];
    }
    BOOL selected = NO;
    NSInteger row = [indexPath row]+1;
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
        
    }else if (collectionView == _typeCollectionView) {
        FashionCategory *category = [[FashionCategory alloc]initWithType:row];
        cell.title = category.name;
        selected = (_fashion.category.type == row);
    }
    cell.itemState = selected?PropertyCellStateSelected:PropertyCellStateNormal;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row] + 1;
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
    }else if (collectionView == _typeCollectionView) {
        FashionCategory *category = [[FashionCategory alloc]initWithType:row];
        title = category.name;
    }
    CGSize sizeToFit = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    return CGSizeMake(sizeToFit.width+20, 26);
}

-(void)collectionView:(PropertyCollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    NSMutableArray *reloadIndexPaths;
    if (collectionView == _ageCollectionView) {
        if (collectionView.selectedIndexPaths[0].row == row) {
            return;
        }
        [collectionView.selectedIndexPaths addObject:indexPath];
        reloadIndexPaths = [NSMutableArray arrayWithArray:collectionView.selectedIndexPaths];
        collectionView.selectedIndexPaths = [NSMutableArray arrayWithObject:indexPath];
        _fashion.age = [[FashionAge alloc]initWithType:row+1];
    }else if (collectionView == _styleCollectionView) {
        if (collectionView.selectedIndexPaths[0].row == row) {
            return;
        }
        [collectionView.selectedIndexPaths addObject:indexPath];
        reloadIndexPaths = [NSMutableArray arrayWithArray:collectionView.selectedIndexPaths];
        collectionView.selectedIndexPaths = [NSMutableArray arrayWithObject:indexPath];
        _fashion.style = [[FashionStyle alloc]initWithType:row+1];
    }else if (collectionView == _materialCollectionView) {
        if (collectionView.selectedIndexPaths[0].row == row) {
            return;
        }
        [collectionView.selectedIndexPaths addObject:indexPath];
        reloadIndexPaths = [NSMutableArray arrayWithArray:collectionView.selectedIndexPaths];
        collectionView.selectedIndexPaths = [NSMutableArray arrayWithObject:indexPath];
        _fashion.material = [[FashionMaterial alloc]initWithType:row+1];
    }else if (collectionView == _temperatureCollectionView) {
        if (collectionView.selectedIndexPaths[0].row == row) {
            return;
        }
        [collectionView.selectedIndexPaths addObject:indexPath];
        reloadIndexPaths = [NSMutableArray arrayWithArray:collectionView.selectedIndexPaths];
        collectionView.selectedIndexPaths = [NSMutableArray arrayWithObject:indexPath];
        _fashion.temperature = [[FashionTemperature alloc]initWithType:row+1];
    }else if (collectionView == _extensionCollectionView) {
        BOOL selected = NO;
        for (int i=0; i<[_fashion.extensions count]; i++) {
            if (_fashion.extensions[i].type == row+1) {
                selected = YES;
                [_fashion.extensions removeObjectAtIndex:i];
            }
        }
        if (!selected) {
            [_fashion.extensions addObject:[[FashionExtension alloc]initWithType:row+1]];
            [collectionView.selectedIndexPaths addObject:indexPath];
            reloadIndexPaths = [NSMutableArray arrayWithArray:collectionView.selectedIndexPaths];
        }else {
            reloadIndexPaths = [NSMutableArray arrayWithObject:indexPath];
            [collectionView.selectedIndexPaths removeObject:indexPath];
        }
    }else if (collectionView == _typeCollectionView) {
        if (collectionView.selectedIndexPaths[0].row == row) {
            return;
        }
        [collectionView.selectedIndexPaths addObject:indexPath];
        reloadIndexPaths = [NSMutableArray arrayWithArray:collectionView.selectedIndexPaths];
        collectionView.selectedIndexPaths = [NSMutableArray arrayWithObject:indexPath];
        _fashion.category = [[FashionCategory alloc]initWithType:row+1];
    }
    [collectionView reloadItemsAtIndexPaths:reloadIndexPaths];
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

@end
