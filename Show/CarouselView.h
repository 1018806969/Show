//
//  CarouselView.h
//  Show
//
//  Created by txx on 16/12/30.
//  Copyright © 2016年 txx. All rights reserved.
//

/**
 无限轮播
 */

#import <UIKit/UIKit.h>
#import "AdModel.h"

typedef void(^TSelectedAd)(AdModel *model);
@interface CarouselView : UIScrollView


/**
 轮播图数据
 */
@property(nonatomic,strong)NSArray<AdModel *> *ads;

/**
 点击了某个数据回调
 */
@property(nonatomic,strong)TSelectedAd         selectedAd;

@end
