//
//  ViewController.m
//  DNCustomTabBar
//
//  Created by zjs on 2019/5/23.
//  Copyright © 2019 zjs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat redValue   = (arc4random() % 255) / 255.0;
    CGFloat greenValue = (arc4random() % 255) / 255.0;
    CGFloat blueValue  = (arc4random() % 255) / 255.0;
    
    self.view.backgroundColor = [UIColor colorWithRed:redValue
                                                green:greenValue
                                                 blue:blueValue
                                                alpha:1.0];
    
    self.navigationItem.title = self.navigationController.tabBarItem.title;
    // Do any additional setup after loading the view.
}

@end
