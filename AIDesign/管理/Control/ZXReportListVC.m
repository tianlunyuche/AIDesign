//
//  ZXReportListVC.m
//  AIDesign
//
//  Created by xinying on 2018/5/20.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXReportListVC.h"
#import "ZXReportVC.h"

@interface ZXReportListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *msgListArray;

@end

@implementation ZXReportListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZXReportVC *vc = [[ZXReportVC alloc] init];
    vc.row  = indexPath.row;
    vc.name = self.titleArray[indexPath.row];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.picArray[indexPath.row]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark - LazyLoad
-(NSMutableArray *)msgListArray{
    if (!_msgListArray) {
        _msgListArray = [[NSMutableArray alloc] init];
        
    }
    return _msgListArray;
}

-(NSArray *)titleArray {
    return @[@"月销售量",@"季度销售量",@"年销售量",@"年销售总额",@"年采购总额",@"年获利润"];
}

-(NSArray *)title2Array {
    return @[@"月销售量",@"季度销售量",@"年销售量",@"年销售总额",@"年生产总额",@"年获利润"];
}

-(NSArray *)picArray {
    return @[@"more-restaurant-lastWeek-1",
             @"more-restaurant-monthStock",
             @"more-restaurant-lastWeek",
             @"more-restaurant-nut",
             @"more-restaurant-returnRecord-1",
             @"more-restaurant-returnRecord"];
}

@end
