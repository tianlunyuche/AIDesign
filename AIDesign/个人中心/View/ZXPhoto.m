//
//  ZXPhoto.m
//  paohon
//
//  Created by xinying on 2017/2/25.
//  Copyright © 2017年 habav. All rights reserved.
//

#import "ZXPhoto.h"

@interface ZXPhoto ()

@property (nonatomic, strong)NSString *imageFilePath;

@end

@implementation ZXPhoto

//- (void)setThumbnail_pic:(NSString *)thumbnail_pic {
//
//
//    _thumbnail_pic = [thumbnail_pic copy];
//    self.bmiddle_pic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
//}

- (NSString *)filePath:(NSString *)name{

    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:name];
}

- (BOOL)removeItemwithPath:(NSString *)FilePath{
    
    BOOL success;
    NSError *error;
    if([[NSFileManager defaultManager] fileExistsAtPath:FilePath]) {
        success = [[NSFileManager defaultManager] removeItemAtPath:FilePath error:&error];
    }
    return success;
}

//保存图片到 沙盒 ，并显示
- (void)saveImage:(UIImage *)image imageName:(NSString *)name toImagView:(UIImageView *)ImgView{


    _imageFilePath =[self filePath:name];
    NSLog(@"_imageFilePath =%@",_imageFilePath);
    
    [self removeItemwithPath:_imageFilePath];
    
    //    UIImage *smallImage=[self scaleFromImage:image toSize:CGSizeMake(80.0f, 80.0f)];//将图片尺寸改为80*80
    
    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(93, 93)];
    
    //[UIImageJPEGRepresentation(smallImage, 1.0f) writeToFile:_imageFilePath atomically:YES];//写入文件
    [UIImagePNGRepresentation(smallImage) writeToFile:_imageFilePath atomically:YES];
    //读取图片
    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:_imageFilePath];
    //将图片放到 视图中
     ImgView.image =selfPhoto;
}

//改变图像的尺寸 ，方便上传到服务器
- (UIImage *)scaleFromImage: (UIImage *)image toSize:(CGSize)size{
    //根据图像上下文，绘制图形
    UIGraphicsBeginImageContext(size);
    //绘制后的大小
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//保持原来的长宽比 ，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage* newimage;
    if (image ==nil) {
        newimage =nil;
    }
    else {
        CGSize oldsize =image.size;
        CGRect rect;
        if(asize.width/asize.height > oldsize.width /oldsize.height){
            rect.size.width =asize.height * oldsize.width /oldsize.height   ;
            rect.size.height =asize.height;
            rect.origin.x =(asize.width - rect.size.width) /2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

@end
