//
//  BaseViewController.m
//  NaHu
//
//  Created by SADF on 16/12/20.
//  Copyright © 2016年 SADF. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)dealloc {
    NSLog(@"\n\rdealloc:%@\n\r", NSStringFromClass([self class]));
}

@end
