//
//  TipView.m
//  paohon_v1_0
//
//  Created by xinying on 2017/1/17.
//  Copyright © 2017年 paohon. All rights reserved.
//

#import "TipView.h"

@implementation TipView

- (instancetype)init{
    self =[super init ];
    if(self){
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
//    _vw =[[UIView alloc] init];
//    self.backgroundColor =[UIColor colorWithRed:253.0f /255 green:187.0f /255 blue:36.0f /255 alpha:0.3];
    self.backgroundColor =[UIColor blackColor];
    self.alpha =0.5;
//    [self addSubview:_vw];
    self.layer.cornerRadius=8.0f;
    
    //提示图片
    _tipImageView = [[UIImageView alloc] init];
    _tipImageView.image = [UIImage imageNamed:@"order_btn_reduce"];
    [self addSubview:_tipImageView];
    [_tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(2);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    //内容标签
    _tipLabel = [[UILabel alloc] init];
    _tipLabel.textColor=[UIColor whiteColor];
    _tipLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tipImageView.mas_centerX).offset(30);
        make.centerY.equalTo(self.mas_centerY);
    }];

}

@end
