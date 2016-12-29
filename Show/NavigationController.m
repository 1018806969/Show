//
//  NavigationController.m
//  Show
//
//  Created by txx on 16/12/29.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

+(void)initialize
{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"barimage"] forBarMetrics:UIBarMetricsDefault];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) {
        //隐藏导航栏
        viewController.hidesBottomBarWhenPushed = YES ;
        
        //自定义返回按钮
        UIButton *backButton = [UIButton buttonWithType: UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [backButton sizeToFit];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        
        //如果自定义返回按钮后，滑动返回可能会失效，需要如下设置。
        __weak typeof(viewController) weakSelf = viewController ;
        self.interactivePopGestureRecognizer.delegate = (id)weakSelf ;
    }
    [super pushViewController:viewController animated:YES];
}
-(void)back
{
    //判断两种情况：push || present
    
    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
    {
        [self popViewControllerAnimated:YES];
    }
}














- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
