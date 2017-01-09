//
//  TitleView.h
//  Show
//
//  Created by txx on 16/12/29.
//  Copyright © 2016年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 当前需要展示的视图

 - THomeTypeHot: 热门
 - THomeTypeNew: 最新
 - THomeTypeCare: 关心
 */
typedef NS_ENUM(NSInteger, THomeType)
{
    THomeTypeHot,
    THomeTypeNew,
    THomeTypeCare
};
typedef void(^TSelectedHomeType)(THomeType homeType);

@interface TitleView : UIView

/**
 点击展示视图类型回调
 */
@property(nonatomic,copy)TSelectedHomeType selectedHomeType;

/**
 重置下划线的位置

 @param homeType 要展示的视图
 */
-(void)resetUnderLineLocation:(THomeType)homeType;

@end
