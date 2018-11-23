//
//  LFTabBrowserCollectionViewCell.h
//
//  Created by 孙凌锋 on 2018/11/23.
//  Copyright © 2018 孙凌锋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LFTabBrowserCollectionViewCell : UICollectionViewCell <UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *scrollview;

@property (nonatomic, retain) UIImageView *imageview;

@property (nonatomic, retain) UITapGestureRecognizer *doubleTap;

@end

NS_ASSUME_NONNULL_END
