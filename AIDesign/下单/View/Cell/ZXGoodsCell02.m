//
//  ZXGoodsCell02.m
//  AIDesign
//
//  Created by xinying on 2018/3/31.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXGoodsCell02.h"

@implementation ZXGoodsCell02

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.numTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.numTextField.delegate = self;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.numTextField.text = @"";
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    [self.numTextField resignFirstResponder];
    if (self.judgeWhenEndEditing) {
        self.judgeWhenEndEditing();
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.superview endEditing:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
