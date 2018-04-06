//
//  RegisterContentView.h
//  paohon_v1_0
//
//  Created by xinying on 2017/1/4.
//  Copyright © 2017年 paohon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterContentView : UIView{
    
    UIButton * _registerBtn;
    
    UIView* backView;

}

@property(nonatomic, strong)UIView * backView;
//手机号
@property(nonatomic, strong)UITextField * phoneField;
//密码
@property(nonatomic, strong)UITextField * passwordField1;
//确认密码
@property(nonatomic, strong)UITextField * passwordField2;

@property(nonatomic, strong)UITextField * verifiCodeField;


//国家区号
@property(nonatomic, strong)UIButton * countryCodeBtn;
//验证码按钮tag：107
@property(nonatomic, strong)UIButton * getCodeBtn;

//_registerBtn: tag:108
@property(nonatomic, strong)UIButton * registerBtn;

- (instancetype)init;

@end
