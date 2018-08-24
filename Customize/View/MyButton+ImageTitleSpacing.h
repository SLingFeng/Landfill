//
//  MyButton+ImageTitleSpacing.h
//  tanglianai
//
//  Created by 孙凌锋 on 2018/8/24.
//  Copyright © 2018年 孙凌锋. All rights reserved.
//

#import "MyButton.h"


typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {

MKButtonEdgeInsetsStyleTop, // image在上，label在下

MKButtonEdgeInsetsStyleLeft, // image在左，label在右

MKButtonEdgeInsetsStyleBottom, // image在下，label在上

MKButtonEdgeInsetsStyleRight // image在右，label在左

};


@interface MyButton (ImageTitleSpacing)

/**
 
 *  设置button的titleLabel和imageView的布局样式，及间距
 
 *
 
 *  @param style titleLabel和imageView的布局样式
 
 *  @param space titleLabel和imageView的间距
 
 */

- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;

@end
