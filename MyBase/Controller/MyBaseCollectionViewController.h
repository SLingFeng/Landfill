//
//  MyBaseCollectionViewController.h
//
//  Created by 孙凌锋 on 2017/6/9.
//  Copyright © 2017年 孙凌锋. All rights reserved.
//

#import "MyBaseViewController.h"

@interface MyBaseCollectionViewController : MyBaseViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UICollectionView *collectionView;

-(void)neededCollectionViewDirection:(UICollectionViewScrollDirection)direction;

@end
