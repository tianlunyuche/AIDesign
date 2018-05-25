//
//  ZXCenterVC.m
//  AIDesign
//
//  Created by 赵庄鑫 on 2018/4/12.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXCenterVC.h"
#import "ZXUserModel.h"
#import "ZXLoginVC.h"

#define DynamicCell @"ZXDynamicCell"
#define ZXMENUCELL @"ZXMenuCell"
#define OrderDetailVC @"ZXOrderDetailVC"

@interface ZXCenterVC () <UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
/** 下拉放大背景图 */
@property (strong, nonatomic)  UIImageView *logoBgImgView;
@property (nonatomic, assign) CGPoint tempBgViewCenter;
/** 头视图 */
@property (strong, nonatomic)  UIView *headView;
@property(nonatomic,strong) UIImageView *imageView;


@end

static CGFloat logoBgImgViewHeight = 219;

@implementation ZXCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:DynamicCell bundle:nil] forCellReuseIdentifier:DynamicCell];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    //   self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    self.tableView.dataSource = self;
    
    self.logoBgImgView = [[UIImageView alloc]init];
    self.logoBgImgView.image = [UIImage imageNamed:@"center_bg2"];
    self.logoBgImgView.frame = CGRectMake(0, 64, kScreenWidth, logoBgImgViewHeight);
    self.logoBgImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.tempBgViewCenter = self.logoBgImgView.center;
    
    [self.view insertSubview:self.logoBgImgView belowSubview:self.tableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ZXUserModel *userModel = [NSKeyedUnarchiver unarchiveObjectWithData:[kUserDefaults objectForKey:UserModelMsg]];
    self.imageView.image = userModel.portraitImage ? userModel.portraitImage : [UIImage imageNamed:@"portrait"];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return logoBgImgViewHeight;
    }
    return 50;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 2: {
                [kUserDefaults removeObjectForKey:@"user"];
                UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:[[ZXLoginVC alloc] init]];
                
                [self presentViewController:navVC animated:YES completion:^{
                    
                }];
            }
                break;
                
            default: {
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:[[NSClassFromString(self.classArray[indexPath.row]) alloc] init] animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
        }
        
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString *ID = @"centervcCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = NO;
        }
        
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        self.headView = [[UIView alloc]init];
        self.headView.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:self.headView];
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cell.contentView.mas_left).offset(0);
            make.right.equalTo(cell.contentView.mas_right).offset(0);
            if (@available(iOS 11.0, *)) {
                make.top.equalTo(cell.contentView.mas_top).offset(10);
            } else {
                make.top.equalTo(cell.contentView.mas_top).offset(25);
            }
            
            make.bottom.equalTo(cell.contentView.mas_bottom).offset(0);
        }];
        
        [self.headView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.headView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(100, 100));
            make.centerY.mas_equalTo(self.headView.mas_centerY);
        }];
        //--------------
        
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        }
        
        cell.textLabel.text = self.listArray[indexPath.row];
        //        cell.detailTextLabel.text = @"详情";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

-(NSArray *)listArray {
    return @[@"修改个人信息",@"查看购物车",@"退出登录"];
}

-(NSArray *)classArray {
    return @[@"PersonalInfoVC",@"PersonalInfoVC",@""];
}


#pragma mark - ScrollViewDelegate
#pragma mark -- UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    if (scrollView == self.tableView) {
////        NSLog(@"self.tableView.contentOffset.y =%f",self.tableView.contentOffset.y);
//        if (scrollView.contentOffset.y<30) {
//
//            float ratito = fabs(self.tableView.contentOffset.y*0.5 -15)/30 +1;
//            self.logoBgImgView.transform = CGAffineTransformMakeScale(ratito,ratito);
//
//            if (self.tableView.contentOffset.y<=-30) {
//
//                self.tableView.contentOffset = CGPointMake(0, -30);
//            }
//        }
//        else{
//
//            if (self.tableView.contentOffset.y>=100) {
//                self.tableView.contentOffset = CGPointMake(0, 100);
//            }
//
//            CGFloat lY = self.tempBgViewCenter.y-self.tableView.contentOffset.y;
//            CGPoint lCenter = CGPointMake(self.tempBgViewCenter.x, lY);
//
//            self.logoBgImgView.center = lCenter;
//        }
//    }
//}

#pragma mark - LazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"e6e6e6"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"portrait"]];
        _imageView.layer.cornerRadius = 50;
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.borderWidth = 3;
        _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _imageView;
}

//-(void)setLayerCornerRadius:(CGFloat)cornerRadius withBorderColor:(UIColor *)borderColor{
//    [self setLayerCornerRadius:cornerRadius withBorderColor:borderColor withBorderWidth:.5];
//}
//
//-(void)setLayerCornerRadius:(CGFloat)cornerRadius withBorderColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth{
//
//    self.layer.cornerRadius = cornerRadius;
//    self.layer.masksToBounds = YES;
//    self.layer.borderColor = borderColor.CGColor;
//    self.layer.borderWidth = borderWidth;
//}
//
//-(void)setLayerShadow:(CGSize)shadowOffset andShadowColor:(UIColor *)shadowColor andShadowOpacity:(CGFloat)shadowOpacity andShadowRadius:(CGFloat)shadowRadius{
//
//    self.layer.shadowOffset = shadowOffset;
//    self.layer.shadowColor = shadowColor.CGColor;
//    self.layer.shadowOpacity = shadowOpacity;
//    self.layer.shadowRadius = shadowRadius;
//    self.layer.masksToBounds = NO;
//}

@end

