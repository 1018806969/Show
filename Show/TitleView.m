//
//  TitleView.m
//  Show
//
//  Created by txx on 16/12/29.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "TitleView.h"

@interface TitleView()

@property(nonatomic,strong)UIButton *hotButton;
@property(nonatomic,strong)UIButton *xinButton;
@property(nonatomic,strong)UIButton *careButton;

@property(nonatomic,strong)UIView   *underLine;

@end

@implementation TitleView
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.hotButton];
        [self addSubview:self.xinButton];
        [self addSubview:self.careButton];
        [self addSubview:self.underLine];
        
        /**
         添加监听，在关注页面中点击看热门，需要展示热门视图，并重置下划线，相当于点击了热门按钮
         */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toSeeWorld) name:@"gotoHot" object:nil];
    }
    return self ;
}
-(void)toSeeWorld
{
    [self selectHomeType:_hotButton];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //默认选中最热
    [self selectHomeType:_hotButton];
}
-(void)selectHomeType:(UIButton *)button
{
    [UIView animateWithDuration:.2 animations:^{
        self.underLine.center = CGPointMake(button.center.x, button.center.y+button.bounds.size.height/2) ;
    }];
    if (self.selectedHomeType) {
        _selectedHomeType(button.tag);
    }
}
-(void)resetUnderLineLocation:(THomeType)homeType
{
    [UIView animateWithDuration:.2 animations:^{
        UIButton *button ;
        if (homeType == 0) {
            button = _hotButton ;
        }else if (homeType == 1)
        {
            button = _xinButton;
        }else
        {
            button = _careButton;
        }
        self.underLine.center = CGPointMake(button.center.x, button.center.y+button.bounds.size.height/2) ;
    }];
}
-(UIButton *)hotButton
{
    if (!_hotButton) {
        _hotButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hotButton setTitle:@"热门" forState:UIControlStateNormal];
        _hotButton.tag = THomeTypeHot;
        _hotButton.frame = CGRectMake(0, 0, self.bounds.size.width/3, self.bounds.size.height);
        [_hotButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
        [_hotButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_hotButton addTarget:self action:@selector(selectHomeType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hotButton;
}
-(UIButton *)xinButton
{
    if (!_xinButton) {
        _xinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_xinButton setTitle:@"最新" forState:UIControlStateNormal];
        _xinButton.tag = THomeTypeNew;
        _xinButton.frame = CGRectMake(self.bounds.size.width/3, 0, self.bounds.size.width/3, self.bounds.size.height);
        [_xinButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
        [_xinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_xinButton addTarget:self action:@selector(selectHomeType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _xinButton;
}
-(UIButton *)careButton
{
    if (!_careButton) {
        _careButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_careButton setTitle:@"关注" forState:UIControlStateNormal];
        _careButton.tag = THomeTypeCare;
        _careButton.frame = CGRectMake(self.bounds.size.width/3 *2, 0, self.bounds.size.width/3, self.bounds.size.height);
        [_careButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
        [_careButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_careButton addTarget:self action:@selector(selectHomeType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _careButton;
}
-(UIView *)underLine
{
    if (!_underLine) {
        _underLine = [[UIView alloc]init];
        _underLine.bounds = CGRectMake(0, 0, self.bounds.size.width/3, 1);
        _underLine.center = CGPointMake(_hotButton.center.x, _hotButton.center.y+_hotButton.bounds.size.height/2) ;
        _underLine.backgroundColor = [UIColor whiteColor];
    }
    return _underLine ;
}
@end
