//
//  ZXRegisterVC.h
//  AIDesign
//
//  Created by xinying on 2018/3/29.
//  Copyright © 2018年 habav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXCountryCodeVC.h"
#import "RegisterContentView.h"
#import "TipView.h"
//#import<CommonCrypto/CommonDigest.h>
////手机短信验证码
//#import <SMS_SDK/SMSSDK.h>

@interface ZXRegisterVC : UIViewController <ZXCountryCodeDelegate>
@property(nonatomic,strong)  RegisterContentView *contentView;
@property(retain,nonatomic)NSTimer* timer;
@property(retain,nonatomic)  TipView* vw;

- (BOOL)judge;
- (NSString *)getZone;
@end
