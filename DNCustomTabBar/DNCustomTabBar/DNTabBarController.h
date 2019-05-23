//
//  DNTabBarController.h
//  DNCustomTabBar
//
//  Created by zjs on 2019/5/23.
//  Copyright © 2019 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class DNTabBar;
@protocol DNTabBarControllerDelegate <NSObject>

- (void)dn_tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

@end

@interface DNTabBarController : UITabBarController

@property (nonatomic, strong) DNTabBar *tabbar;
@property (nonatomic,   weak) id<DNTabBarControllerDelegate> dnDelegate;

@end

NS_ASSUME_NONNULL_END
