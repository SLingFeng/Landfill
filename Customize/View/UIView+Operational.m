//
//  UIView+Operational.m
//  gxw
//
//  Created by 孙凌锋 on 2018/9/21.
//  Copyright © 2018年 孙凌锋. All rights reserved.
//

#import "UIView+Operational.h"


@interface UIView ()

@end
@implementation UIView (Operational)
//------- 添加属性 -------//
static void *cq_viewTappedBlockKey = &cq_viewTappedBlockKey;

static void *cq_subViewBlockKey = &cq_subViewBlockKey;

static void *lf_ViewTappedIDBlockKey = &lf_ViewTappedIDBlockKey;

static void *lF_TapObjIDBlockKey = &lF_TapObjIDBlockKey;

static void *tapGestureKey = &tapGestureKey;



- (CQ_ViewTappedBlock)cq_viewTappedBlock {
    return objc_getAssociatedObject(self, &cq_viewTappedBlockKey);
}
- (void)setCq_viewTappedBlock:(CQ_ViewTappedBlock)cq_viewTappedBlock {
    objc_setAssociatedObject(self, &cq_viewTappedBlockKey, cq_viewTappedBlock, OBJC_ASSOCIATION_COPY);
}
/**
 与单击手势绑定的block
 
 @param tappedBlock 单击手势事件回调的block
 */
- (void)cq_whenTapped:(void(^)(void))tappedBlock {
    self.cq_viewTappedBlock = tappedBlock;
    self.userInteractionEnabled = 1;
//    for (id tap in self.gestureRecognizers) {
//        if ([tap isKindOfClass:[UITapGestureRecognizer class]]) {
//            [self removeGestureRecognizer:tap];
//        }
//    }
    if (tappedBlock) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
        [self addGestureRecognizer:tapGesture];

    }else {
        [self removeGestureRecognizer:self.tapGesture];
    }
}
// 单击view
- (void)viewTapped {
    if (self.cq_viewTappedBlock) {
        self.cq_viewTappedBlock();
    }
}

- (UITapGestureRecognizer *)tapGesture {
    return objc_getAssociatedObject(self, &tapGestureKey);
}

- (void)setTapGesture:(UITapGestureRecognizer *)tapGesture {
    objc_setAssociatedObject(self, &tapGestureKey, tapGesture, OBJC_ASSOCIATION_COPY);
}

- (CQ_SubViewBlock)cq_subViewBlock {
    return objc_getAssociatedObject(self, &cq_subViewBlockKey);
}

- (void)setCq_subViewBlock:(CQ_SubViewBlock)cq_subViewBlock {
    objc_setAssociatedObject(self, &cq_subViewBlockKey, cq_subViewBlock, OBJC_ASSOCIATION_COPY);
}


- (LF_ViewTappedIDBlock)lf_ViewTappedIDBlock {
    return objc_getAssociatedObject(self, &lf_ViewTappedIDBlockKey);
}

- (void)setLf_ViewTappedIDBlock:(LF_ViewTappedIDBlock)lf_ViewTappedIDBlock {
    objc_setAssociatedObject(self, &lf_ViewTappedIDBlockKey, lf_ViewTappedIDBlock, OBJC_ASSOCIATION_COPY);
}


- (LF_TapObjIDBlock)lF_TapObjIDBlock {
    return objc_getAssociatedObject(self, &lF_TapObjIDBlockKey);
}

- (void)setLF_TapObjIDBlock:(LF_TapObjIDBlock)lF_TapObjIDBlock {
    objc_setAssociatedObject(self, &lF_TapObjIDBlockKey, lF_TapObjIDBlock, OBJC_ASSOCIATION_COPY);
}





@end
