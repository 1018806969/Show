//
//  LoginViewController.m
//  Show
//
//  Created by txx on 16/12/28.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "LoginViewController.h"
//#import <IJKMediaFramework/IJKMediaFramework.h>
#import "LoginView.h"
#import "TarBarController.h"

@interface LoginViewController ()

/**
 Player
 */
@property (nonatomic, strong) IJKFFMoviePlayerController *player;

@property(nonatomic,strong)LoginView                     *loginView;

@end

@implementation LoginViewController
-(void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playDidFinished) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerLoadStateDidChanged) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:nil];
    
    [self.view addSubview:self.player.view];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.player shutdown];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.player.view removeFromSuperview];
    self.player = nil ;
}


-(void)loginSuccessed
{
    NSLog(@"login sccessed");
    [self presentViewController:[[TarBarController alloc] init] animated:YES completion:^{
        [self.player stop];
        [self.player.view removeFromSuperview];
        self.player = nil ;
    }];
}
/**
 加载状态改变的通知
 */
-(void)playerLoadStateDidChanged
{
    if ((self.player.loadState & IJKMPMovieLoadStatePlaythroughOK) == 0) return ;
        if (self.player.isPlaying) return ;
        [self.player play];
}
/**
 播放完成之后重复
 */
-(void)playDidFinished
{
    [self.player play];
}
-(IJKFFMoviePlayerController *)player
{
    if (!_player) {
        //随机播放一组视频
        NSString *name = arc4random_uniform(10) % 2 ? @"login_video" : @"loginmovie";
        NSString *url = [[NSBundle mainBundle]pathForResource:name ofType:@"mp4"];
        
        _player = [[IJKFFMoviePlayerController alloc]initWithContentURLString:url withOptions:[IJKFFOptions optionsByDefault]];
        _player.view.frame = self.view.bounds;
        // 填充fill
        _player.scalingMode = IJKMPMovieScalingModeAspectFill;
        _player.shouldAutoplay = NO;
        [_player prepareToPlay];
        [_player.view addSubview:self.loginView];
    }
    return _player ;
}
-(LoginView *)loginView
{
    if (!_loginView) {
        _loginView = [[LoginView alloc]initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, 268)];
        __weak typeof(self) weakSelf = self ;
        _loginView.loginSelected = ^(TLoginType loginType)
        {
            NSLog(@"login type = %ld",(long)loginType);
            [weakSelf loginSuccessed];
        };
    }
    return _loginView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
