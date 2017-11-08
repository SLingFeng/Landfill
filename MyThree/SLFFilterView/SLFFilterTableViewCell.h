//
//  SLFFilterTableViewCell.h
//  YGB
//
//  Created by 孙凌锋 on 2017/3/23.
//  Copyright © 2017年 Hale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLFFilterTableViewCell : UITableViewCell
/**
 选中回掉
 */
@property (nonatomic, copy) void(^selectorForIndexBlock)(NSInteger);
/**
 设置内容

 @param strArr 字符串数组
 */
- (void)setupBtn:(NSArray *)strArr toSelectIndex:(int)sIndex;
@end
