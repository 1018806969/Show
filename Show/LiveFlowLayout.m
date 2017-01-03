//
//  LiveFlowLayout.m
//  Show
//
//  Created by txx on 17/1/3.
//  Copyright © 2017年 txx. All rights reserved.
//

#import "LiveFlowLayout.h"

@implementation LiveFlowLayout

-(void)prepareLayout
{
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.itemSize = self.collectionView.bounds.size;
    self.minimumLineSpacing = 0 ;
    self.minimumInteritemSpacing = 0 ;
    
    self.collectionView.showsVerticalScrollIndicator = NO ;
    self.collectionView.showsHorizontalScrollIndicator = NO ;
}
@end
