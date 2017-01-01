//
//  CarouselView.m
//  Show
//
//  Created by txx on 16/12/30.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "CarouselView.h"

@interface CarouselView()<UIScrollViewDelegate>

@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UIImageView *centerImageView;
@property(nonatomic,strong)UIImageView *rightImageView;

@property(nonatomic,assign)NSInteger    currentSelectedImgIndex;
@property(nonatomic,assign)NSInteger    imgCount;

@property(nonatomic,strong)UIPageControl *pageControl;

@property(nonatomic,strong)NSTimer       *timer;
@end

@implementation CarouselView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = CGSizeMake(frame.size.width *3 , frame.size.height);
        self.pagingEnabled = YES ;
        self.showsVerticalScrollIndicator = NO ;
        self.showsHorizontalScrollIndicator = NO ;
        self.bounces = NO ;
        self.delegate = self ;
        self.imgCount = 3 ;
        
        [self addSubview:self.leftImageView];
        [self addSubview:self.centerImageView];
        [self addSubview:self.rightImageView];
        
    }
    return self;
}
-(void)tapAdAction
{
    if (_selectedAd) {
        AdModel *model = _ads[_currentSelectedImgIndex];
        _selectedAd(model);
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reloadData];
}
-(void)reloadData
{
    if (self.contentOffset.x >self.bounds.size.width *1.5) {
        //向左
        _currentSelectedImgIndex = (_currentSelectedImgIndex +1)%_imgCount;
    }else if(self.contentOffset.x < self.bounds.size.width *0.5)
    {
        _currentSelectedImgIndex = (_currentSelectedImgIndex -1 +_imgCount)%_imgCount;
    }else
    {
        return ;
    }
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:[_ads[_currentSelectedImgIndex] imageUrl]]];
    
    NSInteger leftImgIndex = (_currentSelectedImgIndex -1 +_imgCount)%_imgCount;
    NSInteger rightImgIndex = (_currentSelectedImgIndex +1)%_imgCount;
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:[_ads[leftImgIndex] imageUrl]]];
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:[_ads[rightImgIndex] imageUrl]]];
    
    self.contentOffset = CGPointMake(self.bounds.size.width, 0);
    self.pageControl.currentPage = _currentSelectedImgIndex ;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}
-(void)setAds:(NSArray<AdModel *> *)ads
{
    if (ads.count == 0) return ;
    if (ads.count == 1)
    {
        AdModel *value = ads[0];
        _ads = @[value,value,value];
    }else if(ads.count == 2)
    {
        AdModel *value0 = ads[0];
        AdModel *value1 = ads[1];
        _ads = @[value0,value1,value0];
    }else
    {
        _ads = ads;
    }
    
    _imgCount = _ads.count ;
    
    _pageControl.numberOfPages = _imgCount ;
    CGSize size = [_pageControl sizeForNumberOfPages:_imgCount];
    _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    _pageControl.center = CGPointMake(self.center.x,self.bounds.size.height-size.height);

    [self setDefaultScrollViewImage];
    [self startTimer];
}
-(void)timerRepeat
{
    _currentSelectedImgIndex = (_currentSelectedImgIndex +1)%_imgCount;

    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:[_ads[_currentSelectedImgIndex] imageUrl]]];
    
    NSInteger leftImgIndex = (_currentSelectedImgIndex -1 +_imgCount)%_imgCount;
    NSInteger rightImgIndex = (_currentSelectedImgIndex +1)%_imgCount;
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:[_ads[leftImgIndex] imageUrl]]];
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:[_ads[rightImgIndex] imageUrl]]];
    
    self.contentOffset = CGPointMake(self.bounds.size.width, 0);
    self.pageControl.currentPage = _currentSelectedImgIndex ;
}
-(void)setDefaultScrollViewImage
{
    AdModel *centerModel = _ads[0];
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:centerModel.imageUrl]];
    
    AdModel *leftModel = _ads[_imgCount-1];
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:leftModel.imageUrl]];
    
    AdModel *rightModle = _ads[1];
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:rightModle.imageUrl]];
}
-(void)startTimer
{
    if (_timer)  [self stopTimer];
    
    _timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(timerRepeat) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)stopTimer
{
    [_timer invalidate];
    _timer = nil ;
}

-(UIImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _leftImageView.backgroundColor = [UIColor redColor];
        _leftImageView.image = [UIImage imageNamed:@"noimg"];
    }
    return _leftImageView ;
}
-(UIImageView *)centerImageView
{
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
        _centerImageView.backgroundColor = [UIColor purpleColor];
        _centerImageView.image = [UIImage imageNamed:@"noimg"];
        _centerImageView.userInteractionEnabled = YES ;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAdAction)];
        [_centerImageView addGestureRecognizer:tapGesture];
        [_centerImageView addSubview:self.pageControl];

    }
    return _centerImageView ;
}
-(UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width*2, 0, self.bounds.size.width, self.bounds.size.height)];
        _rightImageView.backgroundColor = [UIColor yellowColor];
        _rightImageView.image = [UIImage imageNamed:@"noimg"];
    }
    return _rightImageView ;
}
-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.pageIndicatorTintColor = [UIColor blackColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
        _pageControl.numberOfPages = _imgCount;
        CGSize size = [_pageControl sizeForNumberOfPages:_imgCount];
        _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
        _pageControl.center = CGPointMake(self.center.x,self.bounds.size.height-size.height);
    }
    return _pageControl ;
}
@end
