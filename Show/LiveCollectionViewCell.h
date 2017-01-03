//
//  LiveCollectionViewCell.h
//  Show
//
//  Created by txx on 17/1/3.
//  Copyright © 2017年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotLiveModel ;
@interface LiveCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)HotLiveModel *liveModel;

@property(nonatomic,strong)HotLiveModel *relateLiveModel;

@property(nonatomic,strong)UIViewController *parentVc;

@property(nonatomic,copy)void(^clickRelatedLive)();


@end
