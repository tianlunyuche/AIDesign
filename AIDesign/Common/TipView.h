//
//  TipView.h
//  paohon_v1_0
//
//  Created by xinying on 2017/1/17.
//  Copyright © 2017年 paohon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipView : UIView

@property(retain,nonatomic)  UIView* vw;

@property(retain,nonatomic)    NSTimer* timer;

@property(nonatomic,strong)UIImageView* tipImageView;

@property(retain,nonatomic)UILabel* tipLabel;
@end
