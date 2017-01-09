//
//  LiveCollectionViewController.h
//  Show
//
//  Created by txx on 17/1/1.
//  Copyright © 2017年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveCollectionViewController : UICollectionViewController

/**
 anchor列表
 */
@property(nonatomic,strong)NSArray *lives;

/**
 当前播放的anchor index
 */
@property(nonatomic,assign)NSUInteger currentIndex;

@end
