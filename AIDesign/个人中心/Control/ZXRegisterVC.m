//
//  ZXRegisterVC.m
//  AIDesign
//
//  Created by xinying on 2018/3/29.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXRegisterVC.h"


@interface ZXRegisterVC (){
    //定义一个任务队列对象
    NSOperationQueue* _queue;
    
    NSInvocationOperation* iop;
    
    NSInteger count;
    //验证码倒数时间
    NSTimer* _timer1;
    NSTimer* _timer2;
    NSTimer* _timer3;
    NSTimer* timer;
    //国家区号
    NSString* zoneCSubStr;
}


@end


static int cnt = 0;

@implementation ZXRegisterVC
@synthesize timer= _timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.title =@"注 册";
    self.view.backgroundColor = kbackgdColor;
    _contentView = [[RegisterContentView alloc] init];
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.left.right.bottom.mas_equalTo(0);
    }];
    [_contentView.countryCodeBtn addTarget:self action:@selector(countryCode) forControlEvents:UIControlEventTouchUpInside];
    
    //添加触发事件
    [_contentView.registerBtn addTarget:self action:@selector(RegisterBtn) forControlEvents:UIControlEventTouchUpInside];
    //获取验证码
    [_contentView.getCodeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
}

//国家区号
- (void)countryCode{
    
    ZXCountryCodeVC *CountryCodeVC = [[ZXCountryCodeVC alloc] init];
    CountryCodeVC.delegate = self;
    
    //block
    [CountryCodeVC toReturnCountryCode:^(NSString *countryCodeStr) {
        NSRange range = [countryCodeStr rangeOfString:@"+"]; //现获取要截取的字符串位置
        NSString * couCodeSubStr = [countryCodeStr substringFromIndex:range.location]; //截取字符串
        [_contentView.countryCodeBtn setTitle:couCodeSubStr forState:UIControlStateNormal];
    }];
    
    [self presentViewController:CountryCodeVC animated:YES completion:nil];
}

//1.代理传值
#pragma mark - XWCountryCodeControllerDelegate
-(void)returnCountryCode:(NSString *)countryCode{
    NSRange range = [countryCode rangeOfString:@"+"]; //现获取要截取的字符串位置
    NSString * couCodeSubStr = [countryCode substringFromIndex:range.location]; //截取字符串
    [_contentView.countryCodeBtn setTitle:couCodeSubStr forState:UIControlStateNormal];
}

//获取国家区号
- (NSString *)getZone{
    
    NSString*  zoneC=_contentView.countryCodeBtn.titleLabel.text;
    NSRange range = [zoneC rangeOfString:@"+"]; //现获取要截取的字符串位置
    NSString* zoneCSubSt = [zoneC substringFromIndex:range.location]; //截取字符串(包含+号)
    NSString* zonCSub =[zoneCSubSt substringFromIndex:1];
    return zonCSub;
    
}

//验证码按钮
- (void)getCode{
    
    if (_contentView.phoneField.text.length ==11){
        
        if (![_contentView.countryCodeBtn.titleLabel.text isEqualToString:@"选择国家"]){
            
            zoneCSubStr =[self getZone];
            NSLog(@"zoneCSubStr =%@",zoneCSubStr);
//            [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_contentView.phoneField.text zone:zoneCSubStr customIdentifier:nil result:^(NSError *error) {
//                if (!error) {
//                    NSLog(@"获取验证码成功");
//                    [self tipView:@"获取验证码成功"];
//                    //更新时间
                    [_timer2 invalidate];

                    cnt = 0;
                    //启动倒数更新时间
                    NSTimer* timer2=[NSTimer scheduledTimerWithTimeInterval:1
                                                                     target:self
                                                                   selector:@selector(updateTime)
                                                                   userInfo:nil
                                                                    repeats:YES];
                    _timer2=timer2;
//
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.contentView.verifiCodeField.text = @"zYHd";
            });
//                } else {
//                    NSLog(@"错误信息：%@",error);
//                }
//            }];
        }else {
            NSLog(@"选择区号");
            [self tipView:@"请选择国家区号"];
        }
    }else{
        NSLog(@"请输入合法的手机号码");
        [self tipView:@"请输入手机号"];
    }
}

#pragma mark - 登录，注册，忘记密码按钮事件触发
//验证码倒数时间更新
-(void)updateTime
{
    cnt++;
    if (cnt>=120)
    {
        [_timer2 invalidate];
        
        _contentView.getCodeBtn.titleLabel.text=@"获取手机验证码";
        _contentView.getCodeBtn.userInteractionEnabled=YES;
        
        return;
    }
    //NSLog(@"更新时间");
    _contentView.getCodeBtn.titleLabel.text=[NSString stringWithFormat:@"%i秒后",120-cnt];
    _contentView.getCodeBtn.userInteractionEnabled=NO;
    
}

//注册按钮 请求前判断逻辑
- (BOOL)judge{
    NSString *regex = @"1[0-9]{10}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:_contentView.phoneField.text];
    if (!isMatch){
        //手机号码不正确
        [self tipView:@"手机号码错误"];
        return NO;
    }
    
    if ([_contentView.countryCodeBtn.titleLabel.text isEqualToString:@"选择国家"]){
        [self tipView:@"请选择国家区号"];
        //        [_contentView.getCodeBtn addTarget:self action:@selector(presBt:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if (_contentView.phoneField.text.length ==11){
        
        if (![_contentView.verifiCodeField.text isEqualToString:@""]) {
            
            if([_contentView.passwordField1.text isEqualToString:_contentView.passwordField2.text]){
                if(_contentView.passwordField2.text.length >= 8){
                    return YES;
                }
                else{
                    NSLog(@"输入8位以上密码");
                    [self tipView:@"输入8位以上密码"];
                }
            }
            else{
                NSLog(@"两次密码不一致");
                [self tipView:@"两次密码不一致"];
            }
        }
        else {
            NSLog(@"验证码不能为空");
            [self tipView:@"验证码不能为空"];
        }
    }
    else{
        NSLog(@"请输入手机号码");
        [self tipView:@"请输入手机号"];
    }
    return NO;
}

- (void)RegisterBtn {
    if([self judge]){
        [MBProgressHUD showMessage:@"注册中"];
        NSLog(@"注册成功");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
}

- (void)tipView:(NSString *)tips{
    
    //提示 视图
    _vw =[[TipView alloc] init];
    //提示 内容
    _vw.tipLabel.text =tips;
    
    [self.view addSubview:_vw];
    [_vw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(100);
        make.right.equalTo(self.view.mas_right).offset(-100);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(40);
    }];
    //显示定时器
    _timer =[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(updateTimer:) userInfo:@"小鑫" repeats:NO];
}

//定时器事件
- (void)updateTimer:(NSTimer *)timer{
    
    [_vw removeFromSuperview];
    [_timer invalidate];
}

@end
