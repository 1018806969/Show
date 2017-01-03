//
//  UIImageView+Gif.m
//  Show
//
//  Created by txx on 17/1/3.
//  Copyright © 2017年 txx. All rights reserved.
//

#import "UIImageView+Gif.h"

@implementation UIImageView (Gif)

-(void)playGifAnim:(NSArray *)images
{
    if (images.count) {
        self.animationImages = images ;
        self.animationDuration = 0.5;
        self.animationRepeatCount = 0 ;
        [self startAnimating];
    }
}
-(void)stopGifAnim
{
    if (self.isAnimating) {
        [self stopAnimating];
    }
    [self removeFromSuperview];
}
@end
