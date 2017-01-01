//
//  NetWorkRequest.m
//  Show
//
//  Created by txx on 16/12/30.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "NetWorkRequest.h"
#import "TXNetworkTool.h"
#import "AdModel.h"
#import "HotLiveModel.h"

@implementation NetWorkRequest
+(void)adRequest:(NSString *)url scc:(TResult)result
{
    [TXNetworkTool GET:url param:nil scc:^(id response) {
        NSArray *datas = [response objectForKey:@"data"];
        if ([datas isKindOfClass:[NSArray class]] && datas.count) {
            NSArray *ads = [AdModel mj_objectArrayWithKeyValuesArray:datas];
            result(ads);
        }else
        {
            NSLog(@"no ads");
        }
    }];
}
+(void)hotLiveRequest:(NSString *)url scc:(TResult)result
{
    [TXNetworkTool GET:url param:nil scc:^(id response) {
        NSArray *datas = [[response objectForKey:@"data"] objectForKey:@"list"];
        if ([datas isKindOfClass:[NSArray class]] && datas.count) {
            NSArray *hotlives = [HotLiveModel mj_objectArrayWithKeyValuesArray:datas];
            result(hotlives);
        }else
        {
            NSLog(@"no hotlive");
        }
    }];
}
@end
