//
//  NewViewController.m
//  Show
//
//  Created by txx on 16/12/30.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "NewViewController.h"
#import "NewFlowLayout.h"
#import "NewCollectionViewCell.h"
#import "LiveCollectionViewController.h"
#import "HotLiveModel.h"
#import "TRefreshGifHeader.h"
#import "TXNetworkTool.h"

@interface NewViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray   *anchors;
@property(nonatomic,assign)NSUInteger        currentPage;
@property(nonatomic,strong)NSTimer          *timer;


@end

static NSString *const TNewCollectionReuserId = @"TNewCollectionReuserId";
@implementation NewViewController
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_timer invalidate];
    _timer = nil ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _anchors = [NSMutableArray array];
    [self.view addSubview:self.collectionView];
    [self.collectionView.mj_header beginRefreshing];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(autoRefresh) userInfo:nil repeats:YES];
    [_timer fire];
}
-(void)autoRefresh
{
    [self.collectionView.mj_header beginRefreshing];
    NSLog(@"刷新最新主播界面");
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.anchors.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TNewCollectionReuserId forIndexPath:indexPath];
    cell.anchor = self.anchors[indexPath.item];
    return cell ;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LiveCollectionViewController *liveCollectionVc = [[LiveCollectionViewController alloc]init];
    NSMutableArray *lives = [NSMutableArray arrayWithCapacity:self.anchors.count];
    for (NewAnchorModel *anchor in self.anchors) {
        HotLiveModel *live = [[HotLiveModel alloc]init];
        live.bigpic = anchor.photo;
        live.myname = anchor.nickname;
        live.smallpic = anchor.photo;
        live.gps = anchor.position;
        live.useridx = anchor.useridx;
        live.allnum = arc4random_uniform(2000);
        live.flv = anchor.flv;
        [lives addObject:live];
    }
    
    liveCollectionVc.lives = lives;
    liveCollectionVc.currentIndex = indexPath.item;
    [self presentViewController:liveCollectionVc animated:YES completion:nil];
}
-(void)getNewAnchorData
{
    NSString *url = [NSString stringWithFormat:@"http://live.9158.com/Room/GetNewRoomOnline?page=%lu",(unsigned long)_currentPage];
    [[TXNetworkTool shareNetworkTool] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        NSArray *result = [NewAnchorModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        if ([result isKindOfClass:[NSArray class]] && result.count) {
            [self.anchors addObjectsFromArray:result];
            [self.collectionView reloadData];
        }else{
            NSLog(@"暂时没有更多最新数据");
            // 恢复当前页
            self.currentPage--;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        self.currentPage--;
        NSLog(@"网络异常");
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(UICollectionView *)collectionView
{
    if(_collectionView) return _collectionView;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-112) collectionViewLayout:[NewFlowLayout new]];
    _collectionView.delegate = self ;
    _collectionView.dataSource = self ;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[NewCollectionViewCell class] forCellWithReuseIdentifier:TNewCollectionReuserId];
    
    _collectionView.mj_header = [TRefreshGifHeader headerWithRefreshingBlock:^{
        _currentPage = 1 ;
        [self getNewAnchorData];
    }];
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _currentPage ++;
        [self getNewAnchorData];
    }];
    return _collectionView;
}

@end
