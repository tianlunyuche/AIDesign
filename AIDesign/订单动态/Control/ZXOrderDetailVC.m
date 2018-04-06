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

#define ZXGoodsCell @"ZXGoodsCell01"
#define ZXMENUCELL @"ZXMenuCell"

@interface ZXOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property(nonatomic,strong) ZXDetailView *detailView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong) ZXDetailPageVC *pageVC;

@property(nonatomic,strong) UIView *sectionHeaderV;
@end

@implementation ZXOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerNib:[UINib nibWithNibName:ZXGoodsCell bundle:nil] forCellReuseIdentifier:ZXGoodsCell];
    self.tableView.tableHeaderView = self.detailView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
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
//    UITableViewHeaderFooterView *view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"UITableViewHeaderFooterView"];
//    ZXDetailPageVC *vc = [[ZXDetailPageVC alloc] init];
//    [self addChildViewController:vc];
//    [view.contentView addSubview:vc.view];
//
//    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(0);
//    }];
//    return view;
    [self.pageVC setViewFrame:CGRectMake(0,   0, kScreenWidth, 40)];
    return self.sectionHeaderV;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXGoodsCell01 *cell = [tableView dequeueReusableCellWithIdentifier:ZXGoodsCell];
    
    return cell;
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



@end
