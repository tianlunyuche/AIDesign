//
//  ZXOrderVC.m
//  AIDesign
//
//  Created by xinying on 2018/1/14.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXOrderVC.h"
#import "ZXGoodsCell01.h"

#define ZXGoodsCell @"ZXGoodsCell01"

@interface ZXOrderVC ()<UITableViewDelegate ,UITableViewDataSource,UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(nonatomic,strong) UISearchController *searchVC;

@end

@implementation ZXOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:ZXGoodsCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ZXGoodsCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.searchVC.searchBar.placeholder =@"搜索产品";

    self.navigationItem.title =@"你好";
//    self.navigationController.navigationBar.prefersLargeTitles = true;
    self.navigationItem.hidesSearchBarWhenScrolling =NO;
    self.definesPresentationContext = YES;
//    self.navigationItem.searchController =self.searchVC;
    self.navigationItem.titleView =self.searchVC.searchBar;
}

-(UISearchController *)searchVC{
    if (!_searchVC) {
        _searchVC =[[UISearchController alloc] initWithSearchResultsController:self];
        _searchVC.searchResultsUpdater =self;
        _searchVC.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    }
    return _searchVC;
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

//the search bar becomes first responder.
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}

@end
