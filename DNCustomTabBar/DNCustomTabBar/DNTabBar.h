//
//  DNTabBar.h
//  DNCustomTabBar
//
//  Created by zjs on 2019/5/23.
//  Copyright © 2019 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DNTabBarPosition) {
    
    DNTabBarPositionCenter = 0, // 居中显示
    DNTabBarPositionBulge       // 突出一半
};

NS_ASSUME_NONNULL_BEGIN

@protocol DNTabBarDelegate <NSObject>

@required
- (void)touchCenterButton:(UIButton *)sender;

@end

@interface DNTabBar : UITabBar

/**
 中间按钮
 */
@property (nonatomic, strong) UIButton *centerBtn;

/**
 中间按钮图片
 */
@property (nonatomic, strong) UIImage *normalImage;
/**
 中间按钮选中图片
 */
@property (nonatomic, strong) UIImage *selectImage;

/**
 中间按钮偏移量,两种可选，也可以使用centerOffsetY 自定义
 */
@property (nonatomic, assign) DNTabBarPosition position;

/**
 中间按钮偏移量，默认是居中
 */
@property (nonatomic, assign) CGFloat centerOffsetY;

/**
 中间按钮的宽和高，默认使用图片宽高
 */
@property (nonatomic, assign) CGFloat centerWidth, centerHeight;

/**
 点击按钮的代理
 */
@property (nonatomic, weak) id<DNTabBarDelegate> dnDelegate;
@end

NS_ASSUME_NONNULL_END
