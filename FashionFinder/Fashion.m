//
//  Fashion.m
//  FashionFinder
//
//  Created by wdwk on 2017/3/30.
//  Copyright © 2017年 eastedu. All rights reserved.
//

#import "Fashion.h"
#import "Sandbox.h"
#import "FashionConfig.h"

@implementation FashionCategory
-(instancetype)initWithType:(FashionCategoryType)type {
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}
-(NSString *)name {
    switch (_type) {
        case FashionCategoryTypeHairstyle:
            return @"发型";
        case FashionCategoryTypeHeadwear:
            return @"头饰";
        case FashionCategoryTypeJewelry:
            return @"首饰";
        case FashionCategoryTypeClothes:
            return @"服饰";
        case FashionCategoryTypeDecorate:
            return @"装饰品";
        default:
            return @"未知";
    }
}
@end

@implementation FashionAge
-(instancetype)initWithType:(FashionAgeType)type {
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}
-(NSString *)name {
    switch (_type) {
        case FashionAgeTypeInnocence:
            return @"童真";
        case FashionAgeTypeYouth:
            return @"青春";
        case FashionAgeTypeMatures:
            return @"成熟";
        default:
            return @"未知";
            
    }
}
@end

@implementation FashionStyle
-(instancetype)initWithType:(FashionStyleType)type {
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}
-(NSString *)name {
    BOOL isMale = [FashionConfig shareConfig].isMale;
    switch (_type) {
        case FashionStyleTypeLively:
            return@"活泼";
        case FashionStyleTypeBrave:
            return isMale?@"勇猛":@"英姿";
        case FashionStyleTypeElegant:
            return isMale?@"儒雅":@"仪静";
        case FashionStyleTypeRomantic:
            return isMale?@"风流":@"妩媚";
        case FashionStyleTypeDignified:
            return isMale?@"威严":@"端庄";
        case FashionStyleTypeTerror:
            return @"恐怖";
        default:
            return @"未知";
    }
}
@end

@implementation FashionMaterial
-(instancetype)initWithType:(FashionMaterialType)type {
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}
-(NSString *)name {
    switch (_type) {
        case FashionMaterialTypeSimple:
            return @"简约";
        case FashionMaterialTypeLuxury:
            return @"繁华";
        default:
            return @"未知";
    }
}
@end

@implementation FashionTemperature
-(instancetype)initWithType:(FashionTemperatureType)type {
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}
-(NSString *)name {
    switch (_type) {
        case FashionTemperatureTypeCold:
            return @"清凉";
        case FashionTemperatureTypeNormal:
            return @"适温";
        case FashionTemperatureTypeWarm:
            return @"保暖";
        default:
            return @"未知";
    }
}
@end

@implementation FashionExtension
-(instancetype)initWithType:(FashionExtensionType)type {
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}
-(NSString *)name {
    switch (_type) {
        case FashionExtensionTypeXiuxian:
            return @"休闲";
        case FashionExtensionTypeWenren:
            return @"文人";
        case FashionExtensionTypeJianghu:
            return @"江湖";
        case FashionExtensionTypeZhanzheng:
            return @"战争";
        case FashionExtensionTypeYundong:
            return @"运动";
        case FashionExtensionTypeDifu:
            return @"帝服";
        case FashionExtensionTypeGuanfu:
            return @"官服";
        case FashionExtensionTypeLifu:
            return @"礼服";
        case FashionExtensionTypeShenxian:
            return @"神仙";
        case FashionExtensionTypeWudao:
            return @"舞蹈";
        case FashionExtensionTypeYanxi:
            return @"演戏";
        case FashionExtensionTypeHunqing:
            return @"婚庆";
        case FashionExtensionTypeYelu:
            return @"夜路";
        case FashionExtensionTypeSangfu:
            return @"丧服";
        case FashionExtensionTypeZheyu:
            return @"遮雨";
        case FashionExtensionTypeDaoshi:
            return @"道士";
        case FashionExtensionTypeLifo:
            return @"礼佛";
        case FashionExtensionTypeGui:
            return @"鬼";
        case FashionExtensionTypePengren:
            return @"烹饪";
        case FashionExtensionTypeYisheng:
            return @"医生";
        case FashionExtensionTypeShuijiao:
            return @"睡觉";
        case FashionExtensionTypeNanbannv:
            return @"男扮女";
        default:
            return @"未知";
    }
}
@end

@implementation Fashion
-(instancetype)init {
    self = [super init];
    if (self) {
        self.age = [[FashionAge alloc]initWithType:FashionAgeTypeNull];
        self.style = [[FashionStyle alloc]initWithType:FashionStyleTypeNull];
        self.material = [[FashionMaterial alloc]initWithType:FashionMaterialTypeNull];
        self.temperature = [[FashionTemperature alloc]initWithType:FashionTemperatureTypeNull];
        
        self.extensions = [NSMutableArray arrayWithArray:@[[[FashionExtension alloc]initWithType:FashionExtensionTypeNull]]];
    }
    return self;
}

-(instancetype)initByCreate {
    self = [self init];
    if (self) {
        self.category = [[FashionCategory alloc]initWithType:FashionCategoryTypeHairstyle];
        self.age = [[FashionAge alloc]initWithType:FashionAgeTypeInnocence];
        self.style = [[FashionStyle alloc]initWithType:FashionStyleTypeLively];
        self.material = [[FashionMaterial alloc]initWithType:FashionMaterialTypeSimple];
        self.temperature = [[FashionTemperature alloc]initWithType:FashionTemperatureTypeCold];
        self.extensions = [NSMutableArray new];
    }
    return self;
}

-(instancetype)initWithInfo:(NSDictionary *)info {
    self = [super init];
    if (self) {
        self.name = [info objectForKey:@"name"];
        self.category = [[FashionCategory alloc]initWithType:[[info objectForKey:@"category"] intValue]];
        self.age = [[FashionAge alloc]initWithType:[[info objectForKey:@"age"] intValue]];
        self.style = [[FashionStyle alloc]initWithType:[[info objectForKey:@"style"] intValue]];
        self.material = [[FashionMaterial alloc]initWithType:[[info objectForKey:@"material"] intValue]];
        self.temperature = [[FashionTemperature alloc]initWithType:[[info objectForKey:@"temperature"] intValue]];
        self.extensions = [NSMutableArray new];
        NSArray *extensions = [info objectForKey:@"extensions"];
        for (int i=0; i<[extensions count]; i++) {
            FashionExtension *extension = [[FashionExtension alloc]initWithType:[extensions[i] intValue]];
            [self.extensions addObject:extension];
        }
        self.key = [[info objectForKey:@"key"]intValue];
    }
    return self;
}

-(NSDictionary *)dictionaryValue {
    NSMutableArray *extensions = [NSMutableArray new];
    for (FashionExtension *extension in self.extensions) {
        [extensions addObject:@(extension.type)];
    }
    NSDictionary *dictionary = @{@"name":self.name,
                                 @"category":@(self.category.type),
                                 @"age":@(self.age.type),
                                 @"style":@(self.style.type),
                                 @"material":@(self.material.type),
                                 @"temperature":@(self.temperature.type),
                                 @"extensions":extensions,
                                 @"key":@(self.key)};
    return dictionary;
}

-(NSString *)keyName {
    switch (_key) {
        case FashionKeyAge:
            return self.age.name;
        case FashionKeyStyle:
            return self.style.name;
        case FashionKeyMaterial:
            return self.material.name;
        case FashionKeyTemperature:
            return self.temperature.name;
        default:
            return @"无";
    }
}

-(void)setAgeType:(FashionAgeType)ageType {
    self.age = [[FashionAge alloc]initWithType:ageType];
}

-(FashionAgeType)ageType {
    return self.age.type;
}

-(void)setStyleType:(FashionStyleType)styleType {
    self.style = [[FashionStyle alloc]initWithType:styleType];
}

-(FashionStyleType)styleType {
    return self.style.type;
}

-(void)setMaterialType:(FashionMaterialType)materialType {
    self.material = [[FashionMaterial alloc]initWithType:materialType];
}

-(FashionMaterialType)materialType {
    return self.material.type;
}

-(void)setTemperatureType:(FashionTemperatureType)temperatureType {
    self.temperature = [[FashionTemperature alloc]initWithType:temperatureType];
}

-(FashionTemperatureType)temperatureType {
    return self.temperature.type;
}

-(void)setExtensionsType:(NSMutableArray *)extensionsType {
    self.extensions = [NSMutableArray new];
    for (int i=0; i<[extensionsType count]; i++) {
        FashionExtension *extension = [[FashionExtension alloc]initWithType:[extensionsType[i] intValue]];
        [self.extensions addObject:extension];
    }
}

-(instancetype)initByBiography:(FashionBiography)biography level:(NSInteger)level {
    self = [self init];
    if (!self) {
        return nil;
    }
    switch (biography) {
        case FashionBiographCaiwenji: {
            switch (level) {
                case 0: {
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                }
                    break;
                case 1: {
                    self.styleType = FashionStyleTypeElegant;
                    self.temperatureType = FashionTemperatureTypeWarm;
                    self.extensionsType = @[@(FashionExtensionTypeLifu)];
                }
                    break;
                case 2: {
                    self.styleType = FashionStyleTypeBrave;
                    self.extensionsType = @[@(FashionExtensionTypeJianghu),@(FashionExtensionTypeZhanzheng)];
                }
                    break;
                case 3: {
                    self.materialType = FashionMaterialTypeLuxury;
                    self.extensionsType = @[@(FashionExtensionTypeLifu)];
                }
                    break;
                case 4: {
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeJianghu)];
                    [MBProgressHUD showToast:@"黑，佩剑"];
                }
                    break;
                case 5: {
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                    [MBProgressHUD showToast:@"蒙古，匈奴"];
                }
                    break;
                case 6: {
                    self.styleType = FashionStyleTypeDignified;
                    self.materialType = FashionMaterialTypeLuxury;
                    self.extensionsType = @[@(FashionExtensionTypeLifu),@(FashionExtensionTypeGuanfu)];
                }
                    break;
                case 7: {
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeSangfu)];
                    [MBProgressHUD showToast:@"白"];
                }
                    break;
                case 8: {
                    self.styleType = FashionStyleTypeElegant;
                    self.extensionsType = @[@(FashionExtensionTypeWenren)];
                    [MBProgressHUD showToast:@"书籍"];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case FashionBiographyDouyifang: {
                switch (level) {
                    case 0: {
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                        [MBProgressHUD showToast:@"田园风"];
                    }
                        break;
                    case 1: {
                        if ([FashionConfig shareConfig].isMale) {
                            self.styleType = FashionStyleTypeElegant;
                            self.temperatureType = FashionTemperatureTypeWarm;
                            self.extensionsType = @[@(FashionExtensionTypeLifu)];
                        }else{
                            self.styleType = FashionStyleTypeElegant;
                            self.materialType = FashionMaterialTypeSimple;
                            [MBProgressHUD showToast:@"汉代"];
                        }
                    }
                        break;
                    case 2: {
                        self.styleType = FashionStyleTypeDignified;
                        self.materialType = FashionMaterialTypeLuxury;
                        self.extensionsType = @[@(FashionExtensionTypeLifu)];
                        [MBProgressHUD showToast:@"汉代"];
                    }
                        break;
                    case 3: {
                        self.styleType = FashionStyleTypeRomantic;
                        self.extensionsType = @[@(FashionExtensionTypeWudao)];
                        [MBProgressHUD showToast:@"萧"];
                    }
                        break;
                    case 4: {
                        self.styleType = FashionStyleTypeDignified;
                        self.materialType = FashionMaterialTypeLuxury;
                        self.extensionsType = @[@(FashionExtensionTypeGuanfu)];
                        [MBProgressHUD showToast:@"紫"];
                    }
                        break;
                    case 5: {
                        self.ageType = FashionAgeTypeMatures;
                        self.materialType = FashionMaterialTypeSimple;
                        self.temperatureType = FashionTemperatureTypeWarm;
                        self.extensionsType = @[@(FashionExtensionTypeSangfu)];
                        [MBProgressHUD showToast:@"白"];
                    }
                        break;
                    case 6: {
                        if ([FashionConfig shareConfig].isMale) {
                            self.styleType = FashionStyleTypeDignified;
                            self.extensionsType = @[@(FashionExtensionTypeZhanzheng),@(FashionExtensionTypeJianghu)];
                        }else{
                            self.styleType = FashionStyleTypeBrave;
                            self.extensionsType = @[@(FashionExtensionTypeZhanzheng),@(FashionExtensionTypeJianghu)];
                        }
                    }
                        break;
                    case 7: {
                        self.styleType = FashionStyleTypeDignified;
                        self.materialType = FashionMaterialTypeLuxury;
                        self.extensionsType = @[@(FashionExtensionTypeLifu)];
                        [MBProgressHUD showToast:@"汉代"];
                    }
                        break;
                    case 8: {
                        self.materialType = FashionMaterialTypeSimple;
                        self.temperatureType = FashionTemperatureTypeCold;
                        self.extensionsType = @[@(FashionExtensionTypeLifu)];
                    }
                        break;
                    case 9: {
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeHunqing)];
                        [MBProgressHUD showToast:@"红"];
                    }
                        break;
                    default:
                        break;
                }
            }
            break;
        case FashionBiographyJingke: {
            switch (level) {
                case 0: {
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeWarm;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                    [MBProgressHUD showToast:@"异域风"];
                }
                    break;
                case 1: {
                    self.styleType = FashionStyleTypeBrave;
                    self.temperatureType = FashionTemperatureTypeWarm;
                    self.extensionsType = @[@(FashionExtensionTypeJianghu)];
                    [MBProgressHUD showToast:@"黑"];
                }
                    break;
                case 2: {
                    self.materialType = FashionMaterialTypeLuxury;
                    self.extensionsType = @[@(FashionExtensionTypeLifu)];
                    [MBProgressHUD showToast:@"紫"];
                }
                    break;
                case 3: {
                    self.styleType = FashionStyleTypeElegant;
                    self.temperatureType = FashionTemperatureTypeWarm;
                    self.extensionsType = @[@(FashionExtensionTypeLifu)];
                }
                    break;
                case 4: {
                    self.materialType = FashionMaterialTypeLuxury;
                    self.temperatureType = FashionTemperatureTypeWarm;
                    self.extensionsType = @[@(FashionExtensionTypeHunqing)];
                    [MBProgressHUD showToast:@"红，清凉扣分"];
                }
                    break;
                case 5: {
                    self.styleType = FashionStyleTypeBrave;
                    self.extensionsType = @[@(FashionExtensionTypeWudao),@(FashionExtensionTypeJianghu)];
                    [MBProgressHUD showToast:@"佩剑"];
                }
                    break;
                case 6: {
                    self.styleType = FashionStyleTypeDignified;
                    self.extensionsType = @[@(FashionExtensionTypeZhanzheng),@(FashionExtensionTypeGuanfu)];
                }
                    break;
                case 7: {
                    self.styleType = FashionStyleTypeDignified;
                    self.temperatureType = FashionTemperatureTypeWarm;
                    self.extensionsType = @[@(FashionExtensionTypeGuanfu)];
                    [MBProgressHUD showToast:@"威严&勇猛"];
                }
                    break;
                case 8: {
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypeGuanfu)];
                    [MBProgressHUD showToast:@"中国风"];
                }
                    break;
                case 9: {
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                    [MBProgressHUD showToast:@"田园风"];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case FashionBiographyXunlong1: {
            switch (level) {
                case 0: {
                    self.styleType = FashionStyleTypeDignified;
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeGuanfu)];
                }
                    break;
                case 1: {
                    self.styleType = FashionStyleTypeRomantic;
                    self.materialType = FashionMaterialTypeLuxury;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                    [MBProgressHUD showToast:@"保暖扣分"];
                }
                    break;
                case 2: {
                    self.ageType = FashionAgeTypeMatures;
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypePengren)];
                }
                    break;
                case 3: {
                    self.ageType = FashionAgeTypeYouth;
                    self.styleType = FashionStyleTypeRomantic;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                }
                    break;
                case 4: {
                    self.styleType = FashionStyleTypeElegant;
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeNormal;
                    self.extensionsType = @[@(FashionExtensionTypeLifo)];
                    [MBProgressHUD showToast:@"佛珠纳衣无隐藏分"];
                }
                    break;
                case 5: {
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeWarm;
                    self.extensionsType = @[@(FashionExtensionTypeYelu)];
                }
                    break;
                case 6: {
                    self.styleType = FashionStyleTypeBrave;
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeJianghu)];
                }
                    break;
                case 7: {
                    self.styleType = FashionStyleTypeElegant;
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeNormal;
                    self.extensionsType = @[@(FashionExtensionTypeLifo)];
                }
                    break;
                case 8: {
                    self.styleType = FashionStyleTypeRomantic;
                    self.extensionsType = @[@(FashionExtensionTypeJianghu)];
                }
                    break;
                case 9: {
                    self.styleType = FashionStyleTypeLively;
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeNormal;
                    self.extensionsType = @[@(FashionExtensionTypeYundong)];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case FashionBiographyXunlong2: {
            switch (level) {
                case 0: {
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeNormal;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                }
                    break;
                case 1: {
                    self.styleType = FashionStyleTypeBrave;
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeNormal;
                    self.extensionsType = @[@(FashionExtensionTypeYundong)];
                }
                    break;
                case 2: {
                    self.styleType = FashionStyleTypeElegant;
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeNormal;
                    self.extensionsType = @[@(FashionExtensionTypeYisheng)];
                }
                    break;
                case 3: {
                    self.ageType = FashionAgeTypeMatures;
                    self.styleType = FashionStyleTypeElegant;
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeNormal;
                }
                    break;
                case 4: {
                    self.styleType = FashionStyleTypeLively;
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeNormal;
                }
                    break;
                case 5: {
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeNormal;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                    [MBProgressHUD showToast:@"风流扣分"];
                }
                    break;
                case 6: {
                    self.styleType = FashionStyleTypeRomantic;
                    self.materialType = FashionMaterialTypeLuxury;
                    self.extensionsType = @[@(FashionExtensionTypeWudao)];
                }
                    break;
                case 7: {
                    self.styleType = FashionStyleTypeBrave;
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeJianghu)];
                    [MBProgressHUD showToast:@"黑"];
                }
                    break;
                case 8: {
                    self.styleType = FashionStyleTypeElegant;
                    self.materialType = FashionMaterialTypeLuxury;
                    self.extensionsType = @[@(FashionExtensionTypeWenren)];
                }
                    break;
                case 9: {
                    self.styleType = FashionStyleTypeElegant;
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeNormal;
                    self.extensionsType = @[@(FashionExtensionTypeWenren)];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case FashionBiographyXunlong3: {
            switch (level) {
                case 0: {
                    self.styleType = FashionStyleTypeBrave;
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeWarm;
                    self.extensionsType = @[@(FashionExtensionTypeYelu)];
                }
                    break;
                case 1: {
                    self.styleType = FashionStyleTypeRomantic;
                    self.materialType = FashionMaterialTypeLuxury;
                    self.temperatureType = FashionTemperatureTypeNormal;
                    self.extensionsType = @[@(FashionExtensionTypeShenxian)];
                }
                    break;
                case 2: {
                    self.styleType = FashionStyleTypeBrave;
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeNormal;
                    self.extensionsType = @[@(FashionExtensionTypeJianghu)];
                }
                    break;
                case 3: {
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeNormal;
                    self.extensionsType = @[@(FashionExtensionTypeJianghu)];
                }
                    break;
                case 4: {
                    self.styleType = FashionStyleTypeBrave;
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeNormal;
                    self.extensionsType = @[@(FashionExtensionTypeJianghu),@(FashionExtensionTypeYelu)];
                    [MBProgressHUD showToast:@"黑"];
                }
                    break;
                case 5: {
                    self.styleType = FashionStyleTypeElegant;
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeNormal;
                    self.extensionsType = @[@(FashionExtensionTypeShuijiao)];
                    [MBProgressHUD showToast:@"清凉、适温都可以"];
                }
                    break;
                case 6: {
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                }
                    break;
                case 7: {
                    self.styleType = FashionStyleTypeBrave;
                    self.temperatureType = FashionTemperatureTypeNormal;
                    self.extensionsType = @[@(FashionExtensionTypeZhanzheng)];
                }
                    break;
                case 8: {
                    self.styleType = FashionStyleTypeElegant;
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeNormal;
                    self.extensionsType = @[@(FashionExtensionTypeJianghu)];
                }
                    break;
                case 9: {
                    self.styleType = FashionStyleTypeElegant;
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeNormal;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                    [MBProgressHUD showToast:@"白"];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case FashionBiographyXunlong4: {
            switch (level) {
                case 0: {
                    self.ageType = FashionAgeTypeMatures;
                    self.styleType = FashionStyleTypeRomantic;
                    self.materialType = FashionMaterialTypeLuxury;
                    self.temperatureType = FashionTemperatureTypeNormal;
                    self.extensionsType = @[@(FashionExtensionTypeShenxian)];
                }
                    break;
                case 1: {
                    self.ageType = FashionAgeTypeYouth;
                    self.styleType = FashionStyleTypeElegant;
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeWarm;
                    self.extensionsType = @[@(FashionExtensionTypeShuijiao)];
                }
                    break;
                case 2: {
                    if ([FashionConfig shareConfig].isMale) {
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeElegant;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeSangfu)];
                    }else{
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeDignified;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeSangfu)];
                    }
                }
                    break;
                case 3: {
                    self.ageType = FashionAgeTypeMatures;
                    self.styleType = FashionStyleTypeBrave;
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeJianghu),@(FashionExtensionTypeYundong)];
                }
                    break;
                case 4: {
                    self.ageType = FashionAgeTypeYouth;
                    self.styleType = FashionStyleTypeElegant;
                    self.materialType = FashionMaterialTypeLuxury;
                    self.temperatureType = FashionTemperatureTypeNormal;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypeWenren)];
                    [MBProgressHUD showToast:@"白"];
                }
                    break;
                case 5: {
                    if ([FashionConfig shareConfig].isMale) {
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeElegant;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypePengren)];
                    }else{
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeDignified;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypePengren)];
                    }
                }
                    break;
                case 6: {
                    self.ageType = FashionAgeTypeYouth;
                    self.styleType = FashionStyleTypeBrave;
                    self.materialType = FashionMaterialTypeLuxury;
                    self.extensionsType = @[@(FashionExtensionTypeJianghu),@(FashionExtensionTypeYundong)];
                }
                    break;
                case 7: {
                    self.ageType = FashionAgeTypeYouth;
                    self.styleType = FashionStyleTypeLively;
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypeJianghu)];
                }
                    break;
                case 8: {
                    self.ageType = FashionAgeTypeMatures;
                    self.styleType = FashionStyleTypeElegant;
                    self.materialType = FashionMaterialTypeLuxury;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypeWenren)];
                }
                    break;
                case 9: {
                    self.ageType = FashionAgeTypeMatures;
                    self.styleType = FashionStyleTypeElegant;
                    self.materialType = FashionMaterialTypeLuxury;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case FashionBiographyXunlong5: {
            switch (level) {
                case 0: {
                    self.ageType = FashionAgeTypeInnocence;
                    self.styleType = FashionStyleTypeLively;
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                }
                    break;
                case 1: {
                    self.ageType = FashionAgeTypeInnocence;
                    self.styleType = FashionStyleTypeLively;
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                }
                    break;
                case 2: {
                    self.ageType = FashionAgeTypeMatures;
                    self.styleType = FashionStyleTypeRomantic;
                    self.materialType = FashionMaterialTypeLuxury;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                }
                    break;
                case 3: {
                    self.ageType = FashionAgeTypeYouth;
                    self.styleType = FashionStyleTypeBrave;
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeJianghu),@(FashionExtensionTypeYundong)];
                }
                    break;
                case 4: {
                    self.ageType = FashionAgeTypeYouth;
                    self.styleType = FashionStyleTypeRomantic;
                    self.materialType = FashionMaterialTypeLuxury;
                    self.temperatureType = FashionTemperatureTypeCold;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                }
                    break;
                case 5: {
                    self.ageType = FashionAgeTypeMatures;
                    self.styleType = FashionStyleTypeElegant;
                    self.materialType = FashionMaterialTypeLuxury;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                }
                    break;
                case 6: {
                    self.ageType = FashionAgeTypeYouth;
                    self.styleType = FashionStyleTypeLively;
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeYundong)];
                }
                    break;
                case 7: {
                    if([FashionConfig shareConfig].isMale) {
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeRomantic;
                        self.materialType = FashionMaterialTypeLuxury;
                        self.temperatureType = FashionTemperatureTypeCold;
                        self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                    }else{
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeElegant;
                        self.materialType = FashionMaterialTypeLuxury;
                        self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                    }
                }
                    break;
                case 8: {
                    self.ageType = FashionAgeTypeMatures;
                    self.styleType = FashionStyleTypeBrave;
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeYelu),@(FashionExtensionTypeYundong)];
                }
                    break;
                case 9: {
                    if([FashionConfig shareConfig].isMale) {
                        self.ageType = FashionAgeTypeYouth;
                        self.styleType = FashionStyleTypeLively;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypeYundong)];
                    }else{
                        self.ageType = FashionAgeTypeYouth;
                        self.styleType = FashionStyleTypeElegant;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypeYundong)];
                    }
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case FashionBiographyXunlong6: {
            switch (level) {
                case 0: {
                    self.ageType = FashionAgeTypeMatures;
                    self.styleType = FashionStyleTypeDignified;
                    self.materialType = FashionMaterialTypeLuxury;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypeGuanfu)];
                }
                    break;
                case 1: {
                    self.ageType = FashionAgeTypeMatures;
                    self.styleType = FashionStyleTypeLively;
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypeYundong)];
                }
                    break;
                case 2: {
                    self.ageType = FashionAgeTypeMatures;
                    self.styleType = FashionStyleTypeLively;
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeWarm;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypeYundong)];
                }
                    break;
                case 3: {
                    self.ageType = FashionAgeTypeMatures;
                    self.styleType = FashionStyleTypeLively;
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypeJianghu)];
                }
                    break;
                case 4: {
                    self.ageType = FashionAgeTypeMatures;
                    self.styleType = FashionStyleTypeElegant;
                    self.materialType = FashionMaterialTypeLuxury;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypeWenren)];
                }
                    break;
                case 5: {
                    self.ageType = FashionAgeTypeMatures;
                    self.styleType = FashionStyleTypeBrave;
                    self.materialType = FashionMaterialTypeLuxury;
                    self.extensionsType = @[@(FashionExtensionTypeZhanzheng),@(FashionExtensionTypeJianghu)];
                }
                    break;
                case 6: {
                    self.ageType = FashionAgeTypeMatures;
                    self.styleType = FashionStyleTypeElegant;
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                    [MBProgressHUD showToast:@"丧服扣分"];
                }
                    break;
                case 7: {
                    self.ageType = FashionAgeTypeYouth;
                    self.styleType = FashionStyleTypeElegant;
                    self.materialType = FashionMaterialTypeSimple;
                    self.temperatureType = FashionTemperatureTypeWarm;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                }
                    break;
                case 8: {
                    self.ageType = FashionAgeTypeYouth;
                    self.styleType = FashionStyleTypeDignified;
                    self.materialType = FashionMaterialTypeLuxury;
                    self.extensionsType = @[@(FashionExtensionTypeXiuxian)];
                    [MBProgressHUD showToast:@"丧服扣分"];
                }
                    break;
                case 9: {
                    self.ageType = FashionAgeTypeMatures;
                    self.styleType = FashionStyleTypeLively;
                    self.materialType = FashionMaterialTypeSimple;
                    self.extensionsType = @[@(FashionExtensionTypeJianghu),@(FashionExtensionTypeYundong)];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case FashionBiographyXunlong7: {
            if ([FashionConfig shareConfig].isMale) {
                switch (level) {
                    case 0: {
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeElegant;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypeLifu)];
                    }
                        break;
                    case 1: {
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeElegant;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypeLifu)];
                    }
                        break;
                    case 2: {
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeElegant;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeJianghu),@(FashionExtensionTypeYundong)];
                    }
                        break;
                    case 3: {
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeElegant;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeJianghu),@(FashionExtensionTypeYundong)];
                    }
                        break;
                    case 4: {
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeElegant;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeJianghu),@(FashionExtensionTypeYundong)];
                    }
                        break;
                    case 5: {
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeElegant;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeJianghu),@(FashionExtensionTypeYundong)];
                    }
                        break;
                    case 6: {
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeElegant;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeJianghu),@(FashionExtensionTypeWenren)];
                    }
                        break;
                    case 7: {
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeElegant;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypeWenren)];
                    }
                        break;
                    case 8: {
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeElegant;
                        self.materialType = FashionMaterialTypeLuxury;
                        self.extensionsType = @[@(FashionExtensionTypeGuanfu),@(FashionExtensionTypeLifu)];
                    }
                        break;
                    case 9: {
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeElegant;
                        self.materialType = FashionMaterialTypeLuxury;
                        self.extensionsType = @[@(FashionExtensionTypeGuanfu),@(FashionExtensionTypeLifu)];
                    }
                        break;
                    default:
                        break;
                }
            }else{
                switch (level) {
                    case 0: {
                        self.ageType = FashionAgeTypeYouth;
                        self.styleType = FashionStyleTypeDignified;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeJianghu),@(FashionExtensionTypeLifu)];
                    }
                        break;
                    case 1: {
                        self.ageType = FashionAgeTypeYouth;
                        self.styleType = FashionStyleTypeDignified;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeJianghu),@(FashionExtensionTypeLifu)];
                    }
                        break;
                    case 2: {
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeLively;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypeWenren)];
                    }
                        break;
                    case 3: {
                        self.ageType = FashionAgeTypeYouth;
                        self.styleType = FashionStyleTypeBrave;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypeYundong)];
                    }
                        break;
                    case 4: {
                        self.ageType = FashionAgeTypeYouth;
                        self.styleType = FashionStyleTypeBrave;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypeYundong)];
                    }
                        break;
                    case 5: {
                        self.ageType = FashionAgeTypeYouth;
                        self.styleType = FashionStyleTypeLively;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeXiuxian),@(FashionExtensionTypeWenren)];
                    }
                        break;
                    case 6: {
                        self.ageType = FashionAgeTypeYouth;
                        self.styleType = FashionStyleTypeDignified;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeJianghu),@(FashionExtensionTypeWenren)];
                    }
                        break;
                    case 7: {
                        self.ageType = FashionAgeTypeYouth;
                        self.styleType = FashionStyleTypeDignified;
                        self.materialType = FashionMaterialTypeSimple;
                        self.extensionsType = @[@(FashionExtensionTypeYanxi),@(FashionExtensionTypeWenren)];
                    }
                        break;
                    case 8: {
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeDignified;
                        self.materialType = FashionMaterialTypeLuxury;
                        self.extensionsType = @[@(FashionExtensionTypeShenxian),@(FashionExtensionTypeLifu)];
                    }
                        break;
                    case 9: {
                        self.ageType = FashionAgeTypeMatures;
                        self.styleType = FashionStyleTypeDignified;
                        self.materialType = FashionMaterialTypeLuxury;
                        self.extensionsType = @[@(FashionExtensionTypeShenxian),@(FashionExtensionTypeLifu)];
                    }
                        break;
                    default:
                        break;
                }
            }
        }
            break;
        default:
            break;
    }
    return self;
}

@end
