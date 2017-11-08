//
//  MyMBProgressHUD.m
//  RenCaiKu
//
//  Created by mac on 16/5/31.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import "MyMBProgressHUD.h"

@interface MyMBProgressHUD ()<MBProgressHUDDelegate>

@end

static MyMBProgressHUD * HUD = nil;

@implementation MyMBProgressHUD

+(MyMBProgressHUD *)shareHUD{
    @synchronized(self){
        if (HUD == nil) {
            //重写 alloc
            HUD = [[super allocWithZone:NULL]init];
        }
        return HUD;
    }
}
//重写 alloc
+(id)allocWithZone:(struct _NSZone *)zone{
    return [self shareHUD];
}
//重写 copy
+(id)copyWithZone:(struct _NSZone *)zone{
    return self;
}

+(void)hudForText:(NSString *)text view:(UIView *)view {
    MBProgressHUD * mb = [MBProgressHUD showHUDAddedTo:view animated:YES];
    mb.mode = MBProgressHUDModeText;
//    mb.bezelView.backgroundColor = [UIColor blackColor];
//    mb.label.textColor = [UIColor whiteColor];
//    mb.detailsLabel.textColor = [UIColor whiteColor];
    mb.labelText = text;
    [mb hide:1 afterDelay:1.5];
//    [mb hideAnimated:1 afterDelay:1.5];
}

+(MBProgressHUD *)share:(MBProgressHUDMode)mode {
    MBProgressHUD * mb = [MBProgressHUD showHUDAddedTo:((UIViewController *)[[UIApplication sharedApplication].windows lastObject]) animated:YES];
//    MBProgressHUD * mb;
//    mb = [MBProgressHUD HUDForView:[UIApplication sharedApplication].keyWindow];
//    if (mb == nil) {
//        mb = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
//        mb.tag = 99999;
//    }
    mb.mode = mode;
//    mb.bezelView.backgroundColor = [UIColor blackColor];
//    mb.label.textColor = [UIColor whiteColor];
//    mb.detailsLabel.textColor = [UIColor whiteColor];
    return mb;
}

+(void)hudForText:(NSString *)text delay:(float)delay {
    [MyMBProgressHUD hideAllHubForView];
    MBProgressHUD * mb = [MyMBProgressHUD share:MBProgressHUDModeText];
    mb.labelText = text;
    [mb hide:1 afterDelay:delay];
}

+(void)hudForText:(NSString *)text {
    MBProgressHUD * mb = [MyMBProgressHUD share:MBProgressHUDModeText];
    mb.labelText = text;
    [mb hide:1 afterDelay:1];
}

+(void)hudForText:(NSString *)text call:(completionBlock)back {
    MBProgressHUD * mb = [MyMBProgressHUD share:MBProgressHUDModeText];

    mb.delegate = [MyMBProgressHUD shareHUD];
    mb.labelText = text;
    [mb hide:1 afterDelay:1];
    
    [MyMBProgressHUD shareHUD].completion = ^() {
        if (back) {
            back();
        }
    };
}
+(void)hudForText:(NSString *)text delay:(float)delay call:(completionBlock)back {
    MBProgressHUD * mb = [MyMBProgressHUD share:MBProgressHUDModeText];
    
    mb.delegate = [MyMBProgressHUD shareHUD];
    mb.labelText = text;
    [mb hide:1 afterDelay:delay];
    
    [MyMBProgressHUD shareHUD].completion = ^() {
        if (back) {
            back();
        }
    };
}

+(MBProgressHUD *)hudLoadProgress:(NSProgress *)progress text:(NSString *)text view:(UIView *)view {
    MBProgressHUD * mb = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    mb.bezelView.backgroundColor = [UIColor blackColor];
//    mb.label.textColor = [UIColor whiteColor];
//    mb.detailsLabel.textColor = [UIColor whiteColor];
    mb.mode = MBProgressHUDModeDeterminate;
    mb.labelText = text;
//    for (id obj in mb.bezelView.subviews) {
//        if ([obj isKindOfClass:[MBRoundProgressView class]]) {
//            MBRoundProgressView *pv = (MBRoundProgressView *)obj;
//            pv.progressTintColor = [UIColor whiteColor];
//            pv.backgroundTintColor = [UIColor whiteColor];
//        }
//    }

//    for (id obj in mb.bezelView.subviews) {
//        if ([obj isKindOfClass:[MBBarProgressView class]]) {
//            MBBarProgressView *pv = (MBBarProgressView *)obj;
//            pv.backgroundColor = [UIColor whiteColor];
//            pv.progressColor = [UIColor whiteColor];
//            pv.progressRemainingColor = [UIColor redColor];
//        }
//    }
    
//    if (progress) {
//        mb.progressObject = progress;
//    }
    return mb;
}

+(void)hudShowLoadForText:(NSString *)text {
//    UIWindow * window = [[UIApplication sharedApplication].windows lastObject];
//    MBProgressHUD * mb = [MBProgressHUD showHUDAddedTo:window animated:YES];
    MBProgressHUD * mb = [MyMBProgressHUD share:MBProgressHUDModeIndeterminate];
//    mb.mode = MBProgressHUDModeIndeterminate;
//    mb.bezelView.backgroundColor = [UIColor blackColor];
//    for (id obj in mb.bezelView.subviews) {
//        if ([obj isKindOfClass:[UIActivityIndicatorView class]]) {
//            ((UIActivityIndicatorView *)obj).activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
//        }
//    }
//    mb.label.textColor = [UIColor whiteColor];
//    mb.detailsLabel.textColor = [UIColor whiteColor];
    mb.labelText = text;
    [mb hide:1 afterDelay:20];
    [MyMBProgressHUD shareHUD].hud = mb;
}

+(void)hudLoadToText:(NSString *)text {
    MBProgressHUD * mb = [MyMBProgressHUD shareHUD].hud;
    mb.mode = MBProgressHUDModeText;
//    mb.bezelView.backgroundColor = [UIColor blackColor];
//    mb.label.textColor = [UIColor whiteColor];
//    mb.detailsLabel.textColor = [UIColor whiteColor];
//    mb.label.text = text;
    [mb hide:1 afterDelay:1];
}

+(void)hudAlwaysLoadToText:(NSString *)text {
    MBProgressHUD * mb = [MyMBProgressHUD shareHUD].hud;
    mb.mode = MBProgressHUDModeText;
//    mb.bezelView.backgroundColor = [UIColor blackColor];
//    mb.label.textColor = [UIColor whiteColor];
//    mb.detailsLabel.textColor = [UIColor whiteColor];
    mb.labelText = text;
    [mb hide:1 afterDelay:20];
    [MyMBProgressHUD shareHUD].hud = mb;
}
+(void)hideShareHub {
    MBProgressHUD * mb = [MyMBProgressHUD shareHUD].hud;
    [mb hide:1];
}
+(void)hideAllHubForView {
    UIWindow * window = [[UIApplication sharedApplication].windows lastObject];
    NSArray * hubs = [MBProgressHUD allHUDsForView:window];
    for (MBProgressHUD * hub in hubs) {
        [hub hide:1];
    }
}

-(void)hudWasHidden:(MBProgressHUD *)hud {
    if ([MyMBProgressHUD shareHUD].completion) {
        [MyMBProgressHUD shareHUD].completion();
    }
}


@end
