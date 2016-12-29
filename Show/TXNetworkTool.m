//
//  TXNetworkTool.m
//  Show
//
//  Created by txx on 16/12/28.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "TXNetworkTool.h"

static TXNetworkTool *_manager;
@implementation TXNetworkTool


+(instancetype)shareNetworkTool
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        _manager = [TXNetworkTool manager];
        
        _manager.requestSerializer.timeoutInterval = 5.0f;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    });
    return _manager;
}

+(TNetworkType)networkType
{
    
    NSArray *subViews = [[[[UIApplication sharedApplication]valueForKey:@"statusBar"]valueForKey:@"foregroundView"]subviews];
    
    TNetworkType type = TNetworkTypeNone;
    
    for (id subView in subViews) {
        if ([subView isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            int networkType = [[subView valueForKeyPath:@"dataNetworkType"] intValue];
            switch (networkType) {
                case 0:
                    type = TNetworkTypeNone;
                    break;
                case 1:
                    type = TNetworkType2G;
                    break;
                case 2:
                    type = TNetworkType3G;
                    break;
                case 3:
                    type = TNetworkType4G;
                    break;
                case 5:
                    type = TNetworkTypeWifi;
                    break;
            }
        }
    }
//    NSLog(@"statusBar foregroundView array %@",subViews);
    return type;
}

@end
