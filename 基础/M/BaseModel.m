//
//  BaseModel.m
//  NaHu
//
//  Created by SADF on 16/11/16.
//  Copyright © 2016年 SADF. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation BaseInfoModel
+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
