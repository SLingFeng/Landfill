//
//  LFTabBrowserViewController.h
//
//  Created by 孙凌锋 on 2018/11/23.
//  Copyright © 2018 孙凌锋. All rights reserved.
//

#import "MyBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LFTabBrowserViewController : MyBaseViewController

@end
//顶部选择条
@interface LFTabTopView : UIView
/**
 被选中的btn的tag
 */
@property (assign, nonatomic) NSInteger isSelectBtn;

@property (copy, nonatomic) void(^selectBtnClick)(NSInteger tag);

-(instancetype)initWithSelectBtnArr:(NSArray *)titles;
@end

NS_ASSUME_NONNULL_END
