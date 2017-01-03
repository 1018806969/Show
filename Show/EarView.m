//
//  EarView.m
//  Show
//
//  Created by txx on 17/1/3.
//  Copyright © 2017年 txx. All rights reserved.
//

#import "EarView.h"

@interface EarView()

@property(nonatomic,strong)IJKFFMoviePlayerController *moviePlayer;

@end
@implementation EarView

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
    
    _moviePlayer.view.frame = self.bounds;
    // 填充fill
    _moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    // 设置自动播放
    _moviePlayer.shouldAutoplay = YES;
    
    [self addSubview:_moviePlayer.view];
    
    [_moviePlayer prepareToPlay];
    [_moviePlayer play];
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
@end
