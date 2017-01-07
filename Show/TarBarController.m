//
//  TarBarController.m
//  Show
//
//  Created by txx on 16/12/29.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "TarBarController.h"
#import "NavigationController.h"
#import "HomeViewController.h"
#import "LiveViewController.h"
#import "MeViewController.h"
#import "UIDevice+TExtension.h"
#import <AVFoundation/AVFoundation.h>
#import "LiveViewController.h"

@interface TarBarController ()<UITabBarControllerDelegate>

@end

@implementation TarBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self ;
    
    [self addChildViewController:[HomeViewController new] imageName:@"home" title:@"home"];
    [self addChildViewController:[UIViewController new] imageName:@"live" title:@"live"];
    [self addChildViewController:[MeViewController   new] imageName:@"me" title:@"me"];
        
}
-(void)addChildViewController:(UIViewController *)childController imageName:(NSString *)image title:(NSString *)title
{
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:childController];
    childController.tabBarItem.image = [UIImage imageNamed:image];
    //可以设置选中的图片
    //childController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",image]];
    
    //如果不设置标题，需要设置图片居中, 这儿需要注意top和bottom必须绝对值一样大
    //childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    childController.tabBarItem.title = title;
    
    // 设置导航栏为透明的
    //    if ([childController isKindOfClass:[ProfileController class]]) {
    //        [nav.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //        nav.navigationBar.shadowImage = [[UIImage alloc] init];
    //        nav.navigationBar.translucent = YES;
    //    }

    [self addChildViewController:nav];
}


-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([tabBarController.childViewControllers indexOfObject:viewController] == 1) {
        
        if ([[UIDevice deviceVersion] isEqualToString:@"iPhone Simulator"]) {
            NSLog(@"请用真机进行测试, 此模块不支持模拟器测试");
            return NO;
        }
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            NSLog(@"您的设备没有摄像头或者相关的驱动, 不能进行直播");
            return NO;
        }
        AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authorizationStatus == AVAuthorizationStatusDenied || AVAuthorizationStatusRestricted) {
            NSLog(@"app需要访问您的摄像头。\n请启用摄像头-设置/隐私/摄像头");
        }
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    return YES;
                }
                else {
                    NSLog(@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风");
                    return NO;
                }
            }];
        }
        LiveViewController *showTimeVc = [LiveViewController new];
        [self presentViewController:showTimeVc animated:YES completion:nil];
        return NO;

    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
