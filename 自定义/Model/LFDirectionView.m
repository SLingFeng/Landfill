//
//  LFDirectionView.m
//  孙凌锋
//
//  Created by 孙凌锋 on 2020/5/19.
//  Copyright © 2020 孙凌锋. All rights reserved.
//

#import "LFDirectionView.h"

@implementation LFDirectionView


- (instancetype)initWith:(UIView *)one two:(UIView *)two direction:(LFDirection)direction {
    self = [super init];
    if (self) {
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
        
        if (one && two) {
            [self addSubview:one];
            [self addSubview:two];
            
            if (direction == LFDirectionTopBottom) {
                
                [one mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(one.frame.size);
                    make.top.offset(0);
                    make.centerX.equalTo(self);
                }];
                
                [two mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(two.frame.size);
                    make.bottom.equalTo(self.mas_bottom).offset(0);
                    make.centerX.equalTo(self);
                }];
                
            }else if (direction == LFDirectionLeftRight) {
                
                [one mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(one.frame.size);
                    make.left.offset(0);
                    make.centerY.equalTo(self);
                }];
                
                [two mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(two.frame.size);
                    make.right.offset(0);
                    make.centerY.equalTo(one);
                }];
                
            }
        }
        
        
        
    }
    return self;
}

- (void)tap {
    if (self.tapBlock) {
        self.tapBlock();
    }
}


@end
