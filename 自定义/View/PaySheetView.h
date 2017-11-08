//
//  PaySheetView.h
//  NaHu
//
//  Created by SADF on 16/11/21.
//  Copyright © 2016年 SADF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaySheetView : UIView
@property (nonatomic, copy) void(^click)(NSInteger);
-(void)show;
@end

@interface PaySheetInfoView : UIView
@property (nonatomic, copy) void(^btnClick)(NSInteger);
@end
