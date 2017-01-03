//
//  UIViewController+Extension.h
//  Show
//
//  Created by txx on 17/1/3.
//  Copyright © 2017年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

/** Gif加载状态 */
@property(nonatomic, weak) UIImageView *gifView;
/**
 *  显示GIF加载动画
 *
 *  @param images gif图片数组, 不传的话默认是自带的
 *  @param view   显示在哪个view上, 如果不传默认就是self.view
 */
- (void)showGifLoding:(NSArray *)images inView:(UIView *)view;


-(void)hideGufLoding;
@end
