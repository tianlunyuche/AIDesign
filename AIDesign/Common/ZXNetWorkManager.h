//
//  ZXNetWorkManager.h
//  AIDesign
//
//  Created by xinying on 2018/3/18.
//  Copyright © 2018年 habav. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "API.h"
#import "ZXGoodsSourceModel.h"

#define API_KEY @"CfGHkaxz5VfDbLkn8gdoKb8v"
#define SECRET_KEY @"dGqy8gG8iLGayjvbsadSXAfRmg7dbDUY "
#define APP_ID @"10605504"

@interface ZXNetWorkManager : AFHTTPSessionManager

+ (instancetype) sharedInstance ;
-(void)postRongYunTokenWithParam:(NSDictionary *)param
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure ;
    
//------获取货源
-(void)getGoodSourcesWithParam:(NSDictionary *)param
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
