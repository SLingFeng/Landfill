//
//  ChooseTableViewCell
//
//  Created by 孙凌锋 on 2017/11/29.
//  Copyright © 2017年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseTableViewCell : UITableViewCell

@property (nonatomic,retain)MyLabel * titleLab;
//当前现实btn
@property (nonatomic, retain) NSMutableArray *btnArr;

@property (nonatomic, retain) JMProcessViewModel *ProcessViewModel;
//获取选中id
@property (nonatomic, copy) void(^selectIDBlock)(NSString *ids);
//传字典字符串 project_state yes多选  no单选
- (void)creatButton:(NSString *)str multiple:(BOOL)multiple;
/**
 根据id设置选中状态
 
 只有一个cell 可以不需要调用
 @param ids id字符串
 */
- (void)setupSelectStatus:(NSString *)ids;

/**
 展示信息

 @param str 传进参数
 */
- (void)showButton:(NSString *)str;

@end
