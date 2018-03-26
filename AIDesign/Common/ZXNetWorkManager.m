//
//  ZXNetWorkManager.m
//  AIDesign
//
//  Created by xinying on 2018/3/18.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXNetWorkManager.h"
#import "YYKit.h"

#define kbaseURl @"http://app.paohon.com/"
#define salt @"0920303251babe89911ecead17febf30"
#define GoodsUrl @"https://h5api.m.1688.com/h5/mtop.ali.smartui.getcomponentdata/1.0/?jsv=2.4.1&appKey=12574478&t=1521985102384&sign=865f88f61fdbd4ce4bc1344a3e281d35&api=mtop.ali.smartui.getComponentData&v=1.0&type=jsonp&timeout=20000&dataType=jsonp&callback=mtopjsonp1&data=%7B%22componentParams%22%3A%22%5B%7B%5C%22componentId%5C%22%3A%5C%2264743%5C%22%2C%5C%22pageId%5C%22%3A1848%2C%5C%22sortType%5C%22%3A%5C%22%E6%96%99%E7%90%86%E5%8C%85%5C%22%2C%5C%22pageSize%5C%22%3A50%2C%5C%22curPage%5C%22%3A1%7D%5D%22%2C%22aliETag%22%3A%22%22%2C%22isGray%22%3Afalse%2C%22param%22%3A%22%7B%5C%22url%5C%22%3A%5C%22https%3A%2F%2Fcui.m.1688.com%2Fweex%2Fvertical2_dabaihuo%2F1848.html%3Fspm%3Da262eq.8283165.2793904.3%26__positionId__%3Dvertical2_dabaihuo%26__pageId__%3D1848%26__weex__%3Dtrue%5C%22%2C%5C%22platform%5C%22%3A%5C%22wap%5C%22%7D%22%2C%22aliEtag%22%3A%22%22%7D.h"

@implementation ZXNetWorkManager

+ (instancetype) sharedInstance {
        static ZXNetWorkManager *manager;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [self manager];
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",@"image/png",@"application/x-www-form-urlencoded",nil];
            [manager.requestSerializer setValue:@"25wehl3u2s76w" forHTTPHeaderField:@"App-Key"];
            [manager.requestSerializer setValue:@"653794251" forHTTPHeaderField:@"Nonce"];
            [manager.requestSerializer setValue:@"1521385136" forHTTPHeaderField:@"Timestamp"];
            [manager.requestSerializer setValue:@"5a6b6a184f2f8098e94f05268ae609fa0e35d88e" forHTTPHeaderField:@"Signature"];
        });
        return manager;
}
//POST /user/getToken.json HTTP/1.1
//Host: api.cn.ronghub.com
//App-Key: 25wehl3u2s76w
//Nonce: 653794251
//Timestamp: 1521385136
//Signature: 5a6b6a184f2f8098e94f05268ae609fa0e35d88e
//Content-Type: application/x-www-form-urlencoded
//Content-Length: 149
//
//userId=1234567&name=%E5%B0%8F%E6%96%B0&portraitUri=https%3A%2F%2Fss0.baidu.com%2F6ONWsjip0QIZ8tyhnq%2Fit%2Fu%3D552972519%2C2902321478%26amp%3Bfm%3D58
-(void)postRongYunTokenWithParam:(NSDictionary *)param
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    [self POST:RongYunAPI parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFormData:[[param objectForKey:@"userId"] dataUsingEncoding:NSUTF8StringEncoding] name:@"userId"];
        [formData appendPartWithFormData:[[param objectForKey:@"name"] dataUsingEncoding:NSUTF8StringEncoding] name:@"name"];
        [formData appendPartWithFormData:[[param objectForKey:@"portraitUri"] dataUsingEncoding:NSUTF8StringEncoding] name:@"portraitUri"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responDic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        success(task, responDic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"");

    }];

//    [self POST:RongYunAPI parameters:@{@"userId":@"123456",@"name":@"小新",@"portraitUri":@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=552972519,2902321478&fm=58"} progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"");
//    }];
    
//    [self POST:[self giveSortStr:@{@"no":@1,@"size":@(-1),@"type":@0} urlSub:@"exchange/theme/list"] parameters:@{@"no":@1,@"size":@(-1),@"type":@0} progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *responDic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"");
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"");
//    }];
}


//------获取货源 ,goods: 调料类 ;
-(void)getGoodSourcesWithParam:(NSDictionary *)param
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    
    NSString *goodsPath = [[NSBundle mainBundle] pathForResource:[param objectForKey:@"goods"] ofType:@"json"];
    
    NSError *error;
    if (goodsPath == nil || [goodsPath isEqualToString: @""]) {
        failure(nil,error);
    }
    
    else{
        NSData *data = [NSData dataWithContentsOfFile:goodsPath];
        NSDictionary *goodsDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = [goodsDic objectForKey:@"data"];
        
        NSMutableArray *goodsMutableArr = [NSMutableArray arrayWithCapacity:1];
        for (NSArray *goodsDoubleArray in array) {
            for (NSDictionary *goodsDic in goodsDoubleArray) {
                ZXGoodsModel *goodsModel = [ZXGoodsModel modelWithDictionary:goodsDic];
                [goodsMutableArr addObject:goodsModel];
            }
        }
        if (array) {
            success(nil, goodsMutableArr);
        } else {
            failure(nil, nil);
        }
    }

}
    
#pragma mark - （reqParaDic 排序后) 返回一个post请求地址
- (NSString *)giveSortStr:(NSDictionary *)para2Dict urlSub:(NSString *)lk{
    
    //    NSLog(@"%@",signString);
    NSString* jsonString =[NSString stringWithFormat:@"{%@}%@",[self getSortString:para2Dict],salt];
    NSLog(@"jsonString =%@",jsonString);
    
    return [NSString stringWithFormat:@"%@%@?sign=%@",kbaseURl,lk,[jsonString md5String]];
}
    
-(NSString *)getSortString:(NSDictionary *)para2Dict{
    
    //得到排序好的key值
    NSArray* allKeyArray =[para2Dict allKeys];
    NSArray* SortKeyArray =[allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        //obj1 compare:obj2。升序排列
        NSComparisonResult result =[obj1 compare:obj2];
        return result;
    }];
    NSLog(@"SortKeyArray =%@",SortKeyArray);
    //由排好的key值 获取value值
    NSMutableArray* valueArray =[NSMutableArray array];
    for(NSString * sort in SortKeyArray){
        NSString* valueStr =[para2Dict objectForKey:sort];
        [valueArray addObject:valueStr];
    }
    NSLog(@"valueArray =%@",valueArray);
    //拼接
    NSMutableArray *signArray = [NSMutableArray array];
    NSString *keyValue;
    for (int i = 0 ; i < SortKeyArray.count; i++) {
        if ([valueArray[i] isKindOfClass:[NSString class]]) {
            keyValue = [NSString stringWithFormat:@"\"%@\":\"%@\"",SortKeyArray[i],valueArray[i]];
        }else{
            keyValue = [NSString stringWithFormat:@"\"%@\":%@",SortKeyArray[i],valueArray[i]];
        }
        [signArray addObject:keyValue];
    }
    
    //signString用于签名的原始参数集合
    return [signArray componentsJoinedByString:@","];
}
    
    //返回一个post请求地址
- (NSString *)givedomainStr:(NSDictionary *)para2Dict urlSub:(NSString *)lk{
    
    NSString* paraStr3 =[self ObjectTojsonString:para2Dict];
    NSLog(@"paraStr3 =%@",paraStr3);
    NSString* parJStr2 =[NSString stringWithFormat:@"%@%@",paraStr3,salt];
    
    parJStr2 =[parJStr2 md5String];
    
    NSString*  dStr =[NSString stringWithFormat:@"%@%@?sign=%@",kbaseURl,lk,parJStr2];
    
    return dStr;
}
    
#pragma mark - dict字典 转向 字符串类型
-(NSString*)ObjectTojsonString:(NSDictionary *)object
    {
        NSString *jsonString = [[NSString alloc]init];
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        if (! jsonData) {
            NSLog(@"ObjectTojsonString error: %@", error);
        } else {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"jsonString =%@",jsonString);
        }
        NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
        NSLog(@"mutStr =%@",mutStr);
        NSRange range = {0,jsonString.length};
        [mutStr replaceOccurrencesOfString:@" "withString:@""options:NSLiteralSearch range:range];
        NSRange range2 = {0,mutStr.length};
        [mutStr replaceOccurrencesOfString:@"\n"withString:@""options:NSLiteralSearch range:range2];
        return mutStr;
    }
    

    
@end
