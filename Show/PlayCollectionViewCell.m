//
//  PlayCollectionViewCell.m
//  Show
//
//  Created by txx on 17/1/4.
//  Copyright © 2017年 txx. All rights reserved.
//

#import "PlayCollectionViewCell.h"
#import "HotLiveModel.h"
#import "UIViewController+Extension.h"
#import "TXNetworkTool.h"
#import "EarView.h"
#import "UIImage+TExtension.h"
#import "FooterView.h"


#import <SDWebImageDownloader.h>

@interface PlayCollectionViewCell()

@property(nonatomic,strong)IJKFFMoviePlayerController *moviePlayer;
/**
 占位图片，在加载过程中展示，加载成功取消
 */
@property(nonatomic,strong)UIImageView                *placeHolderImgView;
/**
 下一个主播
 */
@property(nonatomic,strong)EarView                    *earView;
/**
 粒子动画
 */
@property(nonatomic,strong)CAEmitterLayer *emitterLayer;

@property(nonatomic,strong)FooterView     *footView;



@end

@implementation PlayCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.placeHolderImgView];
        [self.contentView addSubview:self.footView];
    }
    return self;
}
-(void)setRelateLiveModel:(HotLiveModel *)relateLiveModel
{
    _relateLiveModel = relateLiveModel;
    // 设置相关主播
    if (relateLiveModel) {
        self.earView.liveModel = relateLiveModel;
    }else{
        self.earView.hidden = YES;
    }
}
-(void)setLiveModel:(HotLiveModel *)liveModel
{
    _liveModel = liveModel ;
    
    [self plarFLV:liveModel.flv placeHolderUrl:liveModel.bigpic];
    
}
-(void)plarFLV:(NSString *)flv placeHolderUrl:(NSString *)placeHolderUrl
{
    if (_moviePlayer) {
        [self.contentView bringSubviewToFront:self.placeHolderImgView];
        if (_earView) {
            [_earView removeFromSuperview];
            _earView = nil ;
        }
        [_moviePlayer shutdown];
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer = nil ;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    if (_emitterLayer) {
        [_emitterLayer removeFromSuperlayer];
    }
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:placeHolderUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.parentVc showGifLoding:nil inView:self.placeHolderImgView];
            self.placeHolderImgView.image = [UIImage blurImage:image blur:0.8];
        });
    }];
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1 forKey:@"videotoolbox"];
    // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    // -vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    
    _moviePlayer = [[IJKFFMoviePlayerController alloc]initWithContentURLString:flv withOptions:options];
    _moviePlayer.view.frame = self.contentView.bounds;
    _moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    _moviePlayer.shouldAutoplay = NO ;
    _moviePlayer.shouldShowHudView = NO ;
    [self.contentView insertSubview:_moviePlayer.view atIndex:0];
    [_moviePlayer prepareToPlay];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playDidFinished) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
    
    [self.moviePlayer.view.layer insertSublayer:self.emitterLayer above:self.earView.layer];

}
-(void)stateDidChange
{
    if ((self.moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.moviePlayer.isPlaying) {
            [self.moviePlayer play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.contentView bringSubviewToFront:_moviePlayer.view];
                [self.parentVc hideGufLoding];
            });
        }else{
            // 如果是网络状态不好, 断开后恢复, 也需要去掉加载
            if (self.parentVc.gifView.isAnimating) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.parentVc hideGufLoding];
                });
                
            }
        }
    }else if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled){ // 网速不佳, 自动暂停状态
        [self.parentVc showGifLoding:nil inView:self.moviePlayer.view];
    }
}
-(void)playDidFinished
{
    NSLog(@"加载状态...%ld %ld %s", self.moviePlayer.loadState, self.moviePlayer.playbackState, __func__);
    // 因为网速或者其他原因导致直播stop了, 也要显示GIF
    if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled && !self.parentVc.gifView) {
        [self.parentVc showGifLoding:nil inView:self.moviePlayer.view];
        return;
    }
    //    方法：
    //      1、重新获取直播地址，服务端控制是否有地址返回。
    //      2、用户http请求该地址，若请求成功表示直播未结束，否则结束
    __weak typeof(self)weakSelf = self;
    [[TXNetworkTool shareNetworkTool] GET:self.liveModel.flv parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功%@, 等待继续播放", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败, 加载失败界面, 关闭播放器%@", error);
        [weakSelf.moviePlayer shutdown];
        [weakSelf.moviePlayer.view removeFromSuperview];
        weakSelf.moviePlayer = nil;
    }];

}








-(UIImageView *)placeHolderImgView
{
    if (!_placeHolderImgView) {
        _placeHolderImgView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
        _placeHolderImgView.image = [UIImage imageNamed:@"profile"];
    }
    return _placeHolderImgView ;
}
-(EarView *)earView
{
    if (!_earView) {
        _earView = [[EarView alloc]init];
        [self.moviePlayer.view addSubview:_earView];
        [_earView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(80);
            make.centerY.mas_equalTo(_moviePlayer.view);
            make.right.mas_equalTo(-30);
        }];
        [_earView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCatEar)]];
    }
    return _earView ;
}
-(void)clickCatEar
{
    if (self.clickRelatedLive) {
        self.clickRelatedLive();
    }
}
-(CAEmitterLayer *)emitterLayer
{
    if (_emitterLayer) return  _emitterLayer;
    
    _emitterLayer = [CAEmitterLayer layer];
    [_emitterLayer setHidden:NO];
    // 发射器在xy平面的中心位置
    _emitterLayer.emitterPosition = CGPointMake(self.moviePlayer.view.frame.size.width-50,self.moviePlayer.view.frame.size.height-50);
    // 发射器的尺寸大小
    _emitterLayer.emitterSize = CGSizeMake(20, 20);
    // 渲染模式
    _emitterLayer.renderMode = kCAEmitterLayerUnordered;
    // 开启三维效果
    //    _emitterLayer.preservesDepth = YES;
    NSMutableArray *array = [NSMutableArray array];
    // 创建粒子
    for (int i = 0; i<10; i++) {
        // 发射单元
        CAEmitterCell *stepCell = [CAEmitterCell emitterCell];
        // 粒子的创建速率，默认为1/s
        stepCell.birthRate = 1;
        // 粒子存活时间
        stepCell.lifetime = arc4random_uniform(4) + 1;
        // 粒子的生存时间容差
        stepCell.lifetimeRange = 1.5;
        // 颜色
        // fire.color=[[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d", i]];
        // 粒子显示的内容
        stepCell.contents = (id)[image CGImage];
        // 粒子的名字
        //            [fire setName:@"step%d", i];
        // 粒子的运动速度
        stepCell.velocity = arc4random_uniform(100) + 100;
        // 粒子速度的容差
        stepCell.velocityRange = 80;
        // 粒子在xy平面的发射角度
        stepCell.emissionLongitude = M_PI+M_PI_2;;
        // 粒子发射角度的容差
        stepCell.emissionRange = M_PI_2/6;
        // 缩放比例
        stepCell.scale = 0.3;
        [array addObject:stepCell];
    }
    _emitterLayer.emitterCells = array;
    return _emitterLayer;
    
}
-(FooterView *)footView
{
    if (!_footView) {
#warning ----------------start-----------
    }
    return _footView ;
}
@end
