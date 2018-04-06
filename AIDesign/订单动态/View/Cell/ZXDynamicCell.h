//
//  ZXDynamicCell.h
//  AIDesign
//
//  Created by xinying on 2018/4/1.
//  Copyright © 2018年 habav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXDynamicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *code;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *seller;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
