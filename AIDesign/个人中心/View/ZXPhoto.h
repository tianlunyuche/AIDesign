//
//  ZXPhoto.h
//  paohon
//
//  Created by xinying on 2017/2/25.
//  Copyright © 2017年 habav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXPhoto : NSObject

@property (nonatomic , strong)UIImage *img;
//缩略图
@property (nonatomic , copy) NSString *thumbnail_pic;

//中等尺寸图片地址，没有时返回此字段
@property (nonatomic , copy) NSString *bmiddle_pic;

//原图地址，没有时不返回此字段
@property (nonatomic , copy) NSString *original_pic;

//返回带有文件名的文件路径
- (NSString *)filePath:(NSString *)name;
//删除文件
- (BOOL)removeItemwithPath:(NSString *)FilePath;

//保存图片到 沙盒 ，并显示
- (void)saveImage:(UIImage *)image imageName:(NSString *)name toImagView:(UIImageView *)ImgView;

//改变图像的尺寸 ，方便上传到服务器
- (UIImage *)scaleFromImage: (UIImage *)image toSize:(CGSize)size;

//保持原来的长宽比 ，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;

@end
