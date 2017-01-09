//
//  FooterView.m
//  Show
//
//  Created by txx on 17/1/4.
//  Copyright © 2017年 txx. All rights reserved.
//

#import "FooterView.h"

@interface FooterView()

@end

@implementation FooterView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubButtons];
    }
    return self;
}
-(void)addSubButtons
{
    NSArray *imgs = @[@"talk_public", @"talk_private", @"talk_sendgift", @"talk_rank", @"talk_share", @"talk_close"];
    CGFloat button_w = ScreenWidth/6;
    for (int i = 0; i<6; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i ;
        button.frame = CGRectMake(button_w *i, 0, button_w, 40);
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:imgs[i]] forState:UIControlStateNormal];
        [self addSubview:button];
    }
}
-(void)click:(UIButton *)button
{
    if (_callBack) {
        _callBack(button.tag);
    }
}
@end
