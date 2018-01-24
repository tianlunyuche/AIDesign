//
//  ZXAlertVC.m
//  ZXAlertViewController
//
//  Created by xinying on 2017/1/23.
//  Copyright © 2017年 habav. All rights reserved.
//

#import "ZXAlertVC.h"
#import "ZXTableViewCell.h"
#import <YYKit.h>

#define Cell @"ZXTableViewCell"

@interface ZXAlertAction ()

@property (nullable, nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) ZXAlertActionStyle style;
@end

@implementation ZXAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(ZXAlertActionStyle)style handler:(void (^ __nullable)(ZXAlertAction *action))handler{
    return [[self alloc] initWithTitle:title style:style handler:handler];
}

- (instancetype)initWithTitle:(NSString *)title style:(ZXAlertActionStyle)style handler:(void (^ __nullable)(ZXAlertAction *action))handler{
    
    if (self = [super init]) {
        self.title =title;
        self.style =style;
    }
    handler(self);
    
    return self;
}
@end

@interface ZXAlertVC ()<UITableViewDelegate ,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray<ZXAlertAction *> *alertAction;
@property(nonatomic,strong) NSMutableArray<ZXAlertAction *> *cancelAction;
@property (nonatomic, readwrite) ZXAlertControllerStyle preferredStyle;

@property(nonatomic,assign) NSInteger section;

@end

@implementation ZXAlertVC

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(ZXAlertControllerStyle)preferredStyle{
    return [[self alloc] initWithTitle:title message:message preferredStyle:preferredStyle];
}

- (instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(ZXAlertControllerStyle)preferredStyle{
    
    if (self = [super init]) {
        self.title =title;
        self.message =message;
        self.preferredStyle =preferredStyle;
        self.view.backgroundColor =[UIColor grayColor];
        self.view.alpha =0;
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        self.section =1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.preferredStyle == ZXAlertControllerStyleActionSheet) {
        [self.tableView registerNib:[UINib nibWithNibName:Cell bundle:nil] forCellReuseIdentifier:Cell];
        self.tableView.delegate =self;
        self.tableView.dataSource =self;
    }
}

-(void)addAction:(ZXAlertAction *)action{
    
    if (action.style == ZXAlertActionStyleCancel) {
        _section =2;
        [self.cancelAction addObject:action];
    }else
    [self.alertAction addObject:action];
}

-(void)removeAllAction{
    [self.alertAction removeAllObjects];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_delegate != nil && [_delegate respondsToSelector:@selector(didSelectIndex:)]) {
        [_delegate didSelectIndex:indexPath.row];
        return;
    }
    [self dissmisView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return self.alertAction.count;
    }
    return self.cancelAction.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:Cell];
    if (indexPath.section ==0) {
        ZXAlertAction *action = self.alertAction[indexPath.row];
        cell.title.text =action.title;
    }else
        cell.title.text =self.cancelAction[indexPath.row].title;

    return cell;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.section;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==1) {
        return 20;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section ==1) {
        return [[UIView alloc] init];
    }
    return nil;
}

#pragma mark - LazyLoad
-(NSMutableArray<ZXAlertAction *> *)alertAction{
    if (!_alertAction) {
        _alertAction =[NSMutableArray arrayWithCapacity:1];
    }
    return _alertAction;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 0) style:UITableViewStylePlain];
        _tableView.backgroundColor =[UIColor clearColor];
        [self.view addSubview:_tableView];

    }
    return _tableView;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dissmisView];
}

-(void)dissmisView{
    [UIView animateWithDuration:0.17 animations:^{
        
        self.view.alpha =0;
        self.tableView.frame =CGRectMake(0, kScreenHeight, kScreenWidth, self.tableView.bounds.size.height);
    } completion:^(BOOL finished) {
        
        [self.view removeFromSuperview];
        self.section =1;
        [self removeAllAction];
    }];
}

-(void)show{
    
    CGFloat height =self.alertAction.count * 44 +(self.section -1)*20;
    self.tableView.frame =CGRectMake(0, kScreenHeight, kScreenWidth, height);
    [self.tableView reloadData];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.view];
    [UIView animateWithDuration:0.17 animations:^{
        
        self.view.alpha =0.5;
        self.tableView.frame =CGRectMake(0, kScreenHeight -self.tableView.bounds.size.height, kScreenWidth, self.tableView.bounds.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

@end
