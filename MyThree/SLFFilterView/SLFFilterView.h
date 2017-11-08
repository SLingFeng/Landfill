//
//  SLFFilterView.h
//
//  Created by 孙凌锋 on 2017/3/23.
//  Copyright © 2017年 Hale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLFFilterView : UIView

singleton_Interface(FilterView)
//筛选
@property (nonatomic, copy) void(^toFilter)(YGBFiterDemandModel *);
-(void)show;
- (void)reset;
@end
