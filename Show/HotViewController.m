//
//  HotViewController.m
//  Show
//
//  Created by txx on 16/12/30.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "HotViewController.h"
#import "RankViewController.h"
#import "CarouselView.h"
#import "HotLiveCell.h"
#import "HotLiveModel.h"

@interface HotViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)CarouselView *adCarouselView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *lives;

@end

static NSString *const THotLiveCell = @"THotLiveCell";
@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self getAdInfo];
    [self getHotLIveInfo];
    
    __weak typeof(self)weakSelf = self ;
    _adCarouselView.selectedAd = ^(AdModel *model)
    {
        RankViewController *rankVc = [[RankViewController alloc]initWithWebUrlString:model.link];
        rankVc.title = model.title ;
        [weakSelf.navigationController pushViewController:rankVc animated:YES];
    };

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
    [NetWorkRequest hotLiveRequest:@"http://live.9158.com/Fans/GetHotLive?page=1" scc:^(id result) {
        self.lives = result ;
        [self.tableView reloadData];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
