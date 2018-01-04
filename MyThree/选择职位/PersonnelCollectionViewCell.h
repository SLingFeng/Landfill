//
//  PersonnelCollectionViewCell.h
//  jmxc
//
//  Created by 孙凌锋 on 2017/11/16.
//  Copyright © 2017年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonnelCollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) MyLabel *titleLabel;
@property (nonatomic, retain) UIImageView *logoIV;

- (void)normalLayout;
- (void)addLayout;

@end
