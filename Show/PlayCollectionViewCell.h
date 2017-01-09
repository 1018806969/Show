//
//  PlayCollectionViewCell.h
//  Show
//
//  Created by txx on 17/1/4.
//  Copyright © 2017年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotLiveModel;
@interface PlayCollectionViewCell : UICollectionViewCell

/**
 播放anchor model
 */
@property(nonatomic,strong)HotLiveModel *liveModel;

/**
 相关anchor model
 */
@property(nonatomic,strong)HotLiveModel *relateLiveModel;

/**
 LiveCollectionViewController
 */
@property(nonatomic,strong)UIViewController *parentVc;

/**
 回调
 */
@property(nonatomic,copy)void(^clickRelatedLive)();

@end
