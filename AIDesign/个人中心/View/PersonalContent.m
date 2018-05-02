//
//  PersonalContent.m
//  paohon_v1_0
//
//  Created by xinying on 2017/1/19.
//  Copyright © 2017年 paohon. All rights reserved.
//

#import "PersonalContent.h"
#import "ZXSexChoice.h"
#import "ZXPhoto.h"

#define Height 305

@interface PersonalContent ()


@end

@implementation PersonalContent{
    int i;
}

- (instancetype)init{
    self =[super init ];
    if(self){
        self.backgroundColor = kbackgdColor;
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    //头像
    [self addSubview:self.avatarImgView];
    [self.avatarImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(40);
        make.left.equalTo(self.mas_left).offset(kScreenWidth/2 - 50);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    //    //添加 单击手势 触发事件
    self.avatarImgView.userInteractionEnabled = YES;
    _singleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Notificate:)];
    [self.avatarImgView addGestureRecognizer:_singleTap];

    
    //左侧标签
    NSArray*  attre =[[NSArray alloc] initWithObjects:@"昵称：",@"真实姓名：",@"性别：",@"生日：",@"QQ：",@"邮箱：",@"手机号：", nil];
    for (i =0; i<7 ;i++){
        
        [self addSubview:self.infolabel];
        _infolabel.text =[attre objectAtIndex:i];
        [_infolabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(160+50*i);
            make.left.equalTo(self.mas_left).offset(15);
        }];
        
        //横线
        [self addSubview:self.Imgview];
        [_Imgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_infolabel.mas_bottom).offset(2);
            make.left.mas_equalTo(_infolabel.mas_left);
            make.width.mas_equalTo(kScreenWidth - 30);
            make.height.mas_equalTo(1);
        }];
    }
    
    _usern = [[UITextField alloc] init];
    _usern.placeholder =@"昵称";
    [self addSubview:_usern];
    [_usern mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(160);
        make.left.equalTo(self.mas_left).offset(110);
        make.width.mas_equalTo(kScreenWidth - 110 -30);
    }];
    
    _trueName = [[UITextField alloc] init];
    _trueName.placeholder =@"姓名";
    [self addSubview:_trueName];
    [_trueName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(110);
        make.width.mas_equalTo(kScreenWidth - 110 -30);
        make.top.equalTo(self.mas_top).offset(208);
    }];

    [self addSubview:self.manView];
    [self.manView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(100);
        make.right.equalTo(self.mas_left).offset(180);
        make.top.equalTo(self.mas_top).offset(240);
        make.height.equalTo(@(50));
    }];

    self.manView.userInteractionEnabled =YES;
    _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Notificate:)];
    [self.manView addGestureRecognizer:_singleTap];

    
    //女性图层
    [self addSubview:self.womanView];
    [self.womanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_manView.mas_right).offset(40);
        make.right.equalTo(_manView.mas_right).offset(140);
        make.top.equalTo(self.mas_top).offset(240);
        make.height.equalTo(@(50));
    }];

    self.womanView.userInteractionEnabled =YES;
    _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Notificate:)];
    [_womanView addGestureRecognizer:_singleTap];

    //生日标签
    [self addSubview:self.birthlabel];
    [self.birthlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(Height);
            make.left.equalTo(self.mas_left).offset(110);
    }];
    //生日视图可交互
    self.birthlabel.userInteractionEnabled = YES;
    _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Notificate:)];
    [self.birthlabel addGestureRecognizer:_singleTap];
    

    //QQ
    _qqfld = [[UITextField alloc] init];
    _qqfld.placeholder = @"请输入您的QQ";
    [self addSubview:_qqfld];
    [_qqfld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(350);
        make.left.equalTo(self.mas_left).offset(100);
        make.width.mas_equalTo(kScreenWidth - 110 -30);
    }];

    //邮箱
    _mailfld = [[UITextField alloc] init];
    _mailfld.placeholder = @"请输入您的邮箱";
    [self addSubview:_mailfld];
    [_mailfld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(403);
        make.left.equalTo(self.mas_left).offset(100);
        make.width.mas_equalTo(kScreenWidth - 110 -30);
    }];

//    手机号码 部分
    _pholabel =[[UILabel alloc] init];
    _pholabel.text =@"18888888888";
    [_pholabel setFont:[UIFont systemFontOfSize:18.0]];
    [self addSubview:_pholabel];
    [_pholabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(453);
        make.left.equalTo(self.mas_left).offset(100);
        make.right.equalTo(self.mas_left).offset(300);
    }];
    
//    提交按键
    [self addSubview:self.postBtn];
    [self.postBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pholabel.mas_bottom).offset(30);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@(30));
    }];
}


#pragma mark - 选择Sex
- (void)Sexselected:(int)sex{
    if (sex ==0) {
        NSLog(@"0");
        [self.manChoice manSelected];
        [self.womanChoice womanDiselected];
    }else{
        NSLog(@"1");
        [self.manChoice manDiselected];
        [self.womanChoice womanSelected];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.manView.Circle.image =[UIImage imageNamed:self.manChoice.btnImage];
        self.manView.Pic.image =[UIImage imageNamed:self.manChoice.sexImg];
        self.womanView.Circle.image =[UIImage imageNamed:self.womanChoice.btnImage];
        self.womanView.Pic.image =[UIImage imageNamed:self.womanChoice.sexImg];
    });
}

#pragma mark - 点击 头像 ,sex 通知
- (void)Notificate:(UITapGestureRecognizer *)tap{

    //发送通知 ,异步发送通知, 主线程监听通知
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"manNotificate =%@",[NSThread currentThread]);
        
        if (tap.view.tag ==110) {
            [kNotificationCenter postNotificationName:@"takePicture" object:nil];
        }else
            if (tap.view.tag ==111) {
                [kNotificationCenter postNotificationName:@"manNotificate" object:nil];
            }else
                if (tap.view.tag ==112) {
                    [kNotificationCenter postNotificationName:@"womanNotificate" object:nil];
                }else
                    if (tap.view.tag ==113) {
                        NSLog(@"113");
                        [kNotificationCenter postNotificationName:@"birthNotificate" object:nil];
                    }
    });
}

/**
 返回取消渲染的image
 **/
- (UIImage *)removeRending:(NSString *)imageName{
    UIImage* image =[UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

#pragma mark - lazy load懒加载
- (UIImageView *)avatarImgView{
    
    if (!_avatarImgView) {
        
        _avatarImgView = [[UIImageView alloc] init];
//        _avatarImgView.image =[UIImage circleImageWithLocalName:@"selfPhoto.png" borderWidth:0];
        _avatarImgView.image =[UIImage imageNamed:@"allocation_btn_add"];
        _avatarImgView.tag =110;
    }
    return _avatarImgView;
}

//左侧标签
- (UILabel *)infolabel{
    _infolabel =[[UILabel alloc] init];
    _infolabel.tintColor =[UIColor grayColor];
    return _infolabel;
}

- (UIImageView *)Imgview{
    
    _Imgview=[[UIImageView alloc] init];
    _Imgview.image =[UIImage imageWithColor:[UIColor grayColor]];
    
    return _Imgview;
}

- (UIView *)birthlabel{
    
    if (!_birthlabel) {
//        _birthView =[[UIView alloc] init];
//        _birthView.backgroundColor=[UIColor redColor];
        _birthlabel =[[UILabel alloc] init];
        _birthlabel.text = @"1996-05-24";
        [_birthlabel setFont:[UIFont systemFontOfSize:18.0]];
        _birthlabel.textAlignment =NSTextAlignmentCenter;
        _birthlabel.tag =113;
        
    }
    return _birthlabel;
}

- (UIButton *)postBtn{
    
    if (!_postBtn) {
        
        _postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _postBtn.backgroundColor =[UIColor clearColor];
        _postBtn.layer.borderWidth = 1.5;
        _postBtn.layer.borderColor =klineColor.CGColor;
        // 设置圆角
        _postBtn.layer.cornerRadius = 10.0;
        
        [_postBtn setTitle:@"     提   交      " forState:UIControlStateNormal];
        [_postBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _postBtn.titleLabel.font = [UIFont systemFontOfSize:15];

    }
    return _postBtn;
}

#pragma mark - Sex 懒加载
- (ZXSexChoice *)manChoice{
    
    if (!_manChoice) {
        _manChoice =[ZXSexChoice sharedman];
    }
    return _manChoice;
}


- (ZXSexChoice *)womanChoice{
    
    if (!_womanChoice) {
        _womanChoice =[ZXSexChoice sharedman];
    }
    return _womanChoice;
}

- (ZXSexView *)manView{
    
    if (!_manView) {
        
        _manView =[[ZXSexView alloc] init];
        [_manView creatSexViewwithSex:self.manChoice.label btnImage:self.manChoice.btnImage SexImage:self.manChoice.sexImg];
        _manView.tag =111;
    }
    return _manView;
}

- (ZXSexView *)womanView{
    
    if (!_womanView) {
        _womanChoice =[ZXSexChoice sharedwoman];
        _womanView =[[ZXSexView alloc] init];
        [_womanView creatSexViewwithSex:self.womanChoice.label btnImage:self.womanChoice.btnImage SexImage:self.womanChoice.sexImg];
        _womanView.tag =112;
    }
    return _womanView;
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //回收键盘对象
    [_usern resignFirstResponder];
    [_trueName resignFirstResponder];
    [_weighfld resignFirstResponder];
    [_heighfld resignFirstResponder];
    [_qqfld resignFirstResponder];
    [_mailfld resignFirstResponder];
    
}


@end
