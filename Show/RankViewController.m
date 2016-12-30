//
//  RankViewController.m
//  Show
//
//  Created by txx on 16/12/30.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "RankViewController.h"

@interface RankViewController ()

@property(nonatomic,strong)UIWebView *webView;

@end

@implementation RankViewController


-(instancetype)initWithWebUrlString:(NSString *)urlStr
{
    self = [super init];
    if (self) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    }
    return self ;
}
-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_webView];
    }
    return _webView ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"排行";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
