//
//  TRefreshGifHeader.m
//  Show
//
//  Created by txx on 17/1/1.
//  Copyright © 2017年 txx. All rights reserved.
//

#import "TRefreshGifHeader.h"

@implementation TRefreshGifHeader

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.lastUpdatedTimeLabel.hidden = YES ;
        self.stateLabel.hidden = YES ;
        [self setImages:@[[UIImage imageNamed:@"re1"], [UIImage imageNamed:@"re2"], [UIImage imageNamed:@"re3"]]  forState:MJRefreshStateRefreshing];
        [self setImages:@[[UIImage imageNamed:@"re1"], [UIImage imageNamed:@"re2"], [UIImage imageNamed:@"re3"]]  forState:MJRefreshStatePulling];
        [self setImages:@[[UIImage imageNamed:@"re1"], [UIImage imageNamed:@"re2"], [UIImage imageNamed:@"re3"]]  forState:MJRefreshStateIdle];
    }
    return self;
}

@end
