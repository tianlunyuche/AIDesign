//
//  ZXOrderDetailVC.h
//  AIDesign
//
//  Created by xinying on 2018/4/1.
//  Copyright © 2018年 habav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXOrders.h"

@interface ZXOrderDetailVC : UIViewController

@property(nonatomic,strong) NSMutableArray *ordersArray;
@property(nonatomic,strong) ZXOrder *order;
@property(nonatomic,assign) NSInteger row;
@end
