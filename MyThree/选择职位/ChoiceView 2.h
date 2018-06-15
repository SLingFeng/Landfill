//
//  MultipleChoiceView.h
//  jmxc
//
//  Created by 孙凌锋 on 2017/11/30.
//  Copyright © 2017年 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoiceView : UIView

//当前现实btn
@property (nonatomic, retain) NSMutableArray *btnArr;
//下面传字典字符串 project_state
//单选
- (void)setupRadioSubView:(NSMutableArray *)str;
//多选
- (void)setupMultipleSubView:(NSMutableArray *)str;

- (void)setupSubView:(NSMutableArray *)arr multiple:(NSInteger)multiple;
//获取选中id
- (NSString *)getSelectID;
@property (nonatomic, copy) void(^selectIDBlock)(NSString *ids);

/**
 根据id设置选中状态

 只有一个cell 可以不需要调用
 @param ids id字符串
 */
- (void)setupSelectStatus:(NSString *)ids;
@end
