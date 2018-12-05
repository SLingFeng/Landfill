//
//  UMengShareMainView.h
//  UMengShare
//
//  Created by SADF on 16/10/14.
//  Copyright © 2016年 SADF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>

@interface ShareMainView : UIView
-(void)show;
@property (copy, nonatomic) void(^formType)(SSDKPlatformType);
@end

@interface MainView : UIView
@property (copy, nonatomic) void(^cancelClick)(void);
@property (copy, nonatomic) void(^sendType)(SSDKPlatformType);
@end

@interface ShareIconView : UIView
@property (assign, nonatomic) SSDKPlatformType type;
@property (copy, nonatomic) void(^typeTap)(SSDKPlatformType);
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)image;
@end
