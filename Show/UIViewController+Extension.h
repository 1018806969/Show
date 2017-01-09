//
//  UIViewController+Extension.h
//  Show
//
//  Created by txx on 17/1/3.
//  Copyright © 2017年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

/** Gif加载视图，给类目添加属性，需要利用运行时重写set、get方法 */
@property(nonatomic, weak) UIImageView *gifView;
/**
 *  显示GIF加载动画
 *
 *  @param images gif图片数组, 不传的话默认是自带的
 *  @param view   显示在哪个view上, 如果不传默认就是self.view
 */
- (void)showGifLoding:(NSArray *)images inView:(UIView *)view;


/**
 隐藏加载动画
 */
-(void)hideGufLoding;

@end
