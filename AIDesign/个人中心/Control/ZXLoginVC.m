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
#import "PersonalInfoVC.h"
#import "ZXUserModel.h"
#import "ZXNetWorkManager.h"

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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_isDirectLogin) {
        [self defaultLogin];
    }
}

-(void)defaultLogin{
    NSLog(@"defaultLogin");
   
    if(_contentView.phoneNumField.text.length < 11){
        [MBProgressHUD showError:@"错误的手机号"];
    }
    else if(([_contentView.passwordField.text isEqualToString:@""])||( _contentView.passwordField.text.length <8)){
//        [self tipView:@"密码错误"];
        [MBProgressHUD showError:@"密码要大于或等于8位"];
    }
    else{
        [MBProgressHUD showMessage:@"登录中"];
         NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:_contentView.phoneNumField.text forKey:UserNameKey];
        [userDefaults setObject:_contentView.passwordField.text forKey:UserPwdKey];
        ZXUserModel *userModel = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:UserModelMsg]];  //880
        if (!userModel) {
            userModel  = [ZXUserModel new];
        }
        userModel.uid = _contentView.phoneNumField.text;
        userModel.mobile = _contentView.phoneNumField.text;
        [kUserDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:userModel] forKey:UserModelMsg];
        
        [userDefaults synchronize];
        
        [self loginRongyun];
        
        //-----商家用的 用户手机 集合：
        NSMutableArray *phones = [kUserDefaults objectForKey:AllPhones];
        if (!phones) {
            phones = [NSMutableArray array];
        }
        __block BOOL isHas;
        [phones enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isEqualToString:userModel.mobile]) {
                isHas = YES;
            }
        }];
        
        NSMutableArray *tmpPhones = [NSMutableArray arrayWithArray:phones];
        if (!isHas && ![userModel.mobile containsString:@"#"]) {
            [tmpPhones addObject:userModel.mobile];
        }
        [kUserDefaults setObject:tmpPhones forKey:AllPhones];
        
        //----------是否进入 信息编辑页
        userModel = CurrentUserModel;
        if (!userModel.isOld) {
            PersonalInfoVC *vc = [[PersonalInfoVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            [MBProgressHUD hideHUD];
        }
        else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                }];
            });
    
        }
      
    }
}

-(void)loginRongyun {
    ZXUserModel *userModel = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:UserModelMsg]];  //880
//    NSDictionary *param2 =@{@"userId":@"123456789",@"name":@"小新",@"portraitUri":@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=552972519,2902321478&fm=58"};
    NSDictionary *param2 =@{@"userId":userModel.uid,@"name":userModel.nickname,@"portraitUri":@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=552972519,2902321478&fm=58"};
    [[ZXNetWorkManager sharedInstance] postRongYunTokenWithParam:param2 success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *token = [responseObject objectForKey:@"token"];
        [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
            
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        } error:^(RCConnectErrorCode status) {
            
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
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
