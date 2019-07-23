//
//  ViewController.m
//  DNCustomTabBar
//
//  Created by zjs on 2019/5/23.
//  Copyright © 2019 zjs. All rights reserved.
//

#import "ViewController.h"

#import <CoreNFC/CoreNFC.h>

#define SCREEN_W UIScreen.mainScreen.bounds.size.width

@interface ViewController ()<NFCNDEFReaderSessionDelegate>

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
    
    
    UIButton *scanBtn = [[UIButton alloc] init];
    [scanBtn setTitle:@"开始扫描" forState:UIControlStateNormal];
    scanBtn.backgroundColor     = UIColor.blueColor;
    scanBtn.layer.cornerRadius  = 5.f;
    scanBtn.layer.masksToBounds = YES;
    scanBtn.frame = CGRectMake(100, 200, SCREEN_W - 200, 45);
    [self.view addSubview:scanBtn];
    
    [scanBtn addTarget:self action:@selector(scanForNFCAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)scanForNFCAction {
    
    NFCNDEFReaderSession *session = [[NFCNDEFReaderSession alloc] initWithDelegate:self queue:dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT) invalidateAfterFirstRead:YES];
    
    [session beginSession];
}

- (void)readerSession:(NFCNDEFReaderSession *)session didInvalidateWithError:(NSError *)error {
    
    NSLog(@"%@", error.code == 200 ? @"用户取消":@"请求超时");
    
    [session invalidateSession];
}

- (void)readerSession:(NFCNDEFReaderSession *)session didDetectNDEFs:(NSArray<NFCNDEFMessage *> *)messages {
    
    for (NFCNDEFMessage *message in messages) {
        
        for (NFCNDEFPayload *payload in message.records) {
            
            NSLog(@"Payload data = %@", payload.payload);
        }
    }
    [session invalidateSession];
}

@end
