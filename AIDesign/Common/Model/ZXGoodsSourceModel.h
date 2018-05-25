//
//  ZXGoodsModel.h
//  AIDesign
//
//  Created by xinying on 2018/3/26.
//  Copyright © 2018年 habav. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZXGoodsModel,ZXGoodsDoubleModel;

@interface ZXGoodsSourceModel : NSObject

@property(nonatomic,strong) NSArray<NSArray<ZXGoodsModel *> *> *data;

@end

@interface ZXGoodsArrayModel : NSObject

@property(nonatomic,strong) NSArray<ZXGoodsModel *> *goodsArray;

@end

@interface ZXGoodsDoubleModel : NSObject

@property(nonatomic,strong) ZXGoodsModel *goods1;
@property(nonatomic,strong) ZXGoodsModel *goods2;

@end

@interface ZXGoodsModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *currentPrice;
@property (nonatomic, strong) NSString *unit;

@property (nonatomic, assign) NSInteger payOrdOfferQty7d;
@property (nonatomic, assign) NSInteger isces;
@property (nonatomic, assign) NSInteger soldOut;
@property (nonatomic, assign) NSInteger oldPrice;
@property (nonatomic, assign) NSInteger payOrdCnt30d;
@property (nonatomic, strong) NSString *expo_data;
@property (nonatomic, assign) NSInteger quantityBegin;
@property (nonatomic, strong) NSArray *activities;
@property (nonatomic, assign) NSInteger payOrdCnt7d;
@property (nonatomic, strong) NSString *detailUrl;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, assign) NSInteger isPowerfulValid;
@property (nonatomic, strong) NSArray *services;
@property (nonatomic, assign) NSInteger payOrdOfferQty30d;
@property (nonatomic, strong) NSString *testPrice;
@property (nonatomic, strong) NSString *offerId;

@property (nonatomic, assign) NSInteger num;

@property(nonatomic,assign) NSInteger type;
@property (nonatomic, strong) NSString *deadTime;

@end
