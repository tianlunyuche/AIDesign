//
//  ZXAlertVC.m
//  ZXAlertViewController
//
//  Created by xinying on 2017/1/23.
//  Copyright © 2017年 habav. All rights reserved.
//

#import "ZXAlertVC.h"
#import "ZXTableViewCell.h"

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
    
    return self;
}
@end

@interface ZXAlertVC ()<UITableViewDelegate ,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray<ZXAlertAction *> *alertAction;
@property (nonatomic, readwrite) ZXAlertControllerStyle preferredStyle;

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
        self.view.backgroundColor =[UIColor colorWithRed:1 green:0 blue:0 alpha:0.1];
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
    
    [self.alertAction addObject:action];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.alertAction.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:Cell];
    
    return cell;
}

-(NSMutableArray<ZXAlertAction *> *)alertAction{
    if (!_alertAction) {
        _alertAction =[NSMutableArray arrayWithCapacity:1];
    }
    return _alertAction;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 300, 300, 200) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];

    }
    return _tableView;
}

@end
