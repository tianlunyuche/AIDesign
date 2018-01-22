//
//  ZXOrderVC.m
//  AIDesign
//
//  Created by xinying on 2018/1/14.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXOrderVC.h"
#import "ZXGoodsCell01.h"
#import "ZXMenuCell.h"
#import "ZXResultTableVC.h"

#define ZXGoodsCell @"ZXGoodsCell01"
#define ZXMenuCell @"ZXMenuCell"

@interface ZXOrderVC ()<UITableViewDelegate ,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *menuView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(nonatomic,strong) UISearchController *searchVC;

@property(nonatomic,strong) ZXResultTableVC *resultTableVC;
@end

@implementation ZXOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:ZXGoodsCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ZXGoodsCell];
    self.tableView.tag =1010;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.searchVC.searchBar.placeholder =@"搜索产品";

    self.navigationItem.title =@"你好";
//    self.navigationController.navigationBar.prefersLargeTitles = true;
    self.navigationItem.hidesSearchBarWhenScrolling =NO;
    self.definesPresentationContext = YES;
//    self.navigationItem.searchController =self.searchVC;
//    self.tableView.tableHeaderView =self.searchVC.searchBar;
    self.navigationItem.titleView =self.searchVC.searchBar;
    
//    NSString *jsonPath =[[NSBundle mainBundle] pathForResource:@"Service" ofType:@"json"];
//    NSData *data =[NSData dataWithContentsOfFile:jsonPath];
//    NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

}

-(UISearchController *)searchVC{
    if (!_searchVC) {
        
        _searchVC =[[UISearchController alloc] initWithSearchResultsController:self.resultTableVC];
        _searchVC.searchResultsUpdater =self.resultTableVC;
        //得加上这一句，否则 以 self.navigationItem.titleView =self.searchVC.searchBar;这种方式，会导致 搜索框上移-64 不可见。
        _searchVC.hidesNavigationBarDuringPresentation =NO;
        _searchVC.searchBar.searchBarStyle = UISearchBarStyleDefault;
    }
    return _searchVC;
}

-(ZXResultTableVC *)resultTableVC{
    if (!_resultTableVC) {
        _resultTableVC = [[ZXResultTableVC alloc] init];
    }
    return _resultTableVC;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXGoodsCell01 *cell = [tableView dequeueReusableCellWithIdentifier:ZXGoodsCell];
    return cell;
}


@end
