//
//  Fashion.h
//  FashionFinder
//
//  Created by wdwk on 2017/3/30.
//  Copyright © 2017年 eastedu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD+Extension.h"
typedef NS_ENUM(NSInteger, FashionCategoryType) {
    FashionCategoryTypeUnknown = 0,
    FashionCategoryTypeHairstyle,
    FashionCategoryTypeHeadwear,
    FashionCategoryTypeJewelry,
    FashionCategoryTypeClothes,
    FashionCategoryTypeDecorate,
    FashionCategoryCount,
};

typedef NS_ENUM(NSInteger, FashionKey) {
    FashionKeyNull = 0,
    FashionKeyAge,
    FashionKeyStyle,
    FashionKeyMaterial,
    FashionKeyTemperature,
};

typedef NS_ENUM(NSInteger, FashionAgeType) {
    FashionAgeTypeNull = 0,
    FashionAgeTypeInnocence,
    FashionAgeTypeYouth,
    FashionAgeTypeMatures,
    FashionAgeCount,
};

typedef NS_ENUM(NSInteger, FashionStyleType) {
    FashionStyleTypeNull = 0,
    FashionStyleTypeLively,
    FashionStyleTypeElegant,
    FashionStyleTypeRomantic,
    FashionStyleTypeBrave,
    FashionStyleTypeDignified,
    FashionStyleTypeTerror,
    FashionStyleCount,
};

typedef NS_ENUM(NSInteger, FashionMaterialType) {
    FashionMaterialTypeNull = 0,
    FashionMaterialTypeSimple,
    FashionMaterialTypeLuxury,
    FashionMaterialCount,
};

typedef NS_ENUM(NSInteger, FashionTemperatureType) {
    FashionTemperatureTypeNull = 0,
    FashionTemperatureTypeCold,
    FashionTemperatureTypeNormal,
    FashionTemperatureTypeWarm,
    FashionTemperatureCount,
};

typedef NS_ENUM(NSInteger, FashionExtensionType) {
    FashionExtensionTypeNull = 0,
    FashionExtensionTypeXiuxian,
    FashionExtensionTypeWenren,
    FashionExtensionTypeJianghu,
    FashionExtensionTypeZhanzheng,
    FashionExtensionTypeYundong,
    FashionExtensionTypeDifu,
    FashionExtensionTypeGuanfu,
    FashionExtensionTypeLifu,
    FashionExtensionTypeShenxian,
    FashionExtensionTypeWudao,
    FashionExtensionTypeYanxi,
    FashionExtensionTypeHunqing,
    FashionExtensionTypeYelu,
    FashionExtensionTypeSangfu,
    FashionExtensionTypeZheyu,
    FashionExtensionTypeDaoshi,
    FashionExtensionTypeLifo,
    FashionExtensionTypeGui,
    FashionExtensionTypePengren,
    FashionExtensionTypeYisheng,
    FashionExtensionTypeShuijiao,
    FashionExtensionTypeNanbannv,
    FashionExtensionCount,
};

typedef NS_ENUM(NSInteger, FashionBiography) {
    FashionBiographCaiwenji = 0,
    FashionBiographyDouyifang,
    FashionBiographyJingke,
    FashionBiographyDirenjie,
    FashionBiographyYangyuhuan,
    FashionBiographyWaner,
    FashionBiographyXunlong1,
    FashionBiographyXunlong2,
    FashionBiographyXunlong3,
    FashionBiographyXunlong4,
    FashionBiographyXunlong5,
    FashionBiographyXunlong6,
};

@interface FashionCategory : NSObject
-(instancetype)initWithType:(FashionCategoryType)type;
@property(nonatomic)FashionCategoryType type;
@property(nonatomic, strong)NSString *name;
@end

@interface FashionAge : NSObject
-(instancetype)initWithType:(FashionAgeType)type;
@property(nonatomic)FashionAgeType type;
@property(nonatomic, strong)NSString *name;
@end

@interface FashionStyle : NSObject
-(instancetype)initWithType:(FashionStyleType)type;
@property(nonatomic)FashionStyleType type;
@property(nonatomic, strong)NSString *name;
@end

@interface FashionMaterial : NSObject
-(instancetype)initWithType:(FashionMaterialType)type;
@property(nonatomic)FashionMaterialType type;
@property(nonatomic, strong)NSString *name;
@end

@interface FashionTemperature : NSObject
-(instancetype)initWithType:(FashionTemperatureType)type;
@property(nonatomic)FashionTemperatureType type;
@property(nonatomic, strong)NSString *name;
@end

@interface FashionExtension : NSObject
-(instancetype)initWithType:(FashionExtensionType)type;
@property(nonatomic)FashionExtensionType type;
@property(nonatomic, strong)NSString *name;
@end

@interface Fashion : NSObject
@property(nonatomic)NSInteger index;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)FashionAge *age;
@property(nonatomic, strong)FashionStyle *style;
@property(nonatomic, strong)FashionMaterial *material;
@property(nonatomic, strong)FashionTemperature *temperature;
@property(nonatomic, strong)NSMutableArray<FashionExtension *> *extensions;
@property(nonatomic)FashionAgeType ageType;
@property(nonatomic)FashionStyleType styleType;
@property(nonatomic)FashionMaterialType materialType;
@property(nonatomic)FashionTemperatureType temperatureType;
@property(nonatomic, strong)NSArray *extensionsType;
@property(nonatomic)FashionKey key;
@property(nonatomic, strong)NSString *keyName;
@property(nonatomic)FashionCategory *category;
@property(nonatomic)int satisfyCount;
-(instancetype)initByCreate;
-(instancetype)initByBiography:(FashionBiography)biography level:(NSInteger)level;
-(instancetype)initWithInfo:(NSDictionary *)info;
-(NSDictionary *)dictionaryValue;
@end
