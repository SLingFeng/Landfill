//
//  MyCollectionView.h
//  NaHu
//
//  Created by SADF on 16/12/6.
//  Copyright © 2016年 SADF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionView : UICollectionView
//是否在加载
@property (assign, nonatomic) BOOL loading;
/**
 * @author LingFeng, 2016-06-30 14:06:26
 *
 * 下拉刷新方法
 */
@property (copy, nonatomic) void (^headerRefresh)();
/**
 * @author LingFeng, 2016-06-30 14:06:36
 *
 * 上拉刷新方法
 */
@property (copy, nonatomic) void (^footerRefresh)();

-(MJRefreshAutoNormalFooter *)footerSetup;
@end
