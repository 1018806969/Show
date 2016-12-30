//
//  TitleView.h
//  Show
//
//  Created by txx on 16/12/29.
//  Copyright © 2016年 txx. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, THomeType)
{
    THomeTypeHot,
    THomeTypeNew,
    THomeTypeCare
};
typedef void(^TSelectedHomeType)(THomeType homeType);

@interface TitleView : UIView

@property(nonatomic,copy)TSelectedHomeType selectedHomeType;

@property(nonatomic,assign)THomeType *homeType;


-(void)resetUnderLineLocation:(THomeType)homeType;

@end
