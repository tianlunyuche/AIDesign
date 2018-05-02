//
//  UIImage+Extension.h
//
//
//  Created by xc on 15/3/5.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

//默认边框颜色 为自定义灰色
+ (instancetype)circleImageWithLocalName:(NSString *)name borderWidth:(CGFloat)borderWidth;

//从本地的图片 名字获取图片 并做成圆图
+ (instancetype)circleImageWithLocalName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  把图片裁剪成圆形
 *
 *  @param name        图片 NSString名称
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 圆形有边框的图片
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

//直接传 UImage ，做成圆图片
+ (instancetype)circleImage:(UIImage *)Image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

//直接传 UImage ，做成圆图片 ，borderWidth ，borderColor为默认值
+ (instancetype)circleImage:(UIImage *)Image;
/**
 *  争对ios7以上的系统适配新的图片资源
 *
 *  @param imageName 图片名称
 *
 *  @return 新的图片
 */
+ (UIImage *) imageWithName:(NSString *) imageName;

+ (UIImage *) resizableImageWithName:(NSString *)imageName;

/**
 *  实现图片的缩小或者放大
 *
 *  @param image 原图
 *  @param size  大小范围
 *
 *  @return 新的图片
 */

- (UIImage*) scaleImageWithSize:(CGSize)size;

@end
