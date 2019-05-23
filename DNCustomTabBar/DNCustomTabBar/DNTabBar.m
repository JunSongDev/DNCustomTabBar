//
//  DNTabBar.m
//  DNCustomTabBar
//
//  Created by zjs on 2019/5/23.
//  Copyright © 2019 zjs. All rights reserved.
//

#import "DNTabBar.h"

@interface DNTabBar ()

@end

@implementation DNTabBar

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        [self configCenterButton];
    }
    return self;
}

- (void)configCenterButton {
    
    self.centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.centerBtn.adjustsImageWhenHighlighted = NO;
    [self.centerBtn addTarget:self action:@selector(centerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.centerBtn];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    switch (self.position) {
        case DNTabBarPositionCenter:
            
            self.centerBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - self.centerWidth)/2.0,
                                              (49 - self.centerHeight)/2.0 + self.centerOffsetY,
                                              self.centerWidth,
                                              self.centerHeight);
            
            break;
        default:
            self.centerBtn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - self.centerWidth)/2.0,
                                              - self.centerHeight/2.0 + self.centerOffsetY,
                                              self.centerWidth,
                                              self.centerHeight);
            break;
    }
}

- (void)centerAction:(UIButton *)sender {
    
    if (self.dnDelegate && [self.dnDelegate respondsToSelector:@selector(touchCenterButton:)]) {
        
        [self.dnDelegate touchCenterButton:sender];
    }
}

- (void)setNormalImage:(UIImage *)normalImage {
    
    _normalImage = normalImage;
    
    if (self.centerWidth <= 0 && self.centerHeight <= 0){
    //根据图片调整button的位置(默认居中，如果图片中心在tabbar的中间最上部，这个时候由于按钮是有一部分超出tabbar的，所以点击无效，要进行处理)
        self.centerWidth = normalImage.size.width;
        self.centerHeight = normalImage.size.height;
    }
    [self.centerBtn setImage:normalImage forState:UIControlStateNormal];
}

- (void)setSelectImage:(UIImage *)selectImage {
    
    _selectImage = selectImage;
    
    [self.centerBtn setImage:selectImage forState:UIControlStateNormal];
}

//处理超出区域点击无效的问题
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    if (self.hidden){
        return [super hitTest:point withEvent:event];
    }else {
        //转换坐标
        CGPoint tempPoint = [self.centerBtn convertPoint:point fromView:self];
        //判断点击的点是否在按钮区域内
        if (CGRectContainsPoint(self.centerBtn.bounds, tempPoint)){
            //返回按钮
            return self.centerBtn;
        }else {
            return [super hitTest:point withEvent:event];
        }
    }
}

@end
