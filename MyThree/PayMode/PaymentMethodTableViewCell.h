//
//  PaymentMethodTableViewCell.h
//
//  Created by Hale on 17/3/21.
//  Copyright © 2017年 Hale. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 付款方式
 */
@interface PaymentMethodTableViewCell : UITableViewCell

/**
 0支付宝支付, 1微信支付, 2余额支付
 */
@property (nonatomic, copy) void(^selectPaymentMethod)(NSInteger);

/**
 设置余额不足
 */
- (void)setupInsufficientBalance;
@end
