//
//  ZXSexView.h
//  paohon
//
//  Created by xinying on 2017/4/15.
//  Copyright © 2017年 habav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXSexView : UIView

@property (nonatomic, strong) UILabel * sexlabel;

@property (nonatomic,strong)UIImageView* Circle;

@property (nonatomic,strong)UIImageView* Pic;

- (void)creatSexViewwithSex:(NSString *)label btnImage:(NSString *)btnImage SexImage:(NSString *)sexImg;

@end
