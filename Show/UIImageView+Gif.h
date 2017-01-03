//
//  UIImageView+Gif.h
//  Show
//
//  Created by txx on 17/1/3.
//  Copyright © 2017年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Gif)


// 播放GIF
- (void)playGifAnim:(NSArray *)images;
// 停止动画
- (void)stopGifAnim;

@end
