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
#import "ZXUserModel.h"
#import "ZXOrders.h"

#define DynamicCell @"ZXDynamicCell"
#define ZXMENUCELL @"ZXMenuCell"
#define OrderDetailVC @"ZXOrderDetailVC"

@interface ZXDynamicVC () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *ordersArray;

@end

@implementation ZXDynamicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [kUserDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:order] forKey:[NSString stringWithFormat:@"%@%@",CurrentOrders,userModel.mobile]];

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
    
    [self.ordersArray removeAllObjects];
    
    NSArray *phones = [kUserDefaults objectForKey:AllPhones];
    NSString *currentPhone = [kUserDefaults objectForKey:UserNameKey];
    ZXUserModel *userModel = CurrentUserModel;
    if ([currentPhone containsString:@"#"]) {
        //------商家的 所有订单
        for (NSString *phone in phones) {
            ZXOrders *orders = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:[NSString stringWithFormat:@"%@%@",CurrentOrders ,phone]]];
            if (orders && orders.order && orders.order.count) {
                if (orders) {
                    if (self.isAllOrder) {
                        //所有订单
                         [self.ordersArray addObjectsFromArray:orders.order];
                    } else {
                        //订单动态
                        for (ZXOrder *order in orders.order) {
                            if (![order.state isEqualToString:@"已取消"] && ![order.state isEqualToString:@"已收货"]) {
                                [self.ordersArray addObject:order];
                            }
                        }
                    }
                }
            }
        }
    } else {
        //------当前用户 的订单
        ZXOrders *orders = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:[NSString stringWithFormat:@"%@%@",CurrentOrders ,userModel.mobile]]];
        
        if (orders) {
            if (self.isAllOrder) {
                //所有订单
                [self.ordersArray addObjectsFromArray:orders.order];
            } else {
                //订单动态
                for (ZXOrder *order in orders.order) {
                    if (![order.state isEqualToString:@"已取消"] && ![order.state isEqualToString:@"已收货"]) {
                        [self.ordersArray addObject:order];
                    }
                }
            }
        }
    }
 

    [self.tableView reloadData];
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
    
    
//    ZXUserModel *userModel = CurrentUserModel;
//    ZXOrders *orders = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:[NSString stringWithFormat:@"%@%@",CurrentOrders ,userModel.mobile]]];
    
    
    ZXOrderDetailVC *vc = [[ZXOrderDetailVC alloc] initWithNibName:OrderDetailVC bundle:nil];
    vc.ordersArray = self.ordersArray;
    vc.order = self.ordersArray[indexPath.row];
    vc.row = indexPath.row;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ordersArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:DynamicCell];
    ZXOrder *order = self.ordersArray[indexPath.row];
    if (order) {
        cell.time.text = order.time;
        cell.code.text = order.orderID;
        cell.state.text = order.state;
        cell.num.text  = [NSString stringWithFormat:@"%@件",order.amount];
        cell.money.text  = [NSString stringWithFormat:@"%@元",order.totalPrice];
        cell.seller.text = order.wuliuPerson;
        cell.phone.text = order.phone;
        
        NSString *icon ;
        if ([order.state containsString:@"待发货"]) {
            icon = @"state-restaurant-rated";
        } else
            if ([order.state containsString:@"发货中"]) {
                icon = @"state-restaurant-3-delivering";
            }
            else
                if ([order.state containsString:@"待收货"]) {
                    icon = @"state-restaurant-3-delivering";
                }
                else
                    if ([order.state containsString:@"取消中"]) {
                        icon = @"state-restaurant-sale";
                    }
                    else
                        if ([order.state containsString:@"已收货"]) {
                            icon = @"state-restaurant-4-received";
                        }
                        else
                            if ([order.state containsString:@"已取消"]) {
                                icon = @"state-restaurant-cancel";
                            }
        cell.icon.image = [UIImage imageNamed:icon];
    }

    
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

-(NSMutableArray *)ordersArray {
    if (!_ordersArray) {
        _ordersArray = [[NSMutableArray alloc] init];
    }
    return _ordersArray;
}


@end
