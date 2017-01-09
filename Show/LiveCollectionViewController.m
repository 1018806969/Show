//
//  LiveCollectionViewController.m
//  Show
//
//  Created by txx on 17/1/1.
//  Copyright © 2017年 txx. All rights reserved.
//

#import "LiveCollectionViewController.h"
#import "LiveFlowLayout.h"
#import "TRefreshGifHeader.h"
#import "PlayCollectionViewCell.h"

@interface LiveCollectionViewController ()

@end

@implementation LiveCollectionViewController

static NSString * const reuseIdentifier = @"ReuserCell";

-(instancetype)init
{
    return  [super initWithCollectionViewLayout:[[LiveFlowLayout alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[PlayCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    TRefreshGifHeader *gifHeader = [TRefreshGifHeader headerWithRefreshingBlock:^{
        [self.collectionView.mj_header endRefreshing];
        
        self.currentIndex++;
        if (self.currentIndex == self.lives.count) {
            self.currentIndex = 0 ;
        }
        [self.collectionView reloadData];
    }];
    
    gifHeader.stateLabel.hidden = NO ;
    [gifHeader setTitle:@"next" forState:MJRefreshStatePulling];
    [gifHeader setTitle:@"next" forState:MJRefreshStateIdle];
    [gifHeader setTitle:@"next" forState:MJRefreshStateRefreshing];
    self.collectionView.mj_header = gifHeader;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PlayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.liveModel = self.lives[self.currentIndex];
    cell.parentVc = self ;
    
    NSUInteger relateIndex = self.currentIndex;
    if (self.currentIndex + 1 == self.lives.count) {
        relateIndex = 0;
    }else{
        relateIndex += 1;
    }
    cell.relateLiveModel = self.lives[relateIndex];
    [cell setClickRelatedLive:^{
        self.currentIndex += 1;
        [self.collectionView reloadData];
    }];

    return cell;
}


@end
