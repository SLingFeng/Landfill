//
//  UIView+ViewController.m
//  qiyongchao
//
//  Created by qiyongchao on 14-5-30.
//  Copyright (c) 2014年 qiyongchao. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

- (UIViewController *)viewController {
    
    UIResponder *next = self.nextResponder;
    
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    } while (next != nil);
    
    return nil;
}
-(UIView *)deepView{
    return nil;
}
@end
