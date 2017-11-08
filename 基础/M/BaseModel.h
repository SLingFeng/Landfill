//
//  BaseModel.h
//  NaHu
//
//  Created by SADF on 16/11/16.
//  Copyright © 2016年 SADF. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BaseModel : JSONModel
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString<Optional> * tips;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, assign) BOOL result;
@end

@interface BaseInfoModel : JSONModel

@end
