//
//  PersonnelCollectionViewCell.m
//  jmxc
//
//  Created by 孙凌锋 on 2017/11/16.
//  Copyright © 2017年 孙凌锋. All rights reserved.
//

#import "PersonnelCollectionViewCell.h"

@implementation PersonnelCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.logoIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"考勤组页参与班级"]];
        [self.contentView addSubview:self.logoIV];
        
        self.titleLabel = [[MyLabel alloc] initWithFontSize:22 fontColor:k666666 setText:@"人员"];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        kWEAKSELF(weakSelf);
        [self.logoIV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.top.left.offset(kMainSpace);
            make.right.offset(-kMainSpace);
            make.height.equalTo(weakSelf.logoIV.mas_width);
            make.centerX.equalTo(weakSelf.contentView);
            make.top.offset(kMainSpace);
        }];
        kViewBorderRadius(self.logoIV, self.logoIV.size.width/2, 0.1, [UIColor clearColor]);
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.logoIV.mas_bottom).offset(5);
            make.left.right.offset(0);
        }];
        
    }
    return self;
}

- (void)normalLayout {
    self.titleLabel.hidden = 0;
   
}

- (void)addLayout {
    self.logoIV.image = [UIImage imageNamed:@"考勤组页参与班级"];
    self.titleLabel.hidden = 1;
}

@end
