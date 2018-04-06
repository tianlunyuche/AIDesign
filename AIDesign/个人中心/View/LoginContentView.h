//
//  LoginContentView.h
//  paohon_v1_0
//
//  Created by xinying on 2017/1/4.
//  Copyright © 2017年 paohon. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginContentView : UIView

@property(nonatomic, strong)UITextField * phoneNumField;

@property(nonatomic, strong)UITextField * passwordField;

@property(nonatomic, strong)UIButton * loginBtn;

@property(nonatomic, strong)UIButton * registerBtn;

@property(nonatomic, strong)UIButton * passFindBtn;

@property(nonatomic, strong)UIView * view;

@property(nonatomic, strong) UIImageView *qqImgView;

@property(nonatomic, strong) UIImageView *wxImgView;

@property(nonatomic, strong) UIImageView *wbImgView;

@property(nonatomic, strong)UILabel * otherLabel;

@end
