//
//  LiveCollectionViewController.h
//  Show
//
//  Created by txx on 17/1/1.
//  Copyright © 2017年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveCollectionViewController : UICollectionViewController

@property(nonatomic,strong)NSArray *lives;

@property(nonatomic,assign)NSUInteger currentIndex;

@end
