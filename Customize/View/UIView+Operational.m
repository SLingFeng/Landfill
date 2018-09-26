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
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    [self addGestureRecognizer:tapGesture];
}
// 单击view
- (void)viewTapped {
    if (self.cq_viewTappedBlock) {
        self.cq_viewTappedBlock();
    }
}


- (CQ_SubViewBlock)cq_subViewBlock {
    return objc_getAssociatedObject(self, &cq_subViewBlockKey);
}

- (void)setCq_subViewBlock:(CQ_SubViewBlock)cq_subViewBlock {
    objc_setAssociatedObject(self, &cq_subViewBlockKey, cq_subViewBlock, OBJC_ASSOCIATION_COPY);

}




@end
