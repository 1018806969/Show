//
//  HotViewController.m
//  Show
//
//  Created by txx on 16/12/30.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "HotViewController.h"
#import "RankViewController.h"
#import "LiveCollectionViewController.h"
#import "CarouselView.h"
#import "HotLiveCell.h"
#import "HotLiveModel.h"
#import "TXNetworkTool.h"
#import "TRefreshGifHeader.h"


@interface HotViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)CarouselView *adCarouselView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *lives;

@property(nonatomic,assign)NSInteger        currentLivePage;

@end

static NSString *const THotLiveCell = @"THotLiveCell";
@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView.mj_header beginRefreshing];
    
    __weak typeof(self)weakSelf = self ;
    _adCarouselView.selectedAd = ^(AdModel *model)
    {
        RankViewController *rankVc = [[RankViewController alloc]initWithWebUrlString:model.link];
        rankVc.title = model.title ;
        [weakSelf.navigationController pushViewController:rankVc animated:YES];
    };
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiveCollectionViewController *collectionVC = [[LiveCollectionViewController alloc]init];
    collectionVC.lives = self.lives ;
    collectionVC.currentIndex = indexPath.row;
    [self presentViewController:collectionVC animated:YES completion:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lives.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:THotLiveCell];
    cell.liveModel = self.lives[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 465;
}
-(void)getAdInfo
{
    [NetWorkRequest adRequest:@"http://live.9158.com/Living/GetAD" scc:^(id result) {
        _adCarouselView.ads = result;
    }];
    
}
-(void)getHotLIveInfo
{
    [[TXNetworkTool shareNetworkTool] GET:[NSString stringWithFormat:@"http://live.9158.com/Fans/GetHotLive?page=%ld", self.currentLivePage] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        NSArray *result = [HotLiveModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        if ([result isKindOfClass:[NSArray class]] && result.count) {
            [self.lives addObjectsFromArray:result];
            [self.tableView reloadData];
        }else{
            NSLog(@"暂时没有更多最新数据");
            // 恢复当前页
            self.currentLivePage--;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        self.currentLivePage--;
        NSLog(@"网络异常");
    }];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self ;
        _tableView.dataSource = self ;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.adCarouselView ;
        _tableView.tableFooterView = [UIView new];
        _tableView.mj_header = [TRefreshGifHeader headerWithRefreshingBlock:^{
            self.currentLivePage = 1 ;
            self.lives = [NSMutableArray array];
            [self getAdInfo];
            [self getHotLIveInfo];
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.currentLivePage ++ ;
            [self getHotLIveInfo];
        }];
        [_tableView registerClass:[HotLiveCell class] forCellReuseIdentifier:THotLiveCell];
    }
    return _tableView;
}
-(CarouselView *)adCarouselView
{
    if(_adCarouselView) return _adCarouselView ;
    _adCarouselView = [[CarouselView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,100)];
    return _adCarouselView ;
}
-(NSMutableArray *)lives
{
    if (_lives) return  _lives;
    _lives = [NSMutableArray array];
    return _lives ;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
