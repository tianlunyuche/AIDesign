//
//  ZXTabBarController.m
//  AIDesign
//
//  Created by xinying on 2018/3/29.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXTabBarController.h"
#import "ZXLoginVC.h"

@interface ZXTabBarController ()

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
