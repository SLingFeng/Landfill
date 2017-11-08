//
//  UserInfoModel.h
//  NaHu
//
//  Created by SADF on 16/11/17.
//  Copyright © 2016年 SADF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : BaseInfoModel
@property (nonatomic, assign) NSInteger NUId;
@property (nonatomic, copy) NSString * NUType;
@property (nonatomic, copy) NSString * NUNick_name;
@property (nonatomic, copy) NSString * NUName;
@property (nonatomic, copy) NSString * NUPhoto;
@property (nonatomic, copy) NSString * NUSmall_photo;
@end
