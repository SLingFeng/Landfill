//
//  TZSelectView.h
//  test
//
//  Created by SADF on 16/11/7.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZSelectView : UIView
@property (nonatomic, retain) UIImagePickerController *imagePickerVc;
@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, retain) NSMutableArray *selectedPhotos;
@property (nonatomic, retain) NSMutableArray *selectedAssets;

@property (nonatomic, copy) void(^photosBlock)(NSArray *arr);

@property (nonatomic, assign) CGFloat tzHeight;
//-(instancetype)initWithVC:(UIViewController *)vc;


@end
