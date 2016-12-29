//
//  TXNetworkTool.h
//  Show
//
//  Created by txx on 16/12/28.
//  Copyright © 2016年 txx. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSInteger, TNetworkType)
{
    TNetworkTypeNone = 1,
    TNetworkType2G,
    TNetworkType3G,
    TNetworkType4G,
    TNetworkTypeWifi
};


@interface TXNetworkTool : AFHTTPSessionManager

+(instancetype)shareNetworkTool;

/**
 获取当前的网络类型
 */
+(TNetworkType)networkType;


@end
