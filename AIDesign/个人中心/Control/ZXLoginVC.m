//
//  ZXLoginVC.m
//  AIDesign
//
//  Created by xinying on 2018/3/29.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXLoginVC.h"
#import "LoginContentView.h"
#import "ZXRegisterVC.h"
#import "ZXforgetPassVC.h"

@interface ZXLoginVC ()
@property(nonatomic ,strong) LoginContentView * contentView;

@end

@implementation ZXLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    self.title = @"登录";
    _contentView =[[LoginContentView alloc]  init];
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view).offset(80);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(700));
    }];
    
    [ _contentView.loginBtn addTarget:self action:@selector(defaultLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [_contentView.registerBtn addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
    
    [_contentView.passFindBtn addTarget:self action:@selector(tofindPass) forControlEvents:UIControlEventTouchUpInside];
}


-(void)defaultLogin{
    NSLog(@"defaultLogin");
   
    if(_contentView.phoneNumField.text.length !=11){
        
    }
    else if(([_contentView.passwordField.text isEqualToString:@""])||( _contentView.passwordField.text.length <8)){
//        [self tipView:@"密码错误"];
    }
    else{
         NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:_contentView.phoneNumField.text forKey:@"user"];
        [userDefaults setObject:_contentView.passwordField.text forKey:@"password"];
        [userDefaults synchronize];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

//跳转到注册界面
- (void)toRegister{
    
    ZXRegisterVC* registerVC =[[ZXRegisterVC alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];

}

//跳转到 找回密码 界面
- (void)tofindPass{
    
    ZXforgetPassVC* forgetVC =[[ZXforgetPassVC alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
    //    [self presentViewController:[NSClassFromString(@"forgetPassController")  new] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
