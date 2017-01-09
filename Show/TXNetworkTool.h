//
//  TXNetworkTool.h
//  Show
//
//  Created by txx on 16/12/28.
//  Copyright © 2016年 txx. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void(^TResponse)(id response);

/**
 网络类型枚举类型

 - TNetworkTypeNone: 无网络
 - TNetworkType2G: 2G网络
 - TNetworkType3G: 3G网络
 - TNetworkType4G: 4G网络
 - TNetworkTypeWifi: WiFi
 */
typedef NS_ENUM(NSInteger, TNetworkType)
{
    TNetworkTypeNone = 1,
    TNetworkType2G,
    TNetworkType3G,
    TNetworkType4G,
    TNetworkTypeWifi
};


@interface TXNetworkTool : AFHTTPSessionManager

/**
 网络工具单例
 */
+(instancetype)shareNetworkTool;

/**
 获取当前的网络类型
 */
+(TNetworkType)networkType;

/**
 get网络请求
 */
+(void)GET:(NSString *)url param:(NSDictionary *)param scc:(TResponse)response;

@end
