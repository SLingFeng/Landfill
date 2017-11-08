//
//  SelectDataPicker.h
//  test
//
//  Created by SADF on 16/11/10.
//  Copyright © 2016年 LingFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SeleCtTypeTime,
    SeleCtTypePercentage,
    SeleCtTypeMoney,
} SeleCtType;

@interface SelectDataPicker : UIView
@property (nonatomic, copy) NSMutableString * timeDate;
@property (nonatomic, copy) void (^backTimeDate)(NSString*);
-(instancetype)initWithType:(SeleCtType)type;
@end
