//
//  NetWorkRequest.h
//  Show
//
//  Created by txx on 16/12/30.
//  Copyright © 2016年 txx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TResult)(id result);
@interface NetWorkRequest : NSObject

/**
 获取首页广告数据
 */
+(void)adRequest:(NSString *)url scc:(TResult)result;

@end
