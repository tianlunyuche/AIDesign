//
//  ZXEditView.m
//  AIDesign
//
//  Created by xinying on 2018/3/26.
//  Copyright © 2018年 habav. All rights reserved.
//

#import "ZXEditView.h"

@implementation ZXEditView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.numTextFiled.delegate = self;
    self.numTextFiled.keyboardType = UIKeyboardTypeDecimalPad;
}
- (IBAction)sureSelect:(id)sender {
    if (self.sureBtnSelect) {
        self.sureBtnSelect(self.numTextFiled.text);
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.numTextFiled resignFirstResponder];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.numTextFiled resignFirstResponder];
}

@end
