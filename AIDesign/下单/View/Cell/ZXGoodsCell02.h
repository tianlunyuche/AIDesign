//
//  ZXGoodsCell02.h
//  AIDesign
//
//  Created by xinying on 2018/3/31.
//  Copyright © 2018年 habav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXGoodsCell02 : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *code;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *soldOut;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *unit;
@property (weak, nonatomic) IBOutlet UITextField *numTextField;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;

@property(nonatomic,copy) void (^judgeWhenEndEditing)(void);

@end
