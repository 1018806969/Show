//
//  NavigationController.m
//  Show
//
//  Created by txx on 16/12/29.
//  Copyright © 2016年 txx. All rights reserved.
//

/**
 自定义的导航控制器，
 1、在初始化方法中指定了导航条的背景图片
 2、重写了push方法
   当由根视图push新视图时，隐藏tarbar；
   自定义了返回按钮，并对自定义按钮导致的滑动返回失效做了处理
*/

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
        //隐藏tarbar
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
    //判断当前视图的两种情况：push || present
    
    //property presentedViewController presentingViewController是指当前控制前的上一级控制器
    
    //本Demo中tabbarController是present出现的，所以&& self.childViewControllers.count == 1，比如在切换账号时，就符合if的情况
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
