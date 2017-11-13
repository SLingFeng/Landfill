//
//  MyBaseCollectionViewController.m
//
//  Created by 孙凌锋 on 2017/6/9.
//  Copyright © 2017年 孙凌锋. All rights reserved.
//

#import "MyBaseCollectionViewController.h"
#import "MyCollectionView.h"

@interface MyBaseCollectionViewController ()

@end

@implementation MyBaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)neededCollectionViewDirection:(UICollectionViewScrollDirection)direction {
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:(direction)];
    
    self.collectionView = [[MyCollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [SLFCommonTools getBackgroundColor];
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.automaticallyAdjustsScrollViewInsets = NO;

}

@end
