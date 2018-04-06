//
//  RegisterContentView.m
//  paohon_v1_0
//
//  Created by xinying on 2017/1/4.
//  Copyright © 2017年 paohon. All rights reserved.
//

#import "RegisterContentView.h"



@implementation RegisterContentView

@synthesize backView=_backView;


- (instancetype)init{
    self =[super init ];
    if(self){
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    
    //手机号码和密码背景颜色设置

    _backView = [[UIView alloc] init];
    _backView.layer.cornerRadius = 8.0;
    _backView.layer.borderWidth = 1;
    _backView.layer.borderColor = [UIColor whiteColor].CGColor;
    _backView.backgroundColor=[UIColor whiteColor];
    [self addSubview:_backView];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(50));
        make.left.equalTo(self.mas_left).offset(35);
        make.right.equalTo(self.mas_right).offset(-35);
        make.height.equalTo(@(200));
    }];

    //添加选择国家区号 按钮
    [_backView addSubview:self.countryCodeBtn];
    [_countryCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top).offset(8);
        make.left.equalTo(_backView.mas_left).offset(-15);
        make.right.equalTo(_backView.mas_left).offset(100);
        make.height.equalTo(@(40));
    }];

    //在view中添加文本编辑框
    _phoneField = [[UITextField alloc] init];
//    [_phoneField setKeyboardType:UIKeyboardTypePhonePad];
    [_phoneField setTag:103];
    _phoneField.keyboardType = UIKeyboardTypeNumberPad;
    [_phoneField setPlaceholder:@"请输入手机号码"];
    _phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneField.font =[UIFont systemFontOfSize:16];
    [_backView addSubview:_phoneField];
    [_phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top).offset(8);
        make.left.equalTo(_countryCodeBtn.mas_right);
        make.right.equalTo(_backView.mas_right);
        make.height.equalTo(@(40));
    }];
    
    //中间分割线
    UIView *line = [[UIView alloc] init];
    [line setBackgroundColor:klineColor];
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneField.mas_bottom).offset(4); //能否显示出来，跟偏移量有关
        make.left.equalTo(_backView.mas_left);
        make.right.equalTo(_backView.mas_right);
        make.height.equalTo(@(1));
    }];
    
    //在view中添加文本编辑框
    _passwordField1 = [[UITextField alloc] init];
    [_passwordField1 setKeyboardType:UIKeyboardTypeDefault];
    [_passwordField1 setTag:104];
    [_passwordField1 setReturnKeyType:UIReturnKeyNext];
    [_passwordField1 setAutocapitalizationType:UITextAutocapitalizationTypeNone]; //关闭首字母大写
    [_passwordField1 setPlaceholder:@"输入8位以上密码"];
    _passwordField1.secureTextEntry =YES;
    
    UIButton *iconBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    iconBtn.frame = CGRectMake(0, 0, 30, 30);
    [iconBtn setImage: [UIImage imageNamed:@"c"] forState:UIControlStateNormal];
    [iconBtn setImage: [UIImage imageNamed:@"o"] forState:UIControlStateSelected];
    @weakify(iconBtn)
    [iconBtn setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @strongify(iconBtn)
        iconBtn.selected = !iconBtn.selected;
        _passwordField1.secureTextEntry =!_passwordField1.secureTextEntry;
    }];
    _passwordField1.leftViewMode = UITextFieldViewModeAlways;
    _passwordField1.leftView = iconBtn;
    _passwordField1.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [_backView addSubview:_passwordField1];
    //
    [_passwordField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(6);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.equalTo(@(40));
    }];
   
    //中间分割线
    UIView *line2 = [[UIView alloc] init];
    [line2 setBackgroundColor:klineColor];
    [self addSubview:line2];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordField1.mas_bottom).offset(4);
        make.left.equalTo(_backView.mas_left);
        make.right.equalTo(_backView.mas_right);
        make.height.equalTo(@(1));
    }];
 
    //在view中添加文本编辑框
    _passwordField2 = [[UITextField alloc] init];
    [_passwordField2 setKeyboardType:UIKeyboardTypeDefault];
    [_passwordField2 setTag:105];
    [_passwordField2 setReturnKeyType:UIReturnKeyNext];
    [_passwordField2 setAutocapitalizationType:UITextAutocapitalizationTypeNone]; //关闭首字母大写
    [_passwordField2 setPlaceholder:@"两个密码应该一致"];
    _passwordField2.secureTextEntry =YES;
    _passwordField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIButton *iconBtn2 =[UIButton buttonWithType:UIButtonTypeCustom];
    iconBtn2.frame = CGRectMake(0, 0, 30, 30);
    [iconBtn2 setImage: [UIImage imageNamed:@"c"] forState:UIControlStateNormal];
    [iconBtn2 setImage: [UIImage imageNamed:@"o"] forState:UIControlStateSelected];
    @weakify(iconBtn2)
    [iconBtn2 setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @strongify(iconBtn2)
        iconBtn2.selected = !iconBtn2.selected;
        _passwordField2.secureTextEntry =!_passwordField2.secureTextEntry;
    }];
    _passwordField2.leftViewMode = UITextFieldViewModeAlways;
    _passwordField2.leftView = iconBtn2;
    
    [_backView addSubview:_passwordField2];
    //
    [_passwordField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(6);
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.height.equalTo(@(40));
    }];

    //中间分割线
    UIView *line3 = [[UIView alloc] init];
    [line3 setBackgroundColor:klineColor];
    [self addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordField2.mas_bottom).offset(2);
        make.left.equalTo(_backView.mas_left);
        make.right.equalTo(_backView.mas_right);
        make.height.equalTo(@(1));
    }];
    
    //验证码编辑框
    _verifiCodeField = [[UITextField alloc] init];
    [_verifiCodeField setTag:106];
    _verifiCodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_verifiCodeField setPlaceholder:@"请输入验证码"];
    _verifiCodeField.font =[UIFont systemFontOfSize:16];
    [_backView addSubview:_verifiCodeField];
    //
    [_verifiCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom).offset(4);
        make.left.equalTo(_backView.mas_left).offset(30);
        make.right.equalTo(_backView.mas_centerX).offset(20);
        make.height.equalTo(@(50));
    }];

    //添加 获取手机验证码 按钮
    [_backView addSubview:self.getCodeBtn];
    [_getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom).offset(4);
        make.left.equalTo(_verifiCodeField.mas_right);
        make.right.equalTo(_backView.mas_right);
        make.height.equalTo(@(50));
    }];

    //中间分割线
    UIView *line4 = [[UIView alloc] init];
    [line4 setBackgroundColor:[UIColor colorWithRed:236.0f/255.0f green:236.0f/255.0f blue:236.0f/255.0f alpha:1.0f]];
    [self addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom);
        make.left.equalTo(_verifiCodeField.mas_right).offset(2);
        make.width.equalTo(@(1));
        make.bottom.equalTo(_backView.mas_bottom);
    }];
    
    //中间分割线 (第一条竖蓝色)
    UIView *line5 = [[UIView alloc] init];
    [line5 setBackgroundColor:klineColor];
    [self addSubview:line5];
    [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top).offset(40);
        make.left.equalTo(_backView.mas_left).offset(90);
        make.width.equalTo(@(1));
        make.bottom.equalTo(line.mas_top);
    }];
    
    //注册按钮 创建和添加
    [self addSubview:self.registerBtnCreat];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_bottom).offset(50);
        make.left.mas_equalTo(_backView.mas_left);
        make.right.mas_equalTo(_backView.mas_right);
        make.height.equalTo(@(50));
    }];
   
}

- (void)_judgement:(UITextField *)sender {
//    if ((_passwordField1.text.length >8 ) && [_passwordField1.text isEqualToString:_passwordField2.text]) {
//        _registerBtn.enabled = YES;
//    }else {
//        _registerBtn.enabled = NO;
//    }
}

#pragma mark - lazy load懒加载
- (UITextField *)phoneField {
    if (!_phoneField) {
        _phoneField = [[UITextField alloc]init];
        _phoneField.placeholder = @"请输入合法的手机号码";
        [_phoneField addTarget:self action:@selector(_judgement:) forControlEvents:UIControlEventEditingChanged];
    }
    return _phoneField;
}

- (UITextField *)passwordField1 {
    if (!_passwordField1) {
        _passwordField1 = [[UITextField alloc]init];
        _passwordField1.placeholder = @"输入8位以上密码";
        [_passwordField1 addTarget:self action:@selector(_judgement:) forControlEvents:UIControlEventEditingChanged];
        _passwordField1.secureTextEntry = YES;
    }
    return _passwordField1;
}


- (UIButton *)countryCodeBtn {
    if (!_countryCodeBtn) {
        _countryCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_countryCodeBtn setTitle:@"选择国家" forState:UIControlStateNormal];
        [_countryCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
         _countryCodeBtn.titleLabel.font =[UIFont systemFontOfSize:16];
    }
    
    return _countryCodeBtn;
}


- (UIButton *)getCodeBtn {
    if (!_getCodeBtn) {
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        //验证码按钮tag：107
        _getCodeBtn.tag =107;
        // 按钮边框宽度
        //        _registerBtn.layer.borderWidth = 1;
    }
    return _getCodeBtn;
}

#pragma mark - 注册按钮

- (UIButton *)registerBtnCreat {
    if (!_registerBtn) {
        _registerBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        //_registerBtn: tag:108
        _registerBtn.tag =108;
        [_registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _registerBtn.titleLabel.font =[UIFont fontWithName:@"ArialMT"size:20];
        // 按钮边框宽度
        //        _registerBtn.layer.borderWidth = 1;
        // 按钮边框宽度
        _registerBtn.layer.borderWidth = 1.5;
        // 设置圆角
        _registerBtn.layer.cornerRadius = 10.0;

        // 设置边框颜色
        _registerBtn.layer.borderColor =klineColor.CGColor;
        _registerBtn.backgroundColor =kbackgdColor;
    }
    return _registerBtn;
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //回收键盘对象
    [_phoneField resignFirstResponder];
    [_passwordField1 resignFirstResponder];
    [_passwordField2 resignFirstResponder];
    [_verifiCodeField resignFirstResponder];
}

@end
