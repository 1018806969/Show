//
//  HotLiveCell.m
//  Show
//
//  Created by txx on 16/12/30.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "HotLiveCell.h"
#import "UIImage+TExtension.h"

@interface HotLiveCell()

@property(nonatomic,strong)UIImageView             *headImageView;
@property(nonatomic,strong)UIButton                *locationButton;
@property(nonatomic,strong)UILabel                 *namelabel;
@property(nonatomic,strong)UIImageView             *starImageView;
@property(nonatomic,strong)UIImageView             *bgImageView;
@property(nonatomic,strong)UILabel                 *watchLabel;

@property(nonatomic,strong)UIView                  *upView;

@end

@implementation HotLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self addSubview:self.upView];
        [self addSubview:self.bgImageView];
        
        [self layout];
    }
    return self ;
}
-(void)setLiveModel:(HotLiveModel *)liveModel
{
    _liveModel = liveModel ;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:liveModel.smallpic] placeholderImage:[UIImage imageNamed:@"header"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        image = [UIImage originImg:image borderColor:[UIColor blackColor] borderWidth:2];
        self.headImageView.image = image ;
    }];
    self.namelabel.text = liveModel.myname ;
    
    [self.locationButton setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [self.locationButton setTitle:liveModel.gps forState:UIControlStateNormal];
    [self.locationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:liveModel.bigpic] placeholderImage:[UIImage imageNamed:@"user"]];
    self.starImageView.image  = liveModel.starImage;
    self.starImageView.hidden = !liveModel.starlevel;

    NSString *watchNum = [NSString stringWithFormat:@"%ld人在看", liveModel.allnum];
    NSRange range = [watchNum rangeOfString:[NSString stringWithFormat:@"%ld", liveModel.allnum]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:watchNum];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range: range];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    self.watchLabel.attributedText = attr;

}
-(void)layout
{
    [_upView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.bottom.equalTo(_bgImageView.mas_top);
        make.height.mas_equalTo(45);
    }];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.mas_equalTo(-10);
    }];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(3);
        make.width.and.height.mas_equalTo(39);
    }];
    [_namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(10);
        make.top.mas_equalTo(3);
    }];
    [_starImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_namelabel.mas_right).offset(5);
        make.top.mas_equalTo(3);
        make.height.equalTo(_namelabel);
        make.width.mas_equalTo(40);
    }];
    [_locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(10);
        make.top.equalTo(_namelabel.mas_bottom).offset(0);
    }];
    [_watchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.equalTo(_upView);
    }];
}
-(UIView *)upView
{
    if (!_upView) {
        _upView = [[UIView alloc]init];
        _upView.backgroundColor = [UIColor whiteColor];
        [_upView addSubview:self.headImageView];
        [_upView addSubview:self.namelabel];
        [_upView addSubview:self.locationButton];
        [_upView addSubview:self.starImageView];
        [_upView addSubview:self.watchLabel];
    }
    return _upView ;
}
-(UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
    }
    return _headImageView;
}
-(UIImageView *)starImageView
{
    if (!_starImageView) {
        _starImageView = [[UIImageView alloc]init];
    }
    return _starImageView;
}
-(UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
    }
    return _bgImageView;
}
-(UIButton *)locationButton
{
    if (!_locationButton) {
        _locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_locationButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    return _locationButton;
}
-(UILabel *)namelabel
{
    if (!_namelabel) {
        _namelabel = [[UILabel alloc]init];
    }
    return _namelabel ;
}
-(UILabel *)watchLabel
{
    if (!_watchLabel) {
        _watchLabel = [[UILabel alloc]init];
    }
    return _watchLabel ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
