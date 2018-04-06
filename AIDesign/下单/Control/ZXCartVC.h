//
//  ZXCartVC.h
//  AIDesign
//
//  Created by xinying on 2018/3/31.
//  Copyright © 2018年 habav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXCartVC : UIViewController

@property(nonatomic,strong) NSMutableDictionary<NSString *, NSMutableArray *> *allGoodsDic;
@property(nonatomic,strong) NSMutableArray *menuArray;
@property(nonatomic,strong) NSMutableArray *goodsArray;
@property(nonatomic,strong) NSMutableArray *searchArray;
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;

@end
