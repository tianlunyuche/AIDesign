//
//  ZXStockPageVC.m
//  AIDesign
//
//  Created by xinying on 2018/5/19.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXStockPageVC.h"

@interface ZXStockPageVC ()

@end

@implementation ZXStockPageVC

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
    self.showOnNavigationBar = NO;
    self.titleColorSelected = [UIColor whiteColor];
    //    self.progressWidth = 10;
    //    self.progressViewBottomSpace =10;
    //    self.menuBGColor = [UIColor whiteColor];
    self.progressViewCornerRadius = 30;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    return [UIViewController new
            ];
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = self.showOnNavigationBar ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
    return CGRectMake(leftMargin, originY, self.view.frame.size.width - 2*leftMargin, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]) +56;
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

@end
