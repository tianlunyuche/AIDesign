//
//  ZXResultTableVC.m
//  AIDesign
//
//  Created by xinying on 2018/1/22.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXResultTableVC.h"
#import "ZXGoodsCell01.h"
#import "ZXGoodsSourceModel.h"

#define ZXProductCell @"ZXGoodsCell01"
#define ZXGoodsCell @"ZXGoodsCell01"
#define ZXMENUCELL @"ZXMenuCell"

@interface ZXResultTableVC ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UITableView *menuView;
@property(nonatomic,strong) NSMutableArray *resultArray;

@end

@implementation ZXResultTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:ZXProductCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ZXProductCell];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;

    [self addSureButton];
}

-(void)addSureButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [btn setTitle:@"确 定"  forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [self.view bringSubviewToFront:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(0);
    }];
//-----------
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.tabBarController.tabBar.hidden  = NO;
//}


//the search bar becomes first responder.
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSLog(@"update");
}

#pragma mark - LazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        [self.view addSubview: _tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.bottom.mas_equalTo(-50);
        }];
    }
    return _tableView;
}

-(NSMutableArray *)resultArray{
    if (!_resultArray) {
        _resultArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _resultArray;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.resultArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXGoodsCell01 *cell = [tableView dequeueReusableCellWithIdentifier:ZXGoodsCell];
    ZXGoodsModel *goodsModel = self.goodsArray[indexPath.row];
    cell.name.text = goodsModel.title;
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:goodsModel.img] placeholderImage:[UIImage imageNamed:@"default-ico-none"]];
    cell.price.text = [NSString stringWithFormat:@"%@元/%@",goodsModel.currentPrice ,goodsModel.unit];
    cell.unit.text = goodsModel.unit;
    
    if (goodsModel.num >0) {
        cell.addBtn.hidden = YES;
        cell.num.hidden = NO;
        cell.num.text = [NSString stringWithFormat:@"%ld",(long)goodsModel.num];
    } else {
        cell.addBtn.hidden = NO;
        cell.num.hidden = YES;
    }
    
    if (cell.gestureRecognizers.count ==0) {
        UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(lpGR:)];
        //设定最小的长按时间 按不够这个时间不响应手势
        longPressGR.minimumPressDuration = 1;
        [cell addGestureRecognizer:longPressGR];
    }
    //        NSArray *priceArray =[goodsdic objectForKey:@"uom_id"];
    //        cell.price.text =[NSString stringWithFormat:@"%@\%@",priceArray[0] ,priceArray[1]];
    
    return cell;
}
@end
