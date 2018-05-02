//
//  UIImage+Extension.m
//  新浪微博
//
//  Created by xc on 15/3/5.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "UIImage+Extension.h"
#import "ZXPhoto.h"

@implementation UIImage (Extension)



//默认边框颜色 为自定义灰色
+ (instancetype)circleImageWithLocalName:(NSString *)name borderWidth:(CGFloat)borderWidth{
    
   return [self circleImageWithLocalName:name borderWidth:borderWidth borderColor:[UIColor colorWithRed:202 /250 green:202/250 blue:202/250 alpha:1]];
}

//从本地的图片 名字获取图片 并做成圆图
+ (instancetype)circleImageWithLocalName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath =[documentsDirectory stringByAppendingPathComponent:name];
    
    //加载原图
    UIImage* oldImage =[UIImage imageWithContentsOfFile:imageFilePath];
    
     return [self circleImage:oldImage borderWidth:borderWidth borderColor:borderColor];
}
/**
 *  把图片裁剪成圆形
 *
 *  @param name        图片 NSString名称
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 圆形有边框的图片
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    //1, 加载原图
    UIImage* oldImage =[UIImage imageNamed:name];
    
    return [self circleImage:oldImage borderWidth:borderWidth borderColor:borderColor];
}

+ (instancetype)circleImage:(UIImage *)Image{
    
    return [self circleImage:Image borderWidth:0.1f borderColor:ZXcolor(202,202,202)];
//    return [self circleImage:Image withParam:0];
}

+ (UIImage*)circleImage:(UIImage*)image withParam:(CGFloat)inset {
    
    UIGraphicsBeginImageContext(image.size);

    CGContextRef context =UIGraphicsGetCurrentContext();
    
    //圆的边框宽度为2，颜色为红色
    CGContextSetLineWidth(context,2);
    
    CGContextSetStrokeColorWithColor(context,ZXcolor(202,202,202).CGColor);
    
//    CGRect rect = CGRectMake(inset, inset, image.size.width - inset *2.0f, image.size.height - inset *2.0f);
     CGRect rect = CGRectMake(inset, inset, 100.0f , 505.0f);
    CGContextAddEllipseInRect(context, rect);
    
    CGContextClip(context);
    
    //在圆区域内画出image原图
    [image drawInRect:rect];
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextStrokePath(context);
    
    //生成新的image
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newimg;
    
}

//直接传 UImage ，做成圆图片
+ (instancetype)circleImage:(UIImage *)Image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    //1, 加载原图
    UIImage* oldImage =Image;
    //2,开启上下文
    // imageSize ,为整体大小
    CGFloat imageW =100 -10 *borderWidth;
    CGFloat imageH =100 -10 *borderWidth;
    CGSize imageSize =CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    //3,取得当前的上下文
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    
    [borderColor set];
    //4, 画圆 ，如果 borderWidth =0 那就是 最大圆了
    CGFloat bigRadius =imageW *0.5;
    CGFloat centerX =bigRadius;     //圆心
    CGFloat centerY =bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI *2, 0);
    CGContextFillPath(ctx);         //画圆
    
    if (borderWidth) {
        CGFloat Radius =imageW *0.5 -borderWidth;
        centerX =Radius;     //圆心
        centerY =Radius;
        CGContextAddArc(ctx, centerX, centerY, Radius, 0, M_PI *2, 0);
        //裁剪
        CGContextClip(ctx);
    }
    //6,画图片 ，对要放的图进行绘画
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, imageW ,imageH)];
    //后来添加的
    CGContextAddEllipseInRect(ctx, CGRectMake(borderWidth, borderWidth, imageW ,imageH));
    CGContextStrokePath(ctx);
    
    //7,取图
    UIImage *newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


+ (UIImage *)imageWithName:(NSString *)imageName
{
    UIImage *newImage = nil;
//    if (iOS7) {
//        newImage = [UIImage imageNamed:[imageName stringByAppendingString:@"_os7"]];
//    }
    if (newImage == nil) {
        newImage = [UIImage imageNamed:imageName];
    }
    return newImage;
}

+ (UIImage *)resizableImageWithName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    // 获取原有图片的宽高的一半
    CGFloat w = image.size.width * 0.5;
    CGFloat h = image.size.height * 0.5;
    
    // 生成可以拉伸指定位置的图片
    UIImage *newImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
    
    return newImage;
}


-(UIImage*) scaleImageWithSize:(CGSize)size{
    
    UIGraphicsBeginImageContextWithOptions(size,NO,0);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}
@end
