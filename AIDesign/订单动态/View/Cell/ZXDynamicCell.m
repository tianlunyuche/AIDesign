//
//  ZXDynamicCell.m
//  AIDesign
//
//  Created by xinying on 2018/4/1.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXDynamicCell.h"

@implementation ZXDynamicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.bgView.layer.shadowOffset = CGSizeMake(3, 5);
    self.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.bgView.layer.shadowOpacity = 0.5;
    self.bgView.layer.shadowRadius = 5;
    self.bgView.layer.masksToBounds = NO;
    
//    CALayer *sublayer1 =[CALayer layer];
//    sublayer1.shadowOffset = shadowOffset;
//    sublayer1.shadowColor = shadowColor.CGColor;
//    sublayer1.shadowOpacity = shadowOpacity;
//    sublayer1.shadowRadius = shadowRadius;
//    sublayer1.masksToBounds = NO;
//    [self.layer insertSublayer:sublayer1 atIndex:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
