//
//  LFTabBrowserCollectionViewCell.m
//
//  Created by 孙凌锋 on 2018/11/23.
//  Copyright © 2018 孙凌锋. All rights reserved.
//

#import "LFTabBrowserCollectionViewCell.h"
#define kMinZoomScale 0.6f
#define kMaxZoomScale 2.0f


@implementation LFTabBrowserCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor blackColor];
        
        self.imageview = [[UIImageView alloc] init];
        self.imageview.image = kPlaceholderUserImage;
        
        [self.contentView addSubview:self.scrollview];
        
        [self addGestureRecognizer:self.doubleTap];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageview.frame = self.contentView.bounds;
    self.scrollview.frame = self.contentView.bounds;

    [self adjustFrame];
}

- (void)adjustFrame
{
    //    CGRect frame = self.scrollview.frame;
    CGRect frame = self.frame;
    //   NSLog(@"%@",NSStringFromCGRect(self.frame));
    if (self.imageview.image) {
        CGSize imageSize = self.imageview.image.size;//获得图片的size
        CGRect imageFrame = CGRectMake(0, 0, imageSize.width, imageSize.height);
//        if (YES) {//图片宽度始终==屏幕宽度(新浪微博就是这种效果)
            CGFloat ratio = frame.size.width/imageFrame.size.width;
            imageFrame.size.height = imageFrame.size.height*ratio;
            imageFrame.size.width = frame.size.width;
//        } else{
//            if (frame.size.width<=frame.size.height) {
//                //竖屏时候
//                CGFloat ratio = frame.size.width/imageFrame.size.width;
//                imageFrame.size.height = imageFrame.size.height*ratio;
//                imageFrame.size.width = frame.size.width;
//            }else{ //横屏的时候
//                CGFloat ratio = frame.size.height/imageFrame.size.height;
//                imageFrame.size.width = imageFrame.size.width*ratio;
//                imageFrame.size.height = frame.size.height;
//            }
//        }
        
        self.imageview.frame = imageFrame;
        //        NSLog(@"%@",NSStringFromCGRect(_scrollview.frame));
        //        NSLog(@"%@",NSStringFromCGRect(self.imageview.frame));
//                self.scrollview.frame = self.imageview.frame;
        self.scrollview.contentSize = self.imageview.frame.size;
        self.imageview.center = [self centerOfScrollViewContent:self.scrollview];
        
        //根据图片大小找到最大缩放等级，保证最大缩放时候，不会有黑边
        CGFloat maxScale = frame.size.height/imageFrame.size.height;
        maxScale = frame.size.width/imageFrame.size.width>maxScale?frame.size.width/imageFrame.size.width:maxScale;
        //超过了设置的最大的才算数
        maxScale = maxScale>kMaxZoomScale?maxScale:kMaxZoomScale;
        //初始化
        self.scrollview.minimumZoomScale = kMinZoomScale;
        self.scrollview.maximumZoomScale = maxScale;
        self.scrollview.zoomScale = 1.0f;
    }else{
        frame.origin = CGPointZero;
        self.imageview.frame = frame;
        //重置内容大小
        self.scrollview.contentSize = self.imageview.frame.size;
    }
    self.scrollview.contentOffset = CGPointZero;
//    self.zoomImageSize = self.imageview.frame.size;
}

- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}

- (UIScrollView *)scrollview {
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc] init];
//        _scrollview.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.showsHorizontalScrollIndicator = NO;
        [_scrollview addSubview:self.imageview];
        _scrollview.delegate = self;
        _scrollview.clipsToBounds = YES;
    }
    return _scrollview;
}

#pragma mark UIScrollViewDelegate



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageview;
}
//这里是缩放进行时调整
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    self.imageview.center = [self centerOfScrollViewContent:scrollView];
}



#pragma mark 双击

- (UITapGestureRecognizer *)doubleTap {
    if (!_doubleTap) {
        _doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        _doubleTap.numberOfTapsRequired = 2;
    }
    return _doubleTap;
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)recognizer {

    CGPoint touchPoint = [recognizer locationInView:self];
    if (self.scrollview.zoomScale <= 1.0) {
        CGFloat scaleX = touchPoint.x + self.scrollview.contentOffset.x;//需要放大的图片的X点
        CGFloat sacleY = touchPoint.y + self.scrollview.contentOffset.y;//需要放大的图片的Y点
        [self.scrollview zoomToRect:CGRectMake(scaleX, sacleY, 10, 10) animated:YES];
    } else {
        [self.scrollview setZoomScale:1.0 animated:YES]; //还原
    }
}

@end
