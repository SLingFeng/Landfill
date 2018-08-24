//
//  MyButton+ImageTitleSpacing.m
//  tanglianai
//
//  Created by 孙凌锋 on 2018/8/24.
//  Copyright © 2018年 孙凌锋. All rights reserved.
//

#import "MyButton+ImageTitleSpacing.h"

@implementation MyButton (ImageTitleSpacing)

- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style

                        imageTitleSpace:(CGFloat)space

{
    
    //    self.backgroundColor = [UIColor cyanColor];
    
    /**
     
     *  前置知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     
     */
    
    // 1. 得到imageView和titleLabel的宽、高
    
    CGFloat imageWith = [UIDevice currentDevice].systemVersion.floatValue >= 8.0?self.imageView.intrinsicContentSize.width:self.imageView.frame.size.width;
    
    CGFloat imageHeight = [UIDevice currentDevice].systemVersion.floatValue >= 8.0?self.imageView.intrinsicContentSize.height:self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    
    CGFloat labelHeight = 0.0;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        
        labelHeight = self.titleLabel.intrinsicContentSize.height;
        
    } else {
        
        labelWidth = self.titleLabel.frame.size.width;
        
        labelHeight = self.titleLabel.frame.size.height;
        
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    
    switch (style) {
            
            case MKButtonEdgeInsetsStyleTop:
            
        {
            
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
            
        }
            
            break;
            
            case MKButtonEdgeInsetsStyleLeft:
            
        {
            
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
            
        }
            
            break;
            
            case MKButtonEdgeInsetsStyleBottom:
            
        {
            
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
            
        }
            
            break;
            
            case MKButtonEdgeInsetsStyleRight:
            
        {
            
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
            
        }
            
            break;
            
        default:
            
            break;
            
    }
    
    // 4. 赋值
    
    self.titleEdgeInsets = labelEdgeInsets;
    
    self.imageEdgeInsets = imageEdgeInsets;
    
}

//作者：用心在飞
//链接：https://www.jianshu.com/p/12bc4414a0b7
//來源：简书
//简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。

@end
