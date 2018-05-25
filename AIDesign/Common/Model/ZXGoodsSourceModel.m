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

@implementation ZXGoodsArrayModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"goodsArray":@"ZXGoodsModel"
             };
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.goodsArray forKey:@"goodsArray"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.goodsArray = [aDecoder decodeObjectForKey:@"goodsArray"];
    }
    return self;
}

@end


@implementation ZXGoodsModel
//@property (nonatomic, strong) NSString *title;
//@property (nonatomic, strong) NSString *img;
//@property (nonatomic, strong) NSString *currentPrice;
//@property (nonatomic, strong) NSString *unit;
//
//@property (nonatomic, assign) NSInteger payOrdOfferQty7d;
//@property (nonatomic, assign) NSInteger isces;
//@property (nonatomic, assign) NSInteger soldOut;
//@property (nonatomic, assign) NSInteger oldPrice;
//@property (nonatomic, assign) NSInteger payOrdCnt30d;
//@property (nonatomic, strong) NSString *expo_data;
//@property (nonatomic, assign) NSInteger quantityBegin;
//@property (nonatomic, strong) NSArray *activities;
//@property (nonatomic, assign) NSInteger payOrdCnt7d;
//@property (nonatomic, strong) NSString *detailUrl;
//@property (nonatomic, strong) NSString *id;
//@property (nonatomic, assign) NSInteger isPowerfulValid;
//@property (nonatomic, strong) NSArray *services;
//@property (nonatomic, assign) NSInteger payOrdOfferQty30d;
//@property (nonatomic, strong) NSString *testPrice;
//@property (nonatomic, strong) NSString *offerId;
//
//@property (nonatomic, assign) NSInteger num;
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.img forKey:@"img"];
    [aCoder encodeObject:self.currentPrice forKey:@"currentPrice"];
    [aCoder encodeObject:self.unit forKey:@"unit"];
    [aCoder encodeInteger:self.payOrdOfferQty7d forKey:@"payOrdOfferQty7d"];
    [aCoder encodeInteger:self.isces forKey:@"isces"];
    [aCoder encodeInteger:self.soldOut forKey:@"soldOut"];
    [aCoder encodeInteger:self.oldPrice forKey:@"oldPrice"];
    [aCoder encodeInteger:self.payOrdCnt30d forKey:@"payOrdCnt30d"];
    [aCoder encodeObject:self.expo_data forKey:@"expo_data"];
    [aCoder encodeInteger:self.quantityBegin forKey:@"quantityBegin"];
    [aCoder encodeObject:self.activities forKey:@"activities"];
    [aCoder encodeInteger:self.payOrdCnt7d forKey:@"payOrdCnt7d"];
    [aCoder encodeObject:self.detailUrl forKey:@"detailUrl"];
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeInteger:self.isPowerfulValid forKey:@"isPowerfulValid"];
    [aCoder encodeObject:self.services forKey:@"services"];
    [aCoder encodeInteger:self.payOrdOfferQty30d forKey:@"payOrdOfferQty30d"];
    [aCoder encodeObject:self.testPrice forKey:@"testPrice"];
    [aCoder encodeObject:self.offerId forKey:@"offerId"];
    [aCoder encodeInteger:self.num forKey:@"num"];
    [aCoder encodeInteger:self.type forKey:@"type"];
    [aCoder encodeObject:self.deadTime forKey:@"deadTime"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.img = [aDecoder decodeObjectForKey:@"img"];
        self.currentPrice = [aDecoder decodeObjectForKey:@"currentPrice"];
        self.unit = [aDecoder decodeObjectForKey:@"unit"];
        self.payOrdOfferQty7d = [aDecoder decodeIntegerForKey:@"payOrdOfferQty7d"];
        self.isces = [aDecoder decodeIntegerForKey:@"isces"];
        self.soldOut = [aDecoder decodeIntegerForKey:@"soldOut"];
        self.oldPrice = [aDecoder decodeIntegerForKey:@"oldPrice"];
        self.payOrdCnt30d = [aDecoder decodeIntegerForKey:@"payOrdCnt30d"];
        self.expo_data = [aDecoder decodeObjectForKey:@"expo_data"];
        self.quantityBegin = [aDecoder decodeIntegerForKey:@"quantityBegin"];
        self.activities = [aDecoder decodeObjectForKey:@"activities"];
        self.payOrdCnt7d = [aDecoder decodeIntegerForKey:@"payOrdCnt7d"];
        self.detailUrl = [aDecoder decodeObjectForKey:@"detailUrl"];
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.isPowerfulValid = [aDecoder decodeIntegerForKey:@"isPowerfulValid"];
        self.services = [aDecoder decodeObjectForKey:@"services"];
        self.payOrdOfferQty30d = [aDecoder decodeIntegerForKey:@"payOrdOfferQty30d"];
        self.testPrice = [aDecoder decodeObjectForKey:@"testPrice"];
        self.offerId = [aDecoder decodeObjectForKey:@"offerId"];
        self.num = [aDecoder decodeIntegerForKey:@"num"];
        self.type = [aDecoder decodeIntegerForKey:@"type"];
        self.deadTime = [aDecoder decodeObjectForKey:@"deadTime"];
    }
    return self;
}

@end
