//
//  EarView.m
//  Show
//
//  Created by txx on 17/1/3.
//  Copyright © 2017年 txx. All rights reserved.
//

#import "EarView.h"

@interface EarView()

@property(nonatomic,strong)UIView *view;

@property(nonatomic,strong)UIImageView *imgView;

@property(nonatomic,strong)IJKFFMoviePlayerController *moviePlayer;


@end
@implementation EarView
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.view];
        [self addSubview:self.imgView];
    }
    return self;
}
-(void)setLiveModel:(HotLiveModel *)liveModel
{
    _liveModel = liveModel ;
    
    
    // 设置只播放视频, 不播放声音
    // github详解: https://github.com/Bilibili/ijkplayer/issues/1491#issuecomment-226714613
    
    IJKFFOptions *option = [IJKFFOptions optionsByDefault];
    [option setPlayerOptionValue:@"1" forKey:@"an"];
    // 开启硬解码
    [option setPlayerOptionValue:@"1" forKey:@"videotoolbox"];
    _moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:liveModel.flv withOptions:option];
    
    //self在父视图上是添加约束布局的，所以此处的self.bounds为CGRectMake(0, 0, 0, 0)，故不能使用 _moviePlayer.view.frame = self.bounds赋值
    
    _moviePlayer.view.frame = CGRectMake(0, 0, 80, 80);
    // 填充fill
    _moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    // 设置自动播放
    _moviePlayer.shouldAutoplay = YES;
    
    [self.view addSubview:_moviePlayer.view];
    
    [_moviePlayer prepareToPlay];
}
-(void)removeFromSuperview
{
    if (_moviePlayer) {
        [_moviePlayer shutdown];
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer = nil ;
    }
    [super removeFromSuperview];
}





-(UIView *)view
{
    if (!_view) {
        _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        _view.layer.cornerRadius = 40;
        _view.layer.masksToBounds = YES ;
    }
    return _view;
}
-(UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        _imgView.image = [UIImage imageNamed:@"ear"];
    }
    return _imgView ;
}
@end
