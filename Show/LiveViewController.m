//
//  LiveViewController.m
//  Show
//
//  Created by txx on 16/12/29.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "LiveViewController.h"
#import <LFLiveKit.h>
#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define KeyColor Color(216, 41, 116)

@interface LiveViewController ()<LFLiveSessionDelegate>

/**
 是否美颜，默认为美颜
 */
@property(nonatomic,strong)UIButton *beautifulButton;
/**
 前后摄像头转换，默认为后摄
 */
@property(nonatomic,strong)UIButton *changeCameraButton;
/**
 关闭直播
 */
@property(nonatomic,strong)UIButton *closeButton;
/**
 直播状态
 */
@property(nonatomic,strong)UILabel  *statusLabel;
/**
 开始、暂停直播
 */
@property(nonatomic,strong)UIButton *LiveButton;


/**
 直播的现实View
 */
@property(nonatomic,strong)UIView   *livePreView;
/**
 直播RTMP地址
 */
@property(nonatomic,copy)NSString   *RTMPUrl;

/**
 直播session
 */
@property(nonatomic,strong)LFLiveSession *liveSession;

@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //页面布局
    [self layout];
    
    //直播环境设置
    [self congifLiveSession];
}
/**
 delegate method
 */
-(void)liveSession:(LFLiveSession *)session liveStateDidChange:(LFLiveState)state
{
    NSString *tempStatus;
    switch (state) {
        case LFLiveReady:
            tempStatus = @"准备中";
            break;
        case LFLivePending:
            tempStatus = @"连接中";
            break;
        case LFLiveStart:
            tempStatus = @"已连接";
            break;
        case LFLiveStop:
            tempStatus = @"已断开";
            break;
        case LFLiveError:
            tempStatus = @"连接出错";
            break;
        default:
            break;
    }
    self.statusLabel.text = [NSString stringWithFormat:@"状态: %@\nRTMP: %@", tempStatus, self.RTMPUrl];
}
/** live debug info callback */
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug*)debugInfo{
    
}

/** callback socket errorcode */
- (void)liveSession:(nullable LFLiveSession*)session errorCode:(LFLiveSocketErrorCode)errorCode{
    
}

-(void)startOrStop:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected) {
        //start
        LFLiveStreamInfo *streamInfo = [LFLiveStreamInfo new];
        // 如果是跟我blog教程搭建的本地服务器, 记得填写你电脑的IP地址http://www.jianshu.com/p/8ea016b2720e
        streamInfo.url = @"rtmp://192.168.1.102:1935/rtmplive/room";
        self.RTMPUrl = streamInfo.url;
        [self.liveSession startLive:streamInfo];
    }else
    {
        [self.liveSession stopLive];
        self.statusLabel.text = @"状态: 直播被关闭";
    }
}
-(void)changeCamera
{
    AVCaptureDevicePosition devicePositon = self.liveSession.captureDevicePosition;
    self.liveSession.captureDevicePosition = (devicePositon == AVCaptureDevicePositionBack) ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
    NSLog(@"切换前置/后置摄像头");
}
-(void)beautifulOrNot
{
    // 默认是开启了美颜功能的
    self.liveSession.beautyFace = !self.liveSession.beautyFace;
    NSString *title = self.liveSession.beautyFace ? @"关闭美颜":@"打开美颜" ;
    [self.beautifulButton setTitle:title forState:UIControlStateNormal];
}
-(void)dismiss
{
    if (self.liveSession.state == LFLivePending || self.liveSession.state == LFLiveStart){
        [self.liveSession stopLive];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)congifLiveSession
{
    /***   默认分辨率368 ＊ 640  音频：44.1 iphone6以上48  双声道  方向竖屏 ***/
    _liveSession = [[LFLiveSession alloc]initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Medium2]];
    
    _liveSession.delegate = self ;
    _liveSession.running = YES ;
    _liveSession.preView = self.livePreView ;
    //默认开启后摄像头
    _liveSession.captureDevicePosition = AVCaptureDevicePositionBack;
}
-(void)layout
{
    [self.view addSubview:self.beautifulButton];
    [self.view addSubview:self.changeCameraButton];
    [self.view addSubview:self.closeButton];
    [self.view addSubview:self.statusLabel];
    [self.view addSubview:self.LiveButton];
    
    [_beautifulButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(20);
    }];
    [_changeCameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.equalTo(self.view);
    }];
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(20);
    }];
    
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.changeCameraButton.mas_bottom).mas_offset(40);
        make.centerX.equalTo(self.view);
    }];
    [_LiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-80);
        make.centerX.equalTo(self.view);
    }];
}
-(UIView *)livePreView
{
    if(_livePreView) return _livePreView;
    
    _livePreView = [[UIView alloc]initWithFrame:self.view.bounds];
    _livePreView.backgroundColor = [UIColor clearColor];
    _livePreView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //需要设置
    [self.view insertSubview:_livePreView atIndex:0];
    return _livePreView;
}
-(UIButton *)beautifulButton
{
    if(_beautifulButton) return _beautifulButton;
    
    _beautifulButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_beautifulButton setTitle:@"关闭美颜" forState:UIControlStateNormal];
    [_beautifulButton setImage:[UIImage imageNamed:@"beautifulface"] forState:UIControlStateNormal];
    _beautifulButton.backgroundColor = [UIColor grayColor];
    _beautifulButton.layer.cornerRadius = 5;
    _beautifulButton.layer.masksToBounds = YES ;
    [_beautifulButton addTarget:self action:@selector(beautifulOrNot) forControlEvents:UIControlEventTouchUpInside];
    return _beautifulButton;
}
-(UIButton *)changeCameraButton
{
    if(_changeCameraButton) return _changeCameraButton;
    
    _changeCameraButton = [UIButton buttonWithType: UIButtonTypeCustom];
    [_changeCameraButton setImage:[UIImage imageNamed:@"camerachange"] forState:UIControlStateNormal];
    [_changeCameraButton addTarget:self action:@selector(changeCamera) forControlEvents:UIControlEventTouchUpInside];

    return _changeCameraButton;
}
-(UIButton *)closeButton
{
    if(_closeButton) return _closeButton;
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeButton setImage:[UIImage imageNamed:@"xx"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    return _closeButton;
}
-(UIButton *)LiveButton
{
    if(_LiveButton) return _LiveButton;
    
    _LiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_LiveButton setTitle:@"start live" forState:UIControlStateNormal];
    _LiveButton.backgroundColor = [UIColor grayColor];
    _LiveButton.backgroundColor = KeyColor;
    _LiveButton.layer.cornerRadius = 5;
    _LiveButton.layer.masksToBounds = YES ;
    [_LiveButton addTarget:self action:@selector(startOrStop:) forControlEvents:UIControlEventTouchUpInside];
    return _LiveButton;
}
-(UILabel *)statusLabel
{
    if(_statusLabel) return _statusLabel;
    
    _statusLabel = [[UILabel alloc]init];
    _statusLabel.text = @"状态：未知";
    _statusLabel.numberOfLines = 0 ;
    _statusLabel.textAlignment = NSTextAlignmentCenter ;
    return _statusLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
