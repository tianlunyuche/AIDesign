//
//  ZXPageController.m
//  AIDesign
//
//  Created by xinying on 2018/3/28.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXPageController.h"
#import "ZXStockVC.h"
#import "ZXReportVC.h"
#import "ZXDynamicVC.h"
#import "ZXReportListVC.h"

@interface ZXPageController ()

@end

@implementation ZXPageController

-(void)loadView {
    [super loadView];
    self.menuViewStyle = WMMenuViewStyleSegmented;
    self.progressColor = [UIColor redColor];
    self.menuView.lineColor = [UIColor blueColor];
    self.menuBGColor = [UIColor clearColor];
    //    self.menuView.progressHeight = 10;
    self.menuView.backgroundColor = [UIColor clearColor];
    self.automaticallyCalculatesItemWidths = YES;
    self.progressViewIsNaughty = YES;
    self.showOnNavigationBar = !self.isHiddenBar;
    self.titleColorSelected = [UIColor whiteColor];
    //    self.progressWidth = 10;
    //    self.progressViewBottomSpace =10;
    //    self.menuBGColor = [UIColor whiteColor];
    self.progressViewCornerRadius = 30;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 3;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    switch (index) {
        case 0: return @"仓库管理";
        case 1: return @"报表";
    }
    return @"历史订单";
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0: return [[ZXStockVC alloc] initWithNibName:@"ZXStockVC" bundle:nil];
        case 1: return [[ZXReportListVC alloc] initWithNibName:@"ZXReportListVC" bundle:nil];
    }
    ZXDynamicVC *vc = [[ZXDynamicVC alloc] init];
    vc.isAllOrder = YES;
    return vc;
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

@end
