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
#import "ZXAlertVC.h"

#import "BDSASRDefines.h"
#import "BDSASRParameters.h"
#import "BDSWakeupDefines.h"
#import "BDSWakeupParameters.h"
#import "BDSEventManager.h"
#import "BDRecognizerViewController.h"
#import "fcntl.h"
//#import "AudioInputStream.h"


#define ZXGoodsCell @"ZXGoodsCell01"
#define ZXMenuCell @"ZXMenuCell"


const NSString* API_KEY =@"CfGHkaxz5VfDbLkn8gdoKb8v";
const NSString* SECRET_KEY =@"dGqy8gG8iLGayjvbsadSXAfRmg7dbDUY";
const NSString* APP_ID =@"10605504";

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    UIAlertController *vc =[UIAlertController alertControllerWithTitle:nil message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
//    vc.view.backgroundColor =[UIColor clearColor];
//    UIAlertAction *action =[UIAlertAction actionWithTitle:@"buyao" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"gaoxiao");
//    }];
//    UIAlertAction *action2 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"取消");
//    }];
//    UIAlertAction *action3 =[UIAlertAction actionWithTitle:@"不再" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"东东");
//    }];
//    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 300,200)];
//    view.backgroundColor =[UIColor redColor];
//    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
//    [btn addTarget:self action:@selector(objectd ) forControlEvents:UIControlEventTouchUpInside];
//    btn.frame =CGRectMake(0, 0, 300, 100);
//    btn.backgroundColor =[UIColor blueColor];
//    [view addSubview:btn];
////    [vc.view addSubview:view];
//    [vc addAction:action3];
//    [vc addAction:action2];
//    [vc addAction:action];
    
    ZXAlertVC *vc =[ZXAlertVC alertControllerWithTitle:@"" message:@"" preferredStyle:ZXAlertControllerStyleActionSheet];
    ZXAlertAction *action =[ZXAlertAction actionWithTitle:@"好的" style:ZXAlertActionStyleDefault handler:^(ZXAlertAction * _Nullable action) {
       
    }];
    [vc addAction:action];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)objectd{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXGoodsCell01 *cell = [tableView dequeueReusableCellWithIdentifier:ZXGoodsCell];
    return cell;
}


#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"ds");
}

@end
