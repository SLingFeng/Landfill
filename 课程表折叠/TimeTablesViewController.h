//
//  TimeTablesViewController.h
//  XinZiLong
//
//  Created by mac on 16/7/13.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeTablesViewController : UIViewController
@property (nonatomic, copy) NSString *navTitle;
@property (nonatomic, strong) UIPickerView *pickView;
@property (nonatomic, copy) NSString * backString;
@property (nonatomic,retain)UIButton *tabBarbutton;
@end
