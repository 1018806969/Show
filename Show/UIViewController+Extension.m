//
//  UIViewController+Extension.m
//  Show
//
//  Created by txx on 17/1/3.
//  Copyright © 2017年 txx. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "UIImageView+Gif.h"
#import <objc/message.h>

static const void *GifKey = &GifKey;

@implementation UIViewController (Extension)

-(void)showGifLoding:(NSArray *)images inView:(UIView *)view
{
    if (!images.count) {
        images = @[[UIImage imageNamed:@"hold1"], [UIImage imageNamed:@"hold2"], [UIImage imageNamed:@"hold3"]];
    }
    UIImageView *gifImageView = [[UIImageView alloc]init];
    if (!view) {
        view = self.view ;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [view addSubview:gifImageView];
        
        [gifImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(@0);
            make.width.equalTo(@60);
            make.height.equalTo(@70);
        }];
        self.gifView = gifImageView;
        [gifImageView playGifAnim:images];
    });
}
-(void)hideGufLoding
{
    [self.gifView stopGifAnim];
    self.gifView = nil ;
    
}
-(UIImageView *)gifView
{
    return objc_getAssociatedObject(self, GifKey);
}
-(void)setGifView:(UIImageView *)gifView
{
    objc_setAssociatedObject(self, GifKey, gifView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
