//
//  ZXSexView.m
//  paohon
//
//  Created by xinying on 2017/4/15.
//  Copyright © 2017年 habav. All rights reserved.
//

#import "ZXSexView.h"
#import "ZXSexChoice.h"

@implementation ZXSexView



- (void)creatSexViewwithSex:(NSString *)label btnImage:(NSString *)btnImage SexImage:(NSString *)sexImg{

    //左侧 圆图
    _Circle =kImgV(btnImage);
    [self addSubview:_Circle];
    [_Circle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.centerY.equalTo(self.mas_centerY);
        make.size.equalTo(@(20));
    }];

    //标签
    _sexlabel =[[UILabel alloc] init];
    _sexlabel.text=label;
    [self addSubview:_sexlabel];
    [_sexlabel setFont:[UIFont systemFontOfSize:20.0]];
    [_sexlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    //性别图标
    _Pic =kImgV(sexImg);
    [self addSubview:_Pic];
    [_Pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sexlabel.mas_right).offset(10);
        make.centerY.equalTo(self.mas_centerY);
        make.size.equalTo(@(20));
    }];
}


@end
