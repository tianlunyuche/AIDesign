//
//  ZXOrders.m
//  AIDesign
//
//  Created by xinying on 2018/5/9.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXOrders.h"

@implementation ZXOrders

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.order forKey:@"order"];

}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.userID = [aDecoder decodeObjectForKey:@"userID"];
        self.order = [aDecoder decodeObjectForKey:@"order"];

    }
    return self;
}

@end


@implementation ZXOrder

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.state forKey:@"state"];
    [aCoder encodeObject:self.orderID forKey:@"orderID"];
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeObject:self.amount forKey:@"amount"];
    [aCoder encodeObject:self.orderPerson forKey:@"orderPerson"];
    [aCoder encodeObject:self.totalPrice forKey:@"totalPrice"];
    [aCoder encodeObject:self.wuliuPerson forKey:@"wuliuPerson"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.offerer forKey:@"offerer"];
    [aCoder encodeObject:self.goods forKey:@"goods"];
    
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.state = [aDecoder decodeObjectForKey:@"state"];
        self.orderID = [aDecoder decodeObjectForKey:@"orderID"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.amount = [aDecoder decodeObjectForKey:@"amount"];
        self.orderPerson = [aDecoder decodeObjectForKey:@"orderPerson"];
        self.totalPrice = [aDecoder decodeObjectForKey:@"totalPrice"];
        self.wuliuPerson = [aDecoder decodeObjectForKey:@"wuliuPerson"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.offerer = [aDecoder decodeObjectForKey:@"offerer"];
        self.goods = [aDecoder decodeObjectForKey:@"goods"];
    }
    return self;
}


@end
