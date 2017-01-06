//
//  NewFlowLayout.m
//  Show
//
//  Created by txx on 17/1/4.
//  Copyright © 2017年 txx. All rights reserved.
//

#import "NewFlowLayout.h"

@implementation NewFlowLayout

-(void)prepareLayout
{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.minimumLineSpacing = 1;
    self.minimumInteritemSpacing = 1 ;
    
    CGFloat wh = (ScreenWidth-3)/3.0;
    self.itemSize = CGSizeMake(wh, wh);
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO ;
    self.collectionView.alwaysBounceVertical = YES ;
}

@end
