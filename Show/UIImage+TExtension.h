//
//  UIImage+TExtension.h
//  Show
//
//  Created by txx on 16/12/30.
//  Copyright © 2016年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TExtension)


/**
 生成一张高斯模糊图片，默认模糊度为0.5

 @param image 原图
 @param blur 模糊度0-1
 @return 带有高斯模糊效果的图
 */
+ (UIImage *)blurImage:(UIImage *)image blur:(CGFloat)blur;

/**
 生成圆角图片

 @param img 原图
 @param color 边框颜色
 @param width 边框宽度
 @return 圆角图片
 */
+(UIImage *)originImg:(UIImage *)img borderColor:(UIColor *)color borderWidth:(CGFloat)width;

/**
 生成一张某种颜色的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
