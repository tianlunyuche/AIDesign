//
//  ZXCountryCodeVC.h
//  paohon
//
//  Created by xinying on 2016/6/25.
//  Copyright © 2017年 habav. All rights reserved.
//

#import <UIKit/UIKit.h>

//代理传值
@protocol ZXCountryCodeDelegate <NSObject>

@optional
-(void)returnCountryCode:(NSString *)countryCode;

@end

//block传值
typedef void(^returnCountryCodeBlock) (NSString *countryCodeStr);

@interface ZXCountryCodeVC : UIViewController

@property(nonatomic,weak)id <ZXCountryCodeDelegate>delegate;

@property(nonatomic,copy)returnCountryCodeBlock returnCountryCodeBlock;
//block声明方法
-(void)toReturnCountryCode:(returnCountryCodeBlock)block;

@end
