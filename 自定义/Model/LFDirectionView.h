//
//  LFDirectionView.h
//  孙凌锋
//
//  Created by 孙凌锋 on 2020/5/19.
//  Copyright © 2020 孙凌锋. All rights reserved.
//  两个view合一个view

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LFDirectionTopBottom,
    LFDirectionLeftRight,
    
} LFDirection;

@interface LFDirectionView : UIView



@property (nonatomic, copy) void(^tapBlock)(void);


- (instancetype)initWith:(UIView *)one two:(UIView *)two direction:(LFDirection)direction;

@end

NS_ASSUME_NONNULL_END
