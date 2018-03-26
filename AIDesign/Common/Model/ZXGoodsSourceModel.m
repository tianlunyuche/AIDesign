//
//  ZXGoodsModel.m
//  AIDesign
//
//  Created by xinying on 2018/3/26.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXGoodsSourceModel.h"

@implementation ZXGoodsSourceModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"data":@"ZXGoodsModel"
             };
}

@end

@implementation ZXGoodsDoubleModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"goods1":@"ZXGoodsModel",
              @"goods2":@"ZXGoodsModel"
             };
}

@end


@implementation ZXGoodsModel

@end
