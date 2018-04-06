//
//  forgetPassController.m
//  paohon_v1_0
//
//  Created by xinying on 2017/1/8.
//  Copyright © 2017年 paohon. All rights reserved.
//

#import "ZXforgetPassVC.h"
#import "ZXCountryCodeVC.h"
#import "RegisterContentView.h"

@interface ZXforgetPassVC ()
//<XWCountryCodeControllerDelegate>
{
    //服务端URL
//    NSString * domainStr;
}

//@property(nonatomic ,strong) RegisterContentView * contentView;

@end

@implementation ZXforgetPassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"重置密码";
 
    [self.contentView.registerBtn removeFromSuperview];
    //确定按钮 创建和添加
    [self.view addSubview:self.fgtBtnCreat];
    [_fgtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.backView.mas_bottom).offset(25);
        make.left.equalTo(self.contentView.mas_left).offset(40);
        make.right.equalTo(self.contentView.mas_right).offset(-40);
        make.height.equalTo(@(50));
    }];

    [_fgtBtn addTarget:self action:@selector(forgetBtn) forControlEvents:UIControlEventTouchUpInside];

}

//- (void)countryCode{
//    XWCountryCodeController *CountryCodeVC = [[XWCountryCodeController alloc] init];
//    CountryCodeVC.deleagete = self;
//    
//    //block
//    [CountryCodeVC toReturnCountryCode:^(NSString *countryCodeStr) {
//        NSRange range = [countryCodeStr rangeOfString:@"+"]; //现获取要截取的字符串位置
//        NSString * couCodeSubStr = [countryCodeStr substringFromIndex:range.location]; //截取字符串
//        [_contentView.countryCodeBtn setTitle:couCodeSubStr forState:UIControlStateNormal];
//    }];
//    
//    [self presentViewController:CountryCodeVC animated:YES completion:nil];
//}
//
////1.代理传值
//#pragma mark - XWCountryCodeControllerDelegate
//-(void)returnCountryCode:(NSString *)countryCode{
//    NSRange range = [countryCode rangeOfString:@"+"]; //现获取要截取的字符串位置
//    NSString * couCodeSubStr = [countryCode substringFromIndex:range.location]; //截取字符串
//    [_contentView.countryCodeBtn setTitle:couCodeSubStr forState:UIControlStateNormal];
//}
//
//
//- (void)backAction{
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//- (void)toRegister{
//    [self.view endEditing:YES];
//    
//}
//




#pragma mark - 忘记密码 确定按钮创建

- (UIButton *)fgtBtnCreat {
    if (!_fgtBtn) {
        _fgtBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
        [_fgtBtn setTitle:@"确 定" forState:UIControlStateNormal];
        [_fgtBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        _fgtBtn.titleLabel.font =[UIFont fontWithName:@"ArialMT"size:20];
        //        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        // 按钮边框宽度
        //        _registerBtn.layer.borderWidth = 1;
        // 按钮边框宽度
        _fgtBtn.layer.borderWidth = 1.5;
        // 设置圆角
        _fgtBtn.layer.cornerRadius = 10.0;
        
        // 设置颜色空间为rgb，用于生成ColorRef
        //        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        //        // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
        //        CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 1, 1 });
        // 设置边框颜色
        _fgtBtn.layer.borderColor =klineColor.CGColor;
        _fgtBtn.backgroundColor =kbackgdColor;
        //         _registerBtn.layer.borderColor =(__bridge CGColorRef _Nullable)([UIColor colorWithRed:60 /255 green:114 /255 blue:183 /255 alpha:1]);
        
        
        //        [_registerBtn setBackgroundImage:[BASE_COLOR wzx_toImage] forState:UIControlStateNormal];
        //        [_registerBtn setBackgroundImage:[[UIColor colorWithRed:104/255.0 green:187/255.0 blue:30/255.0 alpha:0.5] wzx_toImage] forState:UIControlStateDisabled];
        //        _registerBtn.enabled = NO;
    }
    return _fgtBtn;
}


//确定按钮 事件触发
- (void)forgetBtn{
    
    if ([super judge]) {
        
        NSString* pass =super.contentView.passwordField1.text;
        pass =[pass md5String];
//        zoneCSubStr =[super getZone];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
