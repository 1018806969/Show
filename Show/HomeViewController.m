//
//  HomeViewController.m
//  Show
//
//  Created by txx on 16/12/29.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "HomeViewController.h"
#import "TitleView.h"
#import "HotViewController.h"
#import "NewViewController.h"
#import "CareViewController.h"
#import "RankViewController.h"

@interface HomeViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)TitleView      *homeTypeView;

@property(nonatomic,strong)UIScrollView   *scrollView;

@end

@implementation HomeViewController

-(void)loadView
{
    self.view = self.scrollView ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutNavigationBar];
}

-(void)searchAction
{
    
}
-(void)rankCrownAction
{
    RankViewController *rankVc = [[RankViewController alloc]initWithWebUrlString:@"http://live.9158.com/Rank/WeekRank?Random=10"];
    [self.navigationController pushViewController:rankVc animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/ScreenWidth;
    [self.homeTypeView resetUnderLineLocation:page];
}
-(void)layoutNavigationBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStyleDone target:self action:@selector(searchAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"crown"] style:UIBarButtonItemStyleDone target:self action:@selector(rankCrownAction)];
    
    self.navigationItem.titleView = self.homeTypeView ;
}
-(TitleView *)homeTypeView
{
    if (!_homeTypeView) {
        _homeTypeView = [[TitleView alloc]initWithFrame:CGRectMake(70, 0, ScreenWidth-140, 40)];
        __weak typeof(self) weakSelf = self ;
        _homeTypeView.selectedHomeType = ^(THomeType homeType)
        {
            weakSelf.scrollView.contentOffset = CGPointMake(homeType*ScreenWidth, 0);
        };
    }
    return _homeTypeView ;
}
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.delegate = self ;
        _scrollView.contentSize = CGSizeMake(ScreenWidth *3 , 0);
        _scrollView.showsVerticalScrollIndicator = NO ;
        _scrollView.showsHorizontalScrollIndicator = NO ;
        _scrollView.pagingEnabled = YES ;
        _scrollView.bounces = NO ;
        
        HotViewController *hotVc = [[HotViewController alloc]init];
        hotVc.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-40);
        [self addChildViewController:hotVc];
        [_scrollView addSubview:hotVc.view];
        
        NewViewController *newVc = [[NewViewController alloc]init];
        newVc.view.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight-40);
        [self addChildViewController:newVc];
        [_scrollView addSubview:newVc.view];

        CareViewController *careVc = [[CareViewController alloc]init];
        careVc.view.frame = CGRectMake(ScreenWidth *2, 0, ScreenWidth, ScreenHeight-40);
        [self addChildViewController:careVc];
        [_scrollView addSubview:careVc.view];

    }
    return _scrollView ;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
