//
//  BaseViewController.h
//
//  Copyright © 2016年 孙凌锋. All rights reserved.
//

#import "MyBaseViewController.h"

@interface MyBaseViewController ()

@end

@implementation MyBaseViewController

-(void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [SLFCommonTools setupSatuts:self bai:1];
}

-(void)setNavigationTitle:(NSString *)title {
    self.navigationItem.title = title;
}

-(void)pushViewController:(UIViewController *)vc {
    @autoreleasepool {
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:1];
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

@end
