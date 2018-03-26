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
