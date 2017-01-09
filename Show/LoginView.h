//
//  LoginView.h
//  Show
//
//  Created by txx on 16/12/28.
//  Copyright © 2016年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 登录方式

 - TLoginTypeSina: sina
 - TLoginTypeWeChat: wechat
 - TLoginTypeQQ: qq
 - TLoginTypeFast: 快速登录通道
 */
typedef NS_ENUM(NSInteger, TLoginType)
{
    TLoginTypeSina,
    TLoginTypeWeChat,
    TLoginTypeQQ,
    TLoginTypeFast
};

typedef void(^TLoginSelected)(TLoginType loginType);

@interface LoginView : UIView

/**
 选择登录方式的回调
 */
@property(nonatomic,copy)TLoginSelected loginSelected;

@end
