//
//  ZXOrders.h
//  AIDesign
//
//  Created by xinying on 2018/5/9.
//  Copyright © 2018年 habav. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXOrder;

@interface ZXOrders : NSObject

@property(nonatomic,strong) NSString *userID;
@property(nonatomic,strong) NSArray<ZXOrder *> *order;

@end


@interface ZXOrder : NSObject
//待发货state-restaurant-rated，发货中:state-restaurant-3-delivering，待收货:state-restaurant-draft ，取消中,state-restaurant-cancel  ,state-restaurant-sale ,state-restaurant-1-toCertain
@property(nonatomic,strong) NSString *state;
@property(nonatomic,strong) NSString *orderID;
@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSString *amount;
@property(nonatomic,strong) NSString *orderPerson;
@property(nonatomic,strong) NSString *totalPrice;
@property(nonatomic,strong) NSString *wuliuPerson;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *offerer;//供应商
@property(nonatomic,strong) NSArray *goods;

@end
