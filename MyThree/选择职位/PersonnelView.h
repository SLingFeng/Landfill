//
//  PersonnelView.h
//  jmxc
//
//  Created by 孙凌锋 on 2017/11/16.
//  Copyright © 2017年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonnelView : UIView

@property (nonatomic, retain) NSMutableArray *selected;

@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, copy) void(^addNew)(void);

@property (nonatomic, copy) void(^operating)(NSIndexPath * indexPath);

@end
