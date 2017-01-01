//
//  UIImage+TExtension.m
//  Show
//
//  Created by txx on 16/12/30.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "UIImage+TExtension.h"

@implementation UIImage (TExtension)


+(UIImage *)originImg:(UIImage *)img borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    //原图片的宽度
    CGFloat imgW = img.size.width ;
    //计算外接圆的直径
    CGFloat ovalW = imgW + 2 * width;
    
    //开启绘图上下文
    UIGraphicsBeginImageContextWithOptions(img.size, NO, 0);
    //画一个大的圆形
    UIBezierPath *paht = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalW, ovalW)];
    [color set];
    [paht fill];
    //设置裁定区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(width, width, imgW, imgW)];
    [clipPath addClip];
    //绘制图片
    [img drawAtPoint:CGPointMake(width, width)];
    
    //从上下文获取绘制的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image ;
    
    
}
@end
