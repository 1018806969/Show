//
//  AppDelegate.m
//  Show
//
//  Created by txx on 16/12/28.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Reachability.h"
#import "TXNetworkTool.h"

@interface AppDelegate ()
{
    //网络检测类
    Reachability *_reacha;
    
    //之前的网络类型
    TNetworkType  _preType;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[LoginViewController alloc] init];
    
    [self checkNetworkStates];
    
    NSLog(@"current network is %ld",(long)[TXNetworkTool networkType]);
    return YES;
}
/**
 监听网络类型变化
 */
-(void)checkNetworkStates
{
    //监听网络变化的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged) name:kReachabilityChangedNotification object:nil];
    _reacha = [Reachability reachabilityWithHostName:@"http:www.baidu.com"];
    [_reacha startNotifier];
}
-(void)networkChanged
{
    //获取当前的网络状态
    TNetworkType currentType = [TXNetworkTool networkType];
    if (currentType == _preType) return ;
    
    _preType = currentType;
    
    NSString *tips ;
    switch (currentType) {
        case TNetworkTypeNone:
            tips = @"当前无网络, 请检查您的网络状态";
            break;
        case TNetworkType2G:
            tips = @"切换到了2G网络";
            break;
        case TNetworkType3G:
            tips = @"切换到了3G网络";
            break;
        case TNetworkType4G:
            tips = @"切换到了4G网络";
            break;
        case TNetworkTypeWifi:
            tips = nil;
            break;
        default:
            break;
    }
    
    if (tips.length) {
        Alert(tips);
    }
}
@end
