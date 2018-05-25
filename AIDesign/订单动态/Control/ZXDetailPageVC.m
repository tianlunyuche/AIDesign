//
//  ZXDetailPageVC.m
//  AIDesign
//
//  Created by xinying on 2018/4/5.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXDetailPageVC.h"
#import "ZXStockVC.h"

@interface ZXDetailPageVC ()

@end

@implementation ZXDetailPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuViewStyle = WMMenuViewStyleSegmented;
    self.progressColor = [UIColor redColor];
    self.menuView.lineColor = [UIColor blueColor];
    //    self.menuView.progressHeight = 10;
    self.menuView.backgroundColor = [UIColor blueColor];
    self.automaticallyCalculatesItemWidths = YES;
    self.progressViewIsNaughty = YES;
    //    self.progressWidth = 10;
    //    self.progressViewBottomSpace =10;
    //    self.menuBGColor = [UIColor whiteColor];
    self.progressViewCornerRadius = 30;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 2;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    switch (index) {
        case 0: return @"仓库管理";
    }
    return @"报表";
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    return CGRectMake(leftMargin, 0, self.view.frame.size.width - 2*leftMargin, 44);
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
//    switch (index) {
//        case 0: return [[ZXStockVC alloc] initWithNibName:@"ZXStockVC" bundle:nil];
//    }
    return [[UIViewController alloc] init];
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

#pragma mark - private

- (UIViewController *)parentViewController
{
    for (UIView *next = [self.view superview]; next; next = next.superview) {
        UIResponder *nextResponser = [next nextResponder];
        if ([nextResponser isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponser;
        }
    }
    return nil;
}

@end
