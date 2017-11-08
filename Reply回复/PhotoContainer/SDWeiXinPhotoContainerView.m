//
//  SDWeiXinPhotoContainerView.m
//  SDAutoLayout 测试 Demo
//
//  Created by gsd on 15/12/23.
//  Copyright © 2015年 gsd. All rights reserved.
//


/*
 
 *********************************************************************************
 *
 * GSD_WeiXin
 *
 * QQ交流群: 459274049
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios/GSD_WeiXin
 * 新浪微博:GSD_iOS
 *
 * 此“高仿微信”用到了很高效方便的自动布局库SDAutoLayout（一行代码搞定自动布局）
 * SDAutoLayout地址：https://github.com/gsdios/SDAutoLayout
 * SDAutoLayout视频教程：http://www.letv.com/ptv/vplay/24038772.html
 * SDAutoLayout用法示例：https://github.com/gsdios/SDAutoLayout/blob/master/README.md
 *
 *********************************************************************************
 
 */

#import "SDWeiXinPhotoContainerView.h"

#import "UIView+SDAutoLayout.h"

#import "SDPhotoBrowser.h"

@interface SDWeiXinPhotoContainerView () <SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *imageViewsArray;

@end

@implementation SDWeiXinPhotoContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.imageViewsArray = [temp copy];
}


- (void)setPicPathStringsArray:(NSArray *)picPathStringsArray
{
    _picPathStringsArray = picPathStringsArray;
    
    for (long i = _picPathStringsArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (_picPathStringsArray.count == 0) {
        self.height_sd = 0;
        self.fixedHeight = @(0);
        return;
    }
    CGFloat www = 0;
    if (self.type == SDWeiXinPhotoPingLun) {
        if (ISiPhone5) {
            www = [CommonTools widthScale4_3:kScreenW/3 - 30 - 7];
        }else if (ISiPhone6) {
            
        }else {
            www = [CommonTools widthScale4_3:kScreenW/3 - 30 - 15];
        }
    }else {
        CGFloat w = 75;
        if (ISiPhone5) {
            www = [CommonTools widthScale4_3:(kScreenW-w)/3 - 30 - 7];
        }else if (ISiPhone6) {
            
        }else {
            www = [CommonTools widthScale4_3:(kScreenW-w)/3 - 30 - 15];
        }

    }
    
    CGFloat itemW = www;//[self itemWidthForPicPathArray:_picPathStringsArray];
    CGFloat itemH = [CommonTools heightScale4_3:itemW];
//    if (_picPathStringsArray.count == 1) {
//        UIImage *image = [UIImage imageNamed:_picPathStringsArray.firstObject];
//        if (image.size.width) {
//            itemH = image.size.height / image.size.width * itemW;
//        }
//    } else {
//        itemH = itemW;
//    }
    long perRowItemCount = 3;//[self perRowItemCountForPicPathArray:_picPathStringsArray];
    CGFloat margin = 6;
    
    if (self.type == SDWeiXinPhotoPingLun) {
        [_picPathStringsArray enumerateObjectsUsingBlock:^(ChargePileCommentPicModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            long columnIndex = idx % perRowItemCount;
            long rowIndex = idx / perRowItemCount;
            UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
            imageView.hidden = NO;
            //        imageView.image = [UIImage imageNamed:obj];
            [imageView sd_setImageWithURL:CommentPile(obj.NCOSmallpic) placeholderImage:kPlaceholderImage];
            imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
        }];
    }else if (self.type == SDWeiXinPhotoXiangQingFuJin) {
        [_picPathStringsArray enumerateObjectsUsingBlock:^(ChargePileDetailLandmarkPicModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            long columnIndex = idx % perRowItemCount;
            long rowIndex = idx / perRowItemCount;
            UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
            imageView.hidden = NO;
            //        imageView.image = [UIImage imageNamed:obj];
            [imageView sd_setImageWithURL:CommentPile(obj.NCPSmallpic) placeholderImage:kPlaceholderImage];
            imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
        }];
    }else {
        [_picPathStringsArray enumerateObjectsUsingBlock:^(ChargePileDetailPicModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            long columnIndex = idx % perRowItemCount;
            long rowIndex = idx / perRowItemCount;
            UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
            imageView.hidden = NO;
            //        imageView.image = [UIImage imageNamed:obj];
            [imageView sd_setImageWithURL:CommentPile(obj.NLSmallpic) placeholderImage:kPlaceholderImage];
            imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
        }];
    }
    
    
    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
    int columnCount = ceilf(_picPathStringsArray.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
//    CGFloat h = [CommonTools heightScale4_3:w];
    self.width_sd = w;
    self.height_sd = h;
    
    self.fixedHeight = @(h);
    self.fixedWidth = @(w);
}

#pragma mark - private actions

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = self.picPathStringsArray.count;
    browser.delegate = self;
    [browser show];
}

- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    if (array.count == 1) {
        return 120;
    } else {
        CGFloat w = [UIScreen mainScreen].bounds.size.width > 320 ? 80 : 70;
        return w;
    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count < 3) {
        return array.count;
    } else if (array.count <= 4) {
        return 2;
    } else {
        return 3;
    }
}


#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    if (self.type == SDWeiXinPhotoPingLun) {
        ChargePileCommentPicModel *temp = self.picPathStringsArray[index];
        return CommentPile(temp.NCOPPic);
    }else if (self.type == SDWeiXinPhotoXiangQingFuJin) {
        ChargePileDetailLandmarkPicModel *temp = self.picPathStringsArray[index];
        return CommentPile(temp.NCPPic);
    }else {
        ChargePileDetailPicModel *temp = self.picPathStringsArray[index];
        return CommentPile(temp.NLPic);
    }
    
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}

@end
