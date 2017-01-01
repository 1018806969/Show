//
//  CarouselView.h
//  Show
//
//  Created by txx on 16/12/30.
//  Copyright © 2016年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdModel.h"

typedef void(^TSelectedAd)(AdModel *model);
@interface CarouselView : UIScrollView


@property(nonatomic,strong)NSArray<AdModel *> *ads;

@property(nonatomic,strong)TSelectedAd         selectedAd;

@end
