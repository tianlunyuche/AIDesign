//
//  ZXDynamicVC.m
//  AIDesign
//
//  Created by xinying on 2018/4/1.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXDynamicVC.h"
#import "ZXDynamicCell.h"
#import "ZXOrderDetailVC.h"

#define DynamicCell @"ZXDynamicCell"
#define ZXMENUCELL @"ZXMenuCell"
#define OrderDetailVC @"ZXOrderDetailVC"

@interface ZXDynamicVC () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation ZXDynamicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:DynamicCell bundle:nil] forCellReuseIdentifier:DynamicCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    self.navigationController.hidesBottomBarWhenPushed = NO;
    self.navigationController.tabBarController.hidesBottomBarWhenPushed = NO;
    self.navigationController.tabBarController.tabBar.hidden = NO;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZXOrderDetailVC *vc = [[ZXOrderDetailVC alloc] initWithNibName:OrderDetailVC bundle:nil];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:DynamicCell];
    
    return cell;
}

#pragma mark - LazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


@end
