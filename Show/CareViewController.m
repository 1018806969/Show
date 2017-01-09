//
//  CareViewController.m
//  Show
//
//  Created by txx on 16/12/30.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "CareViewController.h"

@interface CareViewController ()

@property(strong,nonatomic)UIImageView *imageView;
@property(strong,nonatomic)UIButton    *backButton;

@end

@implementation CareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.backButton];
    [self layout];
    
}
-(void)back
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoHot" object:nil];
}
-(UIImageView *)imageView
{
    if(_imageView) return _imageView;
    
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nocare"]];
    return _imageView;
}
-(UIButton *)backButton
{
    if(_backButton) return _backButton;
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_backButton setTitle:@"你关注的主播未开播，去看看当前热门主播" forState:UIControlStateNormal];
    _backButton.backgroundColor = [UIColor purpleColor];
    return _backButton;
}
-(void)layout
{
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(ScreenWidth-100);
        make.height.mas_equalTo(ScreenWidth-100);
    }];
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).mas_offset(30);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
