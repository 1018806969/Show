//
//  NewCollectionViewCell.m
//  Show
//
//  Created by txx on 17/1/4.
//  Copyright © 2017年 txx. All rights reserved.
//

#import "NewCollectionViewCell.h"

@interface NewCollectionViewCell()

@property (strong, nonatomic) UIImageView *coverImgView;
@property (strong, nonatomic) UIImageView *starImgView;
@property (strong, nonatomic) UIButton *locationButton;
@property (strong, nonatomic) UILabel *nickNameLabel;


@end

@implementation NewCollectionViewCell

/**
 自定义cell时，通过重写-(instancetype)initWithFrame:(CGRect)frame
 初始化方法添加子控件，而-(instancetype)init方法不会被调用
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.coverImgView];
        [self addSubview:self.starImgView];
        [self addSubview:self.locationButton];
        [self addSubview:self.nickNameLabel];
        self.backgroundColor = [UIColor grayColor];
        [self layout];
    }
    return self ;
}
-(void)setAnchor:(NewAnchorModel *)anchor
{
    _anchor = anchor ;
//    _coverImgView.contentMode = UIViewContentModeRedraw;
    [_coverImgView sd_setImageWithURL:[NSURL URLWithString:anchor.photo] placeholderImage:[UIImage imageNamed:@"header"]];
    self.starImgView.hidden = !anchor.newStar;
    [self.locationButton setTitle:anchor.position forState:UIControlStateNormal];
    self.nickNameLabel.text = anchor.nickname;
}
-(UIImageView *)coverImgView
{
    if(_coverImgView) return _coverImgView;
    
    _coverImgView = [[UIImageView alloc]init];
    _coverImgView.image = [UIImage imageNamed:@"header"];
    return _coverImgView;
}
-(UIImageView *)starImgView
{
    if(_starImgView) return _starImgView;
    
    _starImgView = [[UIImageView alloc]init];
    _starImgView.image = [UIImage imageNamed:@"new"];
    return _starImgView;
}
-(UILabel *)nickNameLabel
{
    if(_nickNameLabel) return _nickNameLabel;
    
    _nickNameLabel = [[UILabel alloc]init];
    return _nickNameLabel;
}
-(UIButton *)locationButton
{
    if(_locationButton) return _locationButton;
    
    _locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_locationButton setImage:[UIImage imageNamed:@"location_white"] forState:UIControlStateNormal];
    _locationButton.titleLabel.font = [UIFont systemFontOfSize:12];
    return _locationButton;
}
-(void)layout
{
    [_coverImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [_starImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(17);
        make.width.mas_equalTo(33);
    }];
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [_locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(5);
    }];
}

@end
