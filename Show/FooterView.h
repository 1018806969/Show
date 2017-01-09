//
//  FooterView.h
//  Show
//
//  Created by txx on 17/1/4.
//  Copyright © 2017年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 选中选项的类型
 */
typedef NS_ENUM(NSInteger,TSelectFooterItem)
{
    TSelectFooterItemTalk_public,
    TSelectFooterItemTalk_private,
    TSelectFooterItemTalk_gift,
    TSelectFooterItemTalk_rank,
    TSelectFooterItemTalk_share,
    TSelectFooterItemTalk_close
};

@interface FooterView : UIView

typedef void(^TSelectItem)(TSelectFooterItem item);

/**
 回调
 */
@property(nonatomic,copy)TSelectItem callBack;
@end
