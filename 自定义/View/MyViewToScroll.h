//
//  MyViewToScroll.h
//  RenCaiKu
//
//  Created by mac on 16/6/20.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewToScroll : UIView
@property (copy, nonatomic) void(^click)(NSInteger tag);
@end
