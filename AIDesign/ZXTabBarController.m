//
//  ZXTabBarController.m
//  AIDesign
//
//  Created by xinying on 2018/3/29.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXTabBarController.h"
#import "ZXLoginVC.h"
#import "ZXUserModel.h"
#import "ZXOrderVC.h"
#import "ZXDynamicVC.h"
#import "ZXMessageVC.h"
#import "ZXPageController.h"
#import "ZXCenterVC.h"
#import "ZXNetWorkManager.h"

@interface ZXTabBarController ()

@property(nonatomic,strong) ZXDynamicVC *dyVC;
@property(nonatomic,strong) ZXOrderVC *orderVC;
@property(nonatomic,strong) ZXPageController *pageVC;
@property(nonatomic,strong) ZXMessageVC *msgVC;
@property(nonatomic,strong) ZXCenterVC *centerVC;

@end

@implementation ZXTabBarController

-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
    
//    UIViewController * currentController = self.viewControllers[self.selectedControllerIndex];
//
//    [currentController.view removeFromSuperview];
//
//    [currentController removeFromParentViewController];
//
//    [currentController willMoveToParentViewController:nil];

    UIStoryboard *storyB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (!self.dyVC) {
        self.dyVC = [storyB instantiateViewControllerWithIdentifier:@"ZXDynamicVC"];
    }
    if (!self.orderVC) {
        self.orderVC = [storyB instantiateViewControllerWithIdentifier:@"ZXOrderVC"];
    }
    if (!self.pageVC) {
        self.pageVC = [storyB instantiateViewControllerWithIdentifier:@"ZXPageController"];
    }
    if (!self.msgVC) {
        self.msgVC = [storyB instantiateViewControllerWithIdentifier:@"ZXMessageVC"];
    }
    if (!self.centerVC) {
        self.centerVC = [storyB instantiateViewControllerWithIdentifier:@"ZXCenterVC"];
    }
    
    NSString *user = [kUserDefaults objectForKey:UserNameKey];
    if ([user containsString:@"#"]) {
        self.viewControllers =
        @[[self giveAttributesWithVC:self.dyVC andImgName:@"dyn_n" andSelectImgName:@"dyn_y" name:@"订单动态"] ,
          [self giveAttributesWithVC:self.pageVC andImgName:@"mana" andSelectImgName:@"mana_g" name:@"管理"],
          [self giveAttributesWithVC:self.msgVC andImgName:@"msg_off" andSelectImgName:@"msg_in" name:@"消息"],
          [self giveAttributesWithVC:self.centerVC andImgName:@"me" andSelectImgName:@"me_g" name:@"个人"]];
            
    } else {
        self.viewControllers =
        @[[self giveAttributesWithVC:self.dyVC andImgName:@"dyn_n" andSelectImgName:@"dyn_y" name:@"订单动态"] ,
          [self giveAttributesWithVC:self.orderVC andImgName:@"shop_g" andSelectImgName:@"shop_n" name:@"下单"] ,
          [self giveAttributesWithVC:self.pageVC andImgName:@"mana" andSelectImgName:@"mana_g" name:@"管理"],
          [self giveAttributesWithVC:self.msgVC andImgName:@"msg_off" andSelectImgName:@"msg_in" name:@"消息"],
          [self giveAttributesWithVC:self.centerVC andImgName:@"me" andSelectImgName:@"me_g" name:@"个人"]];
        
    }
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
    self.navigationController.tabBarController.tabBar.hidden = NO;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:@"user"]) {
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:[[ZXLoginVC alloc] init]];
        
        [self presentViewController:navVC animated:YES completion:^{
            
        }];
    }
    [self loginRongyun];
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

- (UIViewController *)giveAttributesWithVC:(UIViewController *)VC andImgName:(NSString *)imgName andSelectImgName:(NSString *)selectImgName name:(NSString *)name
{
    
    UINavigationController* nav =[[UINavigationController alloc] initWithRootViewController:VC];
    //    设置导航条字体大小和颜色
    [nav.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //        initWithTitle:VC.title
    nav.tabBarItem =[[UITabBarItem alloc] initWithTitle:nil image:[self removeRending:imgName] selectedImage:[self removeRending:selectImgName]];
    nav.tabBarItem.title = name;
    nav.tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0,-6, 0);//使底部导航栏图片居中
    return nav;
}
- (UIImage *)removeRending:(NSString *)imageName{
    UIImage* image =[UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
