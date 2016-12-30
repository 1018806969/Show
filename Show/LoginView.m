
//
//  LoginView.m
//  Show
//
//  Created by txx on 16/12/28.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *sina = [self creatImageView:@"sina" tag:TLoginTypeSina];
        UIImageView *qq = [self creatImageView:@"qq" tag:TLoginTypeQQ];
        UIImageView *wechat = [self creatImageView:@"wechat" tag:TLoginTypeWeChat];
        
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = [UIColor clearColor];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor yellowColor].CGColor;
        [btn setTitle:@"ALin快速通道" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor yellowColor]  forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(fastLogin) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];

        
        [self addSubview:sina];
        [self addSubview:qq];
        [self addSubview:wechat];
        
        [sina mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.height.equalTo(@60);
        }];
        
        [qq mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(sina);
            make.right.equalTo(sina.mas_left).offset(-20);
            make.size.equalTo(sina);
        }];
        
        [wechat mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(sina);
            make.left.equalTo(sina.mas_right).offset(20);
            make.size.equalTo(sina);
        }];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).offset(-40);
        }];

    }
    return self ;
}
- (UIImageView *)creatImageView:(NSString *)imageName tag:(NSUInteger)tag
{
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:imageName];
    imageV.tag = tag;
    imageV.userInteractionEnabled = YES;
    [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)]];
    return imageV;
}
- (void)click:(UITapGestureRecognizer *)tapRec
{
    if (self.loginSelected) {
        self.loginSelected(tapRec.view.tag);
    }
}
-(void)fastLogin
{
    if (self.loginSelected) {
        self.loginSelected(TLoginTypeFast);
    }
}
@end
