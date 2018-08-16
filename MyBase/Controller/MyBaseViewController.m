//
//  BaseViewController.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "MyBaseViewController.h"
//#import "UIViewController+Cloudox.h"

@interface MyBaseViewController ()

@end

@implementation MyBaseViewController

- (void)hiddeNaviBar:(BOOL)isHidde {
    if (isHidde) {
//        [self setNavBarBgAlpha:@"0.0"];
    }else {
//        [self setNavBarBgAlpha:@"1.0"];
    }
}

//-(void)loadView {
//    [super loadView];
//    self.view.backgroundColor = [UIColor whiteColor];
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    self.pageIndex = 1;
    
    [SLFCommonTools setupSatuts:self bai:0];
    
    [self setupNavBack:1];
}

- (void)setupNavBack:(BOOL)isClaer {
    if (IS_IOS11) {
        
        NSString *backStr;
        if (isClaer) {
            backStr = @"back_icon";
        }else {
            backStr = @"white_back_icon";
        }
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:@selector(backClick)];
        self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:backStr];
        self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:backStr];
        self.navigationItem.backBarButtonItem = backItem;
    }
}

- (void)backClick {
    [self.navigationController popViewControllerAnimated:1];
}

-(void)setNavigationTitle:(NSString *)title {
    self.navigationItem.title = title;
}

-(void)pushViewController:(UIViewController *)vc {
    @autoreleasepool {
//        vc.hidesBottomBarWhenPushed = YES;
        if (self.navigationController.viewControllers.count > 0) {
            vc.hidesBottomBarWhenPushed = YES;
        }
        [self.navigationController cyl_pushViewController:vc animated:1];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:1];
}


- (void)popToViewController:(Class)vcClass {
    [self popToViewController:vcClass obj:nil];
}

- (void)popToViewController:(Class)vcClass obj:(id)obj {
//    kWeakSelf(weakSelf);
//    UINavigationController * nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    YGBFirstViewController * fvc = (YGBFirstViewController *)nav.topViewController;
//    NSLog(@"%@",fvc.navigationController.viewControllers);
//    for (MyBaseViewController * vc in fvc.navigationController.viewControllers) {
//        if ([vc isKindOfClass:vcClass]) {
//            if (self.BackBlock) {
//                weakSelf.BackBlock(obj);
//            }
//            [fvc.navigationController popToViewController:vc animated:1];
//            return;
//        }
//    }
}

-(void)dealloc {
    NSLog(@"---------------\n\rdealloc:%@\n-----------------", NSStringFromClass([self class]));
}

@end

@implementation UIViewController (MyBase)


-(void)pushViewController:(UIViewController *)vc {
    @autoreleasepool {
        //        vc.hidesBottomBarWhenPushed = YES;
        if (self.navigationController.viewControllers.count > 0) {
            vc.hidesBottomBarWhenPushed = YES;
        }
        [self.navigationController cyl_pushViewController:vc animated:1];
    }
}

@end
