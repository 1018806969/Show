//
//  HotLiveModel.m
//  Show
//
//  Created by txx on 16/12/30.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "HotLiveModel.h"

@implementation HotLiveModel
-(UIImage *)starImage
{
    if (self.starlevel) {
        return [UIImage imageNamed:[NSString stringWithFormat:@"star%ld", self.starlevel]];
    }
    return nil ;
}
@end
