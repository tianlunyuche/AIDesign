//
//  ZXUserModel.h
//  paohon
//
//  Created by xinying on 2017/9/25.
//  Copyright © 2017年 habav. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ZXUserModelSingle [ZXUserModel sharedInstance]

@interface ZXUserModel : NSObject <NSCopying>
//"user": {
//    　"uid": "用户ID ",
//    "nickname": "昵称",
//    　"headPortrait": "头像url ",
//    "sex": 0,
//    "icon": "等级icon ",
//    　"blogPic": "微博背景",
//    　"autograph": "个性签名",
//    　"seat": "所在地",
//    　"synopsis": "简介",
//    　"level": 1,
//    　"concern": 0,
//    　"fan": 0,
//    　"createTime":"2016-07-08 16:25:29"
//},
@property (nonatomic, strong)  NSString *uid;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong)  NSString *portrait;
@property (nonatomic, strong)  NSString *compellation;
@property (nonatomic, strong)  NSNumber *sex;
@property (nonatomic, strong)  NSString *birthday;
@property (nonatomic, strong)  NSString *email;
@property (nonatomic, strong)  NSString *qq;
@property (nonatomic, assign)  NSInteger active;
@property (nonatomic, assign)  NSInteger money;
@property (nonatomic, strong)  NSString *token;
@property (nonatomic, strong)  NSString *createTime;

@property (nonatomic, strong)  UIImage *portraitImage;

@property (nonatomic, assign)  NSInteger isOld;

//@property (nonatomic, strong) NSString *mobile;
//@property (nonatomic, strong)  NSString *compellation;
//@property (nonatomic, strong)  NSString *height;
//@property (nonatomic, strong)  NSString *weight;
//@property (nonatomic, strong)  NSNumber *birthday;
//@property (nonatomic, strong)  NSString *email;
//@property (nonatomic, strong)  NSString *qq;
//@property (nonatomic, strong)  NSString *address;
//@property (nonatomic, assign)  NSInteger longitude;
//@property (nonatomic, assign)  NSInteger latitude;
//@property (nonatomic, assign)  NSInteger rank;
//
//@property (nonatomic, strong)  NSNumber *active;
//@property (nonatomic, strong)  NSNumber *money;
//@property (nonatomic, strong)  NSNumber *coin;
//@property (nonatomic, strong)  NSNumber *point;
//@property (nonatomic, strong)  NSNumber *step;
//@property (nonatomic, strong)  NSNumber *charge;
//@property (nonatomic, strong)  NSNumber *dynamic;
//@property (nonatomic, strong)  NSString *headPortrait;
//@property (nonatomic, strong)  NSSet<ZXStatus *> *user;

+ (instancetype) sharedInstance;

@end

