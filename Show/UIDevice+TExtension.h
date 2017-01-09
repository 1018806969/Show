//
//  UIDevice+TExtension.h
//  Show
//
//  Created by txx on 16/12/29.
//  Copyright © 2016年 txx. All rights reserved.
//
//UIDevice的类目

#import <UIKit/UIKit.h>

@interface UIDevice (TExtension)

/**
 判断当前设备类型、及版本、模拟器、真机

 @return 当前设备的类型及版本
 */
+(NSString *)deviceVersion;

@end
