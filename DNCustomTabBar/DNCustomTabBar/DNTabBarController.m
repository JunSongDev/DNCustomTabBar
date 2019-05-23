//
//  DNTabBarController.m
//  DNCustomTabBar
//
//  Created by zjs on 2019/5/23.
//  Copyright © 2019 zjs. All rights reserved.
//

#import "DNTabBarController.h"
#import "PresentViewController.h"
#import "ViewController.h"
#import "DNTabBar.h"

@interface DNTabBarController ()<UITabBarControllerDelegate, UITabBarDelegate, DNTabBarDelegate>

@end

@implementation DNTabBarController

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self configTabBar];
        [self setControlForSuper];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)configTabBar {
    
    self.tabbar = [[DNTabBar alloc] init];
    self.tabbar.dnDelegate = self;
    self.tabbar.position   = DNTabBarPositionBulge;
    self.tabbar.normalImage = [UIImage imageNamed:@"post_animate_add"];
    //利用KVC 将自己的tabbar赋给系统tabBar
    [self setValue:self.tabbar forKeyPath:@"tabBar"];
    //选中时的颜色
    self.tabbar.tintColor = [UIColor colorWithRed:251.0/255.0 green:199.0/255.0 blue:115/255.0 alpha:1];
}

#pragma mark -- UITabBarControllerDelegate
// 重写选中事件， 处理中间按钮选中问题
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//
//    self.tabbar.centerBtn.selected = (tabBarController.selectedIndex == self.viewControllers.count/2);
//
//    if (tabBarController.selectedIndex == 2) {
//
//        [self rotationAnimation];
//    }else {
//        [self.tabbar.centerBtn.layer removeAllAnimations];
//    }
//}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    // 拦截 index 为 2 是的点击事件
    NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    if (index == 2) {
        // 响应按钮的点击事件
        [self touchCenterButton:self.tabbar.centerBtn];
        
        return NO;
    }
    return YES;
}

//旋转动画
//- (void)rotationAnimation {
//    if ([@"key" isEqualToString:[self.tabbar.centerBtn.layer animationKeys].firstObject]){
//        return;
//    }
//    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
//    rotationAnimation.duration = 1.2;
//    rotationAnimation.repeatCount = HUGE;
//    [self.tabbar.centerBtn.layer addAnimation:rotationAnimation forKey:@"key"];
//}

#pragma mark -- UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    // 判断点击的是否是当前选中的 item
    if ([self.tabbar.items indexOfObject:item] != self.selectedIndex) {
        // 如果不是则显示动画
        [self animationWithIndex:[self.tabbar.items indexOfObject:item]];
    }
}

- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction   = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    pulse.duration     = 0.08;
    pulse.repeatCount  = 1;
    pulse.autoreverses = YES;
    
    pulse.fromValue = [NSNumber numberWithFloat:0.7];
    pulse.toValue   = [NSNumber numberWithFloat:1.3];
    
    [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
}

#pragma mark -- setControlForSuper
- (void)setControlForSuper{
    
    UINavigationController *first  = [[UINavigationController alloc]
                                      initWithRootViewController:[[ViewController alloc]init]];
    first.tabBarItem.title = @"闲鱼";
    first.tabBarItem.image = [[UIImage imageNamed:@"home_normal"]
                              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    first.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_highlight"]
                                      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *second = [[UINavigationController alloc]
                                      initWithRootViewController:[[ViewController alloc]init]];
    second.tabBarItem.title = @"鱼塘";
    second.tabBarItem.image = [[UIImage imageNamed:@"fishpond_normal"]
                               imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    second.tabBarItem.selectedImage = [[UIImage imageNamed:@"fishpond_highlight"]
                                       imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *third  = [[UINavigationController alloc]
                                      initWithRootViewController:[[ViewController alloc]init]];
    third.tabBarItem.title = @"发布";
    
    UINavigationController *fourth = [[UINavigationController alloc]
                                      initWithRootViewController:[[ViewController alloc]init]];
    fourth.tabBarItem.title = @"消息";
    fourth.tabBarItem.image = [[UIImage imageNamed:@"message_normal"]
                               imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fourth.tabBarItem.selectedImage = [[UIImage imageNamed:@"message_highlight"]
                                       imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *fifth  = [[UINavigationController alloc]
                                      initWithRootViewController:[[ViewController alloc]init]];
    fifth.tabBarItem.title = @"我的";
    fifth.tabBarItem.image = [[UIImage imageNamed:@"account_normal"]
                              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fifth.tabBarItem.selectedImage = [[UIImage imageNamed:@"account_highlight"]
                                      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.viewControllers = @[first, second, third, fourth, fifth];
}

#pragma mark -- DNTabBarDelegate
- (void)touchCenterButton:(UIButton *)sender {
    
    PresentViewController  *vc   = [[PresentViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:nil];
}

@end
