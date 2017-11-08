//
//  BaseNavigtionViewController.m
//  NaHu
//
//  Created by SADF on 16/12/22.
//  Copyright © 2016年 SADF. All rights reserved.
//

#import "BaseNavigtionViewController.h"

@interface BaseNavigtionViewController ()

@end

@implementation BaseNavigtionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    viewController.hidesBottomBarWhenPushed = 1;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
