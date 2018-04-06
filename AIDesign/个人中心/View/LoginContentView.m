//
//  LoginContentView.m
//  paohon_v1_0
//
//  Created by xinying on 2017/1/4.
//  Copyright © 2017年 paohon. All rights reserved.
//

#import "LoginContentView.h"

@implementation LoginContentView

- (instancetype)init{
    self =[super init ];
    if(self){
        [self creatUI];
    }
    return self;
}

- (void)creatUI{

    //手机号码和密码背景颜色设置
    _view = [[UIView alloc] init];
    _view.layer.cornerRadius = 8.0;
    _view.layer.borderWidth = 1;
    _view.layer.borderColor = [UIColor colorWithRed:209.0f/255.0f green:209.0f/255.0f blue:209.0f/255.0f alpha:1.0f].CGColor;
    [_view setBackgroundColor:[UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:247.0f/255.0f alpha:1.0f]];
    [self addSubview:_view];
    
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(100));
        make.left.equalTo(self).offset(35);
        make.right.equalTo(self).offset(-35);
        make.height.equalTo(@(90));
    }];
    
    //在view中添加文本编辑框
    [_view addSubview:self.phoneNumField];
//
    [_phoneNumField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_view.mas_top);
        make.centerX.equalTo(_view.mas_centerX);
        make.height.equalTo(@(50));
    }];
    
    //邮箱与密码中间分割线
    UIView *line = [[UIView alloc] init];
    [line setBackgroundColor:klineColor];
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_view.mas_centerY);
        make.left.equalTo(self).offset(35);
        make.right.equalTo(self).offset(-35);
        make.height.equalTo(@(1));
    }];
    
    //在view中添加文本编辑框
    _passwordField = [[UITextField alloc] init];
    //    [phoneNumField setBackgroundColor:[UIColor clearColor]];
    [_passwordField setKeyboardType:UIKeyboardTypeDefault];
    //    [phoneNumField setTextColor:[UIColor blackColor]];
    //[_email setClearButtonMode:UITextFieldViewModeWhileEditing];  //编辑时会出现个修改X
    [_passwordField setTag:102];
    [_passwordField setReturnKeyType:UIReturnKeyNext];  //键盘下一步Next
    [_passwordField setAutocapitalizationType:UITextAutocapitalizationTypeNone]; //关闭首字母大写
    //    [phoneNumField setAutocorrectionType:UITextAutocorrectionTypeNo];
    //    [phoneNumField becomeFirstResponder]; //默认打开键盘
    //    [phoneNumField setFont:[UIFont systemFontOfSize:17]];
    ////    [phoneNumField setDelegate:self];
    [_passwordField setPlaceholder:@"请输入密码"];
    _passwordField.secureTextEntry =YES;
    //    [phoneNumField setText:@""];
    //    [phoneNumField setHighlighted:YES];
    UIButton *iconBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [iconBtn setImage: [UIImage imageNamed:@"c"] forState:UIControlStateNormal];
    [iconBtn setImage: [UIImage imageNamed:@"o"] forState:UIControlStateSelected];
    iconBtn.frame = CGRectMake(0, 0, 50, 50);
    @weakify(iconBtn)
    [iconBtn setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @strongify(iconBtn)
        iconBtn.selected = !iconBtn.selected;
        _passwordField.secureTextEntry =!_passwordField.secureTextEntry;
    }];
    _passwordField.leftViewMode = UITextFieldViewModeAlways;
    _passwordField.leftView = iconBtn;
    _passwordField.textAlignment = NSTextAlignmentCenter;
    _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_view addSubview:_passwordField];
    //
    [_passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.left.mas_equalTo(_view);
        make.right.mas_equalTo(_view).offset(-50);
//        make.centerX.equalTo(_view.mas_centerX);
        make.height.equalTo(@(50));
    }];
    
    //添加登录按钮
    [self addSubview:self.loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_view.mas_bottom).offset(28);
        make.left.equalTo(self).offset(35);
        make.right.equalTo(self).offset(-35);
        make.height.equalTo(@(40));
    }];
    
    //添加注册按钮
    [self addSubview:self.registerBtn];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginBtn.mas_bottom).offset(20);
        make.left.equalTo(self).offset(35);
//        make.right.equalTo(_loginBtn.mas_centerX).offset(-60);
        make.height.equalTo(@(40));
    }];
    
    //添加 忘记密码 按钮
    [self addSubview:self.passFindBtn];
    [_passFindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginBtn.mas_bottom).offset(20);
//        make.left.equalTo(self).offset();
        make.right.equalTo(self).offset(-35);
        make.height.equalTo(@(40));
    }];
    

    
    //添加圆角标签（其他登录方式）
    [self addSubview:self.otherLabel];
    [_otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginBtn.mas_bottom).offset(80);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(@(24));
    }];

    //标签两侧的线
    UIView *line3 = [[UIView alloc] init];
    [line3 setBackgroundColor:klineColor];
    [self addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_otherLabel.mas_centerY);
        make.left.equalTo(self);
        make.right.equalTo(_otherLabel.mas_left);
        make.height.equalTo(@(1));
    }];
    UIView *line4 = [[UIView alloc] init];
    [line4 setBackgroundColor:klineColor];
    [self addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_otherLabel.mas_centerY);
        make.left.equalTo(_otherLabel.mas_right);
        make.right.equalTo(self);
        make.height.equalTo(@(1));
    }];
    
    //创建第三方登录部分
    _wxImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    _wxImgView.tag =110;
    //添加 单击手势 触发事件 ,handleSingleTap
    _wxImgView.image =[UIImage imageNamed:@"wx"];

    [self addSubview:_wxImgView];
    [_wxImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_otherLabel.mas_bottom).offset(48);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    _qqImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    _qqImgView.tag =111;
    //添加 单击手势 触发事件 ,handleSingleTap
    _qqImgView.image =[UIImage imageNamed:@"qq"];

   
    [self addSubview:_qqImgView];
    [_qqImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_wxImgView.mas_top);
        make.left.equalTo(_wxImgView.mas_left).offset(-80);
    }];
    
    _wbImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    _wbImgView.tag =112;
    //添加 单击手势 触发事件 ,handleSingleTap
    _wbImgView.image =[UIImage imageNamed:@"wb"];
    

    [self addSubview:_wbImgView];
    [_wbImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_wxImgView.mas_top);
        make.right.equalTo(_wxImgView.mas_right).offset(80);
    }];

}


- (UILabel *)otherLabel{
    //添加圆角标签（其他登录方式）
    _otherLabel =[[UILabel alloc] init];
    [_otherLabel setText:@"  其他登录方式  "];
    _otherLabel.textColor =[UIColor grayColor];
    _otherLabel.font =[UIFont systemFontOfSize:13];
    _otherLabel.layer.borderColor =[UIColor colorWithRed:103.0f/255.0f green:136.0f/255.0f blue:220.0f/255.0f alpha:1].CGColor;
    _otherLabel.layer.cornerRadius =5;
    _otherLabel.layer.borderWidth=2.0f;
    
    return _otherLabel;
}



- (void)_judgeinput:(UITextField *)sender {
    if (_passwordField.text.length >= 8) {
        _loginBtn.enabled = YES;
    } else {
        _loginBtn.enabled = NO;
    }
}

#pragma mark - lazy load
- (UITextField *)phoneNumField {
    
    if (!_phoneNumField) {
        _phoneNumField = [[UITextField alloc] init];
        [_phoneNumField setKeyboardType:UIKeyboardTypePhonePad];
        _phoneNumField.clearButtonMode = UITextFieldViewModeWhileEditing;
        //    [phoneNumField setClearButtonMode:UITextFieldViewModeWhileEditing];  //编辑时会出现个修改X
        [_phoneNumField setTag:101];
//        [_phoneNumField setReturnKeyType:UIReturnKeyNext];  //键盘下一步Next
        //    [phoneNumField setAutocorrectionType:UITextAutocorrectionTypeNo];
        _phoneNumField.placeholder = @"请填写手机号码";
        _phoneNumField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _phoneNumField.autoresizingMask=UIViewAutoresizingFlexibleWidth;
//        [_phoneNumField addTarget:self action:@selector(_judgement:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneNumField;
}

- (UITextField *)passwordField {
    if (!_passwordField) {
        _passwordField = [[UITextField alloc]init];
        _passwordField.rightViewMode = UITextFieldViewModeWhileEditing;
        _passwordField.placeholder = @"请填写密码";
        _passwordField.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        [_passwordField addTarget:self action:@selector(_judgeinput:) forControlEvents:UIControlEventEditingChanged];
        _passwordField.secureTextEntry = YES;
    }
    return _passwordField;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"bg_bar"] forState:UIControlStateNormal];
        // 设置圆角
        _loginBtn.layer.cornerRadius = 10.0;
        
        [_loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        
        _loginBtn.layer.cornerRadius = 10;
        _loginBtn.layer.shadowOffset =  CGSizeMake(1, 1);
        _loginBtn.layer.shadowOpacity = 0.8;
        _loginBtn.layer.shadowColor =  [UIColor blackColor].CGColor;
//        [_loginBtn setBackgroundImage:[BASE_COLOR wzx_toImage] forState:UIControlStateNormal];
//        [_loginBtn setBackgroundImage:[[UIColor colorWithRed:104/255.0 green:187/255.0 blue:30/255.0 alpha:0.5] wzx_toImage] forState:UIControlStateDisabled];
//        _loginBtn.enabled = NO;
    }
    return _loginBtn;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerBtn.backgroundColor =[UIColor clearColor];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _registerBtn;
}

- (UIButton *)passFindBtn{
    if (!_passFindBtn) {
        _passFindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _passFindBtn.backgroundColor =[UIColor clearColor];
        [_passFindBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_passFindBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _passFindBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _passFindBtn;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_phoneNumField resignFirstResponder ];
    [_passwordField resignFirstResponder];
}

@end
