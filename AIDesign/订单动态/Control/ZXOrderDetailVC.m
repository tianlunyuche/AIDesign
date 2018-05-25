//
//  ZXOrderDetailVC.m
//  AIDesign
//
//  Created by xinying on 2018/4/1.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXOrderDetailVC.h"
#import "ZXGoodsCell01.h"
#import "ZXDetailView.h"
#import "ZXDetailPageVC.h"
#import "ZXDetailCollectionViewCell.h"
#import "ZXUserModel.h"
#import "ZXGoodsSourceModel.h"
#import "ZXOrders.h"

#define ZXGoodsCell @"ZXGoodsCell01"
#define ZXMENUCELL @"ZXMenuCell"
#define ZXDetailCollectionCell @"ZXDetailCollectionViewCell"

@interface ZXOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property(nonatomic,strong) ZXDetailView *detailView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong) ZXDetailPageVC *pageVC;

@property(nonatomic,strong) UIView *sectionHeaderV;
@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) NSMutableArray *menuArray;
@property(nonatomic,strong) UIView *lineView;
@property(nonatomic,strong) NSMutableArray *goodsArray;
@property(nonatomic,strong) NSMutableArray *goodsSigleArray;

@property(nonatomic,strong) NSString *currentPhone;

@end

@implementation ZXOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:ZXGoodsCell bundle:nil] forCellReuseIdentifier:ZXGoodsCell];
    
   self.currentPhone = [kUserDefaults objectForKey:UserNameKey];
    
    ZXUserModel *userModel = CurrentUserModel;
    self.detailView.state.text = [NSString stringWithFormat:@"订单%@",_order.state];
    
    
    self.detailView.offerer.text = [NSString stringWithFormat:@"供应商：%@",_order.offerer ? _order.offerer : @"食品有限公司"];
    self.detailView.buyer.text  = userModel.compellation;
    self.detailView.time.text = _order.time;
    self.detailView.num.text = [NSString stringWithFormat:@"%@件",_order.amount];
    self.detailView.totalPrice.text = [NSString stringWithFormat:@"%@元",_order.totalPrice];
    
    
    self.tableView.tableHeaderView = self.detailView;
    self.tableView.tableHeaderView.height = 280;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"Service" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    self.menuArray = dic[@"menu"][@"records"];
    
    //---------
    for (ZXGoodsModel *model in self.order.goods) {
        NSMutableArray *array = self.goodsArray[model.type];
        [array addObject:model];
    }
    
    [self setIconAndBtn];
    
    [self.goodsSigleArray removeAllObjects];
    [self.goodsSigleArray addObjectsFromArray:self.goodsArray[0]];
    [self.tableView reloadData];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ZXDetailCollectionViewCell *cell = (ZXDetailCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(cell);
        make.top.mas_equalTo(cell.title.mas_bottom).offset(-1);
        make.height.mas_equalTo(2.5);
    }];

}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    ZXUserModel *userModel = CurrentUserModel;
//    ZXOrders *orders = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:[NSString stringWithFormat:@"%@%@",CurrentOrders ,userModel.mobile]]];
    
    //当前订单
    ZXOrder *order = self.ordersArray[self.row];
    order.state = self.order.state;
    //----考虑到商家 所有订单
    NSMutableArray *array = [NSMutableArray array];
    for (ZXOrder *sorder in self.ordersArray) {
        if ([sorder.phone isEqualToString:order.phone]) {
            [array addObject:sorder];
        }
    }
    
    ZXOrders *orders = [[ZXOrders alloc] init];
    orders.order = array;
    
    //----需要将 该手机号码的 所有订单 在保存一遍
    [kUserDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:orders] forKey:[NSString stringWithFormat:@"%@%@",CurrentOrders ,order.phone]];
    [kUserDefaults synchronize];
}

-(void)setIconAndBtn {
    NSString *icon ;
    if ([_order.state containsString:@"待发货"]) {
        icon = @"亲，正在等待供应商发货";
        self.sureBtn.hidden = NO;
        if ([self.currentPhone containsString:@"#"]) {
            [self.sureBtn setTitle:@"确认发货" forState:UIControlStateNormal];
            @weakify(self)
            [self.sureBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                @strongify(self)
                _order.state = @"发货中";
                [MBProgressHUD showSuccess:@"亲，订单在发货中"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
        } else {
            [self.sureBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            @weakify(self)
            [self.sureBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                @strongify(self)
                _order.state = @"取消中";
                [MBProgressHUD showSuccess:@"亲，正在等待供应商取消"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
        }

    } else
        if ([_order.state containsString:@"发货中"]) {
            icon = @"亲，供应商发货中";
            self.sureBtn.hidden = NO;
            if ([self.currentPhone containsString:@"#"]) {
                [self.sureBtn setTitle:@"已到货" forState:UIControlStateNormal];
                @weakify(self)
                [self.sureBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                    @strongify(self)
                    _order.state = @"待收货";
                    [MBProgressHUD showSuccess:@"亲，订单已到货"];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
            } else {
                [self.sureBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                @weakify(self)
                [self.sureBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                    @strongify(self)
                    _order.state = @"取消中";
                    [MBProgressHUD showSuccess:@"亲，正在等待供应商取消"];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
            }
  
        }
        else
            if ([_order.state containsString:@"待收货"]) {
                icon = @"亲，请收货";
                if ([self.currentPhone containsString:@"#"]) {
                   self.sureBtn.hidden = YES;
                } else {
                    self.sureBtn.hidden = NO;
                    [self.sureBtn setTitle:@"收货" forState:UIControlStateNormal];
                    @weakify(self)
                    [self.sureBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                        @strongify(self)
                        //-----将收货订单商品存起来 用于 库存管理
                        ZXUserModel *userModel = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:UserModelMsg]];
                        
                        ZXGoodsArrayModel *goodSourceModel = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:[NSString stringWithFormat:@"%@%@",CurrentStock ,userModel.mobile]]];
                        if (!goodSourceModel) {
                            goodSourceModel = [ZXGoodsArrayModel new];
                        }
                        if (!goodSourceModel.goodsArray) {
                            goodSourceModel.goodsArray = [[NSArray alloc] init];
                        }
                        NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
                        
                        //-----将库存量 变为 收货量
                        for (NSArray *modelArray in self.goodsArray) {
                            for (ZXGoodsModel *model in modelArray) {
                               model.soldOut = model.num;
                            }
                        }
                        
                        [array addObjectsFromArray:goodSourceModel.goodsArray];
                        for (int i=0; i < self.menuArray.count; i++) {
                            [array addObjectsFromArray:self.goodsArray[i]];
                        }
                        
                        goodSourceModel.goodsArray = array;
                        if (userModel.mobile) {
                            NSString *str = [NSString stringWithFormat:@"%@%@",CurrentStock,userModel.mobile];
                            [kUserDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:goodSourceModel] forKey:str];
                            [kUserDefaults synchronize];
                        }
                        
                        _order.state = @"已收货";
                        [self setIconAndBtn];
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                }
            }
            else
                if ([_order.state containsString:@"取消中"]) {
                    icon = @"亲，正在等待供应商取消";
                    if ([self.currentPhone containsString:@"#"]) {
                        self.sureBtn.hidden = NO;
                        [self.sureBtn setTitle:@"确认取消" forState:UIControlStateNormal];
                        @weakify(self)
                        [self.sureBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                            @strongify(self)
                            _order.state = @"已取消";
                            [MBProgressHUD showSuccess:@"亲，成功已取消订单"];
                            [self.navigationController popToRootViewControllerAnimated:YES];
                            
                        }];
                    } else {
                        self.sureBtn.hidden = YES;
                    }
                }
                else
                    if ([_order.state containsString:@"已收货"]) {
                        icon = @"亲，已收货了";
                        self.sureBtn.hidden = YES;
                        [MBProgressHUD showSuccess:@"收货成功"];
                    }
                    else
                        if ([_order.state containsString:@"已取消"]) {
                            icon = @"亲，已取消";
                            self.sureBtn.hidden = YES;
                        }
    self.detailView.detial.text = icon;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodsSigleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXGoodsCell01 *cell = [tableView dequeueReusableCellWithIdentifier:ZXGoodsCell];
    cell.addBtn.hidden = YES;
    ZXGoodsModel *goodsModel = self.goodsSigleArray[indexPath.row];
    cell.code.text = goodsModel.offerId;
    cell.soldOut.text = [NSString stringWithFormat:@"库存：%ld",goodsModel.soldOut];
    cell.name.text = goodsModel.title;
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:goodsModel.img] placeholderImage:[UIImage imageNamed:@"default-ico-none"]];
    cell.price.text = [NSString stringWithFormat:@"%@元/%@",goodsModel.currentPrice ,goodsModel.unit];
    cell.unit.text = goodsModel.unit;
    cell.num.text = [NSString stringWithFormat:@"%ld",goodsModel.num];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"UITableViewHeaderFooterView"];
//    ZXDetailPageVC *vc = [[ZXDetailPageVC alloc] init];
//    [self addChildViewController:vc];
    [view.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
//    40 *self.menuArray.count
    return view;
//    [self.pageVC setViewFrame:CGRectMake(0,   0, kScreenWidth, 40)];
//    return self.sectionHeaderV;

}

#pragma mark - LazyLoad
-(ZXDetailView *)detailView{
    if (!_detailView) {
        _detailView = [[[NSBundle mainBundle] loadNibNamed:@"ZXDetailView" owner:self options:nil] lastObject];
    }
    return _detailView;
}

-(UIView *)sectionHeaderV{
    if (!_sectionHeaderV) {
        _sectionHeaderV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _sectionHeaderV.backgroundColor = [UIColor orangeColor];
        
        [_sectionHeaderV addSubview:self.pageVC.view];
      
        [self.pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        
    }
    return _sectionHeaderV;
}

-(ZXDetailPageVC *)pageVC{
    if (!_pageVC) {
        _pageVC = [ZXDetailPageVC new];
        //        _pageView.itemMargin = 20;
//        _pageView.titles = @[@"全部"];
        
        [self addChildViewController:_pageVC];
//        [self.view addSubview:_pageView.view];
//        _pageView.view.frame = CGRectMake(0, 64, kScreenWidth, 40);
        
//        _pageView.delegate = self;
        
    }
    return _pageVC;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(60, 40);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:ZXDetailCollectionCell bundle:nil] forCellWithReuseIdentifier:ZXDetailCollectionCell];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView addSubview:self.lineView];
    }
    return _collectionView;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor redColor];
    }
    return _lineView;
}

-(NSMutableArray *)goodsArray {
    if (!_goodsArray) {
        _goodsArray = [[NSMutableArray alloc] init];
        for (int i=0; i <self.menuArray.count; i++) {
            NSMutableArray *array = [NSMutableArray array];
            [_goodsArray addObject:array];
        }
    }
    return _goodsArray;
}
//goodsArray

#pragma mark - CollectionView UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.menuArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZXDetailCollectionCell forIndexPath:indexPath];
    cell.title.text = [self.menuArray[indexPath.row] objectForKey:@"name"];
    
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(65, 40);
}

#pragma mark - UICollectionViewDelegateFlowLayout

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZXDetailCollectionViewCell *cell = (ZXDetailCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(cell);
        make.top.mas_equalTo(cell.title.mas_bottom).offset(-1);
        make.height.mas_equalTo(2.5);
    }];
    
    [self.goodsSigleArray removeAllObjects];
    [self.goodsSigleArray addObjectsFromArray:self.goodsArray[indexPath.row]];
    [self.tableView reloadData];
    NSLog(@"hello");
}

-(NSMutableArray *)goodsSigleArray {
    if (!_goodsSigleArray) {
        _goodsSigleArray = [NSMutableArray array];
    }
    return _goodsSigleArray;
}

#pragma mark - Action
- (IBAction)sureSelect:(id)sender {
//    [MBProgressHUD showSuccess:@"收货成功"];
//    [self.navigationController popToRootViewControllerAnimated:YES];

}

@end
