//
//  ZXEditView.h
//  AIDesign
//
//  Created by xinying on 2018/3/26.
//  Copyright © 2018年 habav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXEditView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *numTextFiled;
@property (weak, nonatomic) IBOutlet UILabel *unit;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property(nonatomic,strong) NSIndexPath *indexPath;

@property(nonatomic,copy) void (^sureBtnSelect)(NSString *num);
@end
