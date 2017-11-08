//
//  PhotoSheetView.h
//  NaHu
//
//  Created by SADF on 16/11/18.
//  Copyright © 2016年 SADF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoSheetView : UIView
@property (nonatomic, copy) void(^click)(NSInteger);
-(void)show;
@end

@interface PhotoMainView : UIView
@property (nonatomic, copy) void(^btnClick)(NSInteger);
@end
