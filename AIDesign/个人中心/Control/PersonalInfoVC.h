//
//  PersonalInfoVC.h
//  paohon_v1_0
//
//  Created by xinying on 2017/1/17.
//  Copyright © 2017年 paohon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "PersonalContent.h"

@interface PersonalInfoVC : UIViewController

@property (nonatomic, strong)PersonalContent* personView;

@property(strong,atomic)NSString* uId;

@property (weak, nonatomic)UIImageView *imageView;
//上传进度条
@property (weak, nonatomic)UIProgressView *progressView;

@end
