//
//  ZXAlertVC.h
//  ZXAlertViewController
//
//  Created by xinying on 2017/1/23.
//  Copyright © 2017年 habav. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZXAlertActionStyle) {
    ZXAlertActionStyleDefault = 0,
    ZXAlertActionStyleCancel,
    ZXAlertActionStyleDestructive
};

typedef NS_ENUM(NSInteger, ZXAlertControllerStyle) {
    ZXAlertControllerStyleActionSheet = 0,
    ZXAlertControllerStyleAlert
};

@interface ZXAlertAction : NSObject

@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) ZXAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;

+ (instancetype _Nullable )actionWithTitle:(NSString *_Nullable)title style:(ZXAlertActionStyle)style handler:(void (^ __nullable)(ZXAlertAction * _Nullable action))handler;

@end

@protocol ZXAlertVCDelegate <NSObject>

-(void)didSelectIndex : (NSInteger) index;

@end

@interface ZXAlertVC : UIViewController

@property(nonatomic,strong) id<ZXAlertVCDelegate> delegate;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *message;

@property (nonatomic, readonly) ZXAlertControllerStyle preferredStyle;

+ (instancetype _Nullable)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(ZXAlertControllerStyle)preferredStyle;

-(void)addAction:(ZXAlertAction *)action;
-(void)removeAllAction;

-(void)show;
@end
