//
//  LoginView.h
//  Show
//
//  Created by txx on 16/12/28.
//  Copyright © 2016年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, TLoginType)
{
    TLoginTypeSina,
    TLoginTypeWeChat,
    TLoginTypeQQ,
    TLoginTypeFast
};

typedef void(^TLoginSelected)(TLoginType loginType);

@interface LoginView : UIView

@property(nonatomic,copy)TLoginSelected loginSelected;

@end
