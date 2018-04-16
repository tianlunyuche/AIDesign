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
@end

@implementation ZXOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:ZXGoodsCell bundle:nil] forCellReuseIdentifier:ZXGoodsCell];
    self.tableView.tableHeaderView = self.detailView;
    self.tableView.tableHeaderView.height = 200;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"Service" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    self.menuArray = dic[@"menu"][@"records"];
    

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


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXGoodsCell01 *cell = [tableView dequeueReusableCellWithIdentifier:ZXGoodsCell];
    
    return cell;
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
    UITableViewHeaderFooterView *view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"UITableViewHeaderFooterView"];
//    ZXDetailPageVC *vc = [[ZXDetailPageVC alloc] init];
//    [self addChildViewController:vc];
    [view.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(40 *self.menuArray.count);
    }];
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

#pragma mark - CollectionView UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZXDetailCollectionCell forIndexPath:indexPath];

    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(60, 40);
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
    NSLog(@"hello");
}

#pragma mark - Action
- (IBAction)sureSelect:(id)sender {
    [MBProgressHUD showSuccess:@"收货成功"];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
