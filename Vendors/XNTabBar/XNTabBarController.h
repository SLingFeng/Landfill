//
//  XNTabBarController.h
//
//  Created by neng on 14-6-19.
//  Copyright (c) 2014年 neng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XNTabBarController : UITabBarController

@property (nonatomic, retain) NSArray<NSString *> * imageName;
@property (nonatomic, retain) NSArray<NSString *> * imageNameSel;
@property (nonatomic, retain) NSArray<NSString *> * titles;
-(void)setBarBtn;
@end
