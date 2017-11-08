//
//  MyTableView.h
//  RenCaiKu
//
//  Created by mac on 16/6/14.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableView : UITableView
//是否在加载
@property (assign, nonatomic) BOOL loading;
/**
 * @author LingFeng, 2016-08-17 14:08:02
 *
 * 加载失败的文字
 */
@property (copy, nonatomic) NSString * loadTitle;
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
-(MJRefreshNormalHeader *)headerSetup;
-(MJRefreshAutoNormalFooter *)footerSetup;
@end
