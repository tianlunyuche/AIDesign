//
//  ZXUserModel.m
//  paohon
//
//  Created by xinying on 2017/9/25.
//  Copyright © 2017年 habav. All rights reserved.
//

#import "ZXUserModel.h"

@implementation ZXUserModel

#pragma mark - ZXDBModel
+ (instancetype) sharedInstance
{
    static ZXUserModel *userModel;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userModel = [[self alloc] init];
    });
    return userModel;
}

+(NSString *)getPrimaryKey{
    return @"uid";
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.portrait forKey:@"portrait"];
    [aCoder encodeObject:self.compellation forKey:@"compellation"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.qq forKey:@"qq"];
    [aCoder encodeInteger:self.active forKey:@"active"];
    [aCoder encodeInteger:self.money forKey:@"money"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeObject:self.portraitImage forKey:@"portraitImage"];
    [aCoder encodeInteger:self.isOld forKey:@"isOld"];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.portrait = [aDecoder decodeObjectForKey:@"portrait"];
        self.compellation = [aDecoder decodeObjectForKey:@"compellation"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.qq = [aDecoder decodeObjectForKey:@"qq"];
        self.active = [aDecoder decodeIntegerForKey:@"active"];
        self.money = [aDecoder decodeIntegerForKey:@"money"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.portraitImage = [aDecoder decodeObjectForKey:@"portraitImage"];
        self.isOld = [aDecoder decodeIntegerForKey:@"isOld"];
    }
    return self;
}


@end

