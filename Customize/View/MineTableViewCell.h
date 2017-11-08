//
//  MineTableViewCell.h
//  lieyi
//
//  Created by SADF on 17/1/6.
//  Copyright © 2017年 LingFeng. All rights reserved.
//

#import "MyBaseTableViewCell.h"

@interface MineTableViewCell : UITableViewCell
@property (nonatomic, retain) MyLabel * title;
@property (nonatomic, retain) BaseTextField *textFiled;
//@property (nonatomic, retain) UIImageView * leftIV;
//@property (nonatomic, retain) UIImageView * rightIV;
@end

@interface MyProfileTableViewCell : UITableViewCell
@property (nonatomic, retain) MyLabel * titleLabel;
@property (nonatomic, retain) BaseTextField * textField;
@property (nonatomic, retain) MyLabel * contentLabel;

/**
 显示输入框
 */
-(void)setupTextFieldLayout;
/**
 显示副标题
 */
-(void)setupContetnLayout;
@end
