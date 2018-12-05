//
//  UMengShareMainView.m
//  UMengShare
//
//  Created by SADF on 16/10/14.
//  Copyright © 2016年 SADF. All rights reserved.
//

#import "ShareMainView.h"

@interface ShareMainView ()
{
    MainView * _mainView;
}
@end

@implementation ShareMainView

-(instancetype)init {
    if (self == [super init]) {
        self.frame = kScreen;
        
        UIView * backgroudView = [[UIView alloc] initWithFrame:kScreen];
        backgroudView.backgroundColor = HEXCOLORA(0x000000, 0.4);
        [self addSubview:backgroudView];
        [backgroudView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTap)]];

        MainView * mainView = [[MainView alloc] initWithFrame:CGRectMake(0, kScreenH+305, kScreenW, 305)];
        [self addSubview:mainView];
        
        kWeakSelf(weakSelf);
        mainView.cancelClick = ^() {
            [weakSelf cancelTap];
        };
        mainView.sendType = ^(SSDKPlatformType type) {
            if (weakSelf.formType) {
                [weakSelf cancelTap];
                weakSelf.formType(type);
            }
        };
//        mainView.sd_layout.bottomSpaceToView(self, -305).leftSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(305);
        _mainView = mainView;
        self.alpha = 0;
    }
    return self;
}

-(void)show {
    kWeakSelf(weakSelf);
    kWeakObj(weakOBJ, _mainView);
    [UIView animateWithDuration:0.35 animations:^{
        weakSelf.alpha = 1;
        weakOBJ.frame = CGRectMake(0, kScreenH-305, kScreenW, 305);
    }];
}

-(void)cancelTap {
    kWeakSelf(weakSelf);
    kWeakObj(weakOBJ, _mainView);
    [UIView animateWithDuration:0.35 animations:^{
        weakSelf.alpha = 0;
        weakOBJ.frame = CGRectMake(0, kScreenH+305, kScreenW, 305);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

-(void)dealloc {
    _mainView = nil;
    NSLog(@"%s", __func__);
}

@end

#pragma mark - 主视图
@implementation MainView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = HEXCOLORA(0xF0F0F0, 1);
        
        MyLabel *title = [[MyLabel alloc] initWithFontSize:32 fontColor:k232931 setText:@"通过以下方式邀请朋友参与活动"];
        [self addSubview:title];
        title.font = [SLFCommonTools pxBoldFont:32];
        title.textAlignment = NSTextAlignmentCenter;
        title.sd_layout.topSpaceToView(self, 15).leftSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(35);
        
        NSArray * type = @[@(SSDKPlatformSubTypeWechatSession),
                           @(SSDKPlatformSubTypeWechatTimeline),
                           @(SSDKPlatformSubTypeQQFriend),
                           @(SSDKPlatformSubTypeQZone),
                           @(SSDKPlatformTypeUnknown)];
        
        NSArray * titles = @[@"微信", @"朋友圈", @"QQ", @"QQ空间", @"复制链接"];
        NSArray * images = @[@"wei_icon", @"friend_bg", @"tencent_bg", @"qq_icon", @"copy_icon"];
        
        CGFloat w = (kScreenW - 20 * 3 - 39 * 2) / 4;
        CGFloat h = 90;

        for (int i=0; i<titles.count; i++) {
            float x = JGG_X(39, 20,  w, i, 4);
            float y = JGG_Y(50, 40, h, i, 4);
            ShareIconView * siv = [[ShareIconView alloc] initWithFrame:CGRectMake(x, y, w, h) title:titles[i] image:images[i]];
            NSNumber * num = type[i];
            siv.type = [num integerValue];
            [self addSubview:siv];
            kWeakSelf(weakSelf);
            siv.typeTap = ^(SSDKPlatformType type) {
                if (weakSelf.sendType) {
                    weakSelf.sendType(type);
                }
            };
        }
        
        UIButton * cancelBtn = [MyButton buttonWithType:(UIButtonTypeSystem) fontSize:32 fontColor:k999999 fontText:@"取消"];
        [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:cancelBtn];
        cancelBtn.sd_layout.heightIs(40).leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    }
    return self;
}

-(void)cancelBtnClick {
    NSLog(@"cancel");
    if (self.cancelClick) {
        self.cancelClick();
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [SLFCommonTools drawLineToHight:150 spaceForRightAndLetf:0];
}

@end

@implementation ShareIconView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(NSString *)image {
    if (self == [super initWithFrame:frame]) {
        UIImageView * iconImageView = [[UIImageView alloc] init];
        [self addSubview:iconImageView];
//        iconImageView.backgroundColor = kColorRandomly;
        [iconImageView setImage:[UIImage imageNamed:image]];
//        iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        UILabel * titleLabel = [[MyLabel alloc] initWithFontSize:22 fontColor:k000000 setText:title];
        [self addSubview:titleLabel];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        iconImageView.sd_layout.topSpaceToView(self, 0).centerXEqualToView(self).widthIs(50).heightEqualToWidth();

        titleLabel.sd_layout.topSpaceToView(iconImageView, 0).leftSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
//        self.frame = CGRectMake(0, 0, kAW(60), kAW(70));
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareTypeTap)]];
    }
    return self;
}

-(void)shareTypeTap {
    if (self.typeTap) {
        self.typeTap(self.type);
    }
}

@end
