//
//  ZXResultTableVC.h
//  AIDesign
//
//  Created by xinying on 2018/1/22.
//  Copyright © 2018年 habav. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BDSASRDefines.h"
#import "BDSASRParameters.h"
#import "BDSEventManager.h"
#import "BDRecognizerViewController.h"
#import "fcntl.h"
#import "BDSWakeupDefines.h"
#import "BDSWakeupParameters.h"

#import "BDVRSettings.h"

@interface ZXResultTableVC : UIViewController<UISearchResultsUpdating>

@property(nonatomic,strong) NSMutableArray *menuArray;
@property(nonatomic,strong) NSMutableArray *goodsArray;

@end
