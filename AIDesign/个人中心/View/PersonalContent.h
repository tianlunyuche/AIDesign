//
//  PersonalContent.h
//  paohon_v1_0
//
//  Created by xinying on 2017/1/19.
//  Copyright © 2017年 paohon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "ZXSexView.h"
#import "ZXSexChoice.h"

@interface PersonalContent : UIScrollView{
    
}

//- (void)creatUI:(UIScrollView *)ScrollView;

@property (nonatomic, strong) UILabel * infolabel;

@property (nonatomic,strong)UIImageView* Imgview;

//头像视图
@property(nonatomic, strong) UIImageView *avatarImgView;

@property(nonatomic,strong)UITapGestureRecognizer *singleTap;

@property (nonatomic, strong)UITextField * usern;

@property (nonatomic, strong)UITextField * trueName;


@property (nonatomic, strong)ZXSexView *manView;
@property (nonatomic, strong)ZXSexChoice *manChoice;

@property (nonatomic, strong)ZXSexView *womanView;
@property (nonatomic, strong)ZXSexChoice *womanChoice;

//体重身高
@property (nonatomic, strong)UITextField *weighfld;
@property (nonatomic, strong)UILabel *weighlabel;

@property (nonatomic, strong)UILabel *heighname;
@property (nonatomic, strong)UITextField *heighfld;
@property (nonatomic, strong)UILabel *heighlabel;

@property (nonatomic,strong)UIView* birthView;
@property (nonatomic, strong)UILabel *birthlabel;

@property (nonatomic, strong)UITextField *qqfld;

@property (nonatomic, strong)UITextField *mailfld;

@property (nonatomic, strong)UILabel *pholabel;

@property (nonatomic, strong)UIButton *postBtn;

- (void)Sexselected:(int)sex;

@end
