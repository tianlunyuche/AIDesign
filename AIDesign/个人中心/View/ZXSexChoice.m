//
//  ZXSexChoice.m
//  paohon
//
//  Created by xinying on 2017/4/15.
//  Copyright © 2017年 habav. All rights reserved.
//

#import "ZXSexChoice.h"

@implementation ZXSexChoice

static ZXSexChoice *man;
static ZXSexChoice *woman;

+ (ZXSexChoice *)sharedman{

    man =[[ZXSexChoice alloc] init];
    man.label =@"男";
    man.btnImage =@"radio_btn_n";
    man.sexImg =@"male_icon_n";
    
    return man;
}

+ (ZXSexChoice *)sharedwoman{
    
    woman =[[ZXSexChoice alloc] init];
    woman.label =@"女";
    woman.btnImage =@"radio_btn_n";
    woman.sexImg =@"female_icon_n";
    
    return woman;
}

- (void)manSelected{
    
    man.btnImage =@"radio_btn_p";
    man.sexImg =@"male_icon_s";
}

- (void)manDiselected{
    
    man.btnImage =@"radio_btn_n";
    man.sexImg =@"male_icon_n";
}

- (void)womanSelected{
    
    woman.btnImage =@"radio_btn_p";
    woman.sexImg =@"female_icon_s";
}

- (void)womanDiselected{
    
    woman.btnImage =@"radio_btn_n";
    woman.sexImg =@"female_icon_n";
}


@end
